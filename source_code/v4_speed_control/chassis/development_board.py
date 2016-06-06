'''
Created on May 22, 2016

@author: satia
'''
import sys
import mraa
import time

from robotcar import RobotCar 

class DevBoard(RobotCar):
    pin_mtr_en_a = 5
    pin_mtr_a_0 = 2     
    pin_mtr_a_1 = 3     
    pin_mtr_en_b = 6
    pin_mtr_b_0 = 7     
    pin_mtr_b_1 = 8
    speed = 0.5
    def __init__(self):
        # A
        print "init...."
        self._enA = mraa.Pwm(self.pin_mtr_en_a)
        self._enA.period_us(1000)
        self._enA.enable(True)
	self._enA.write(0.0)

        self._sideA_0 = mraa.Gpio(self.pin_mtr_a_0)
        self._sideA_0.dir(mraa.DIR_OUT)

        self._sideA_1 = mraa.Gpio(self.pin_mtr_a_1)
        self._sideA_1.dir(mraa.DIR_OUT)

        # B
        self._enB = mraa.Pwm(self.pin_mtr_en_b)
        self._enB.period_us(1000)
        self._enB.enable(True)
	self._enB.write(0.0)
       
        self._sideB_0 = mraa.Gpio(self.pin_mtr_b_0)
        self._sideB_0.dir(mraa.DIR_OUT)

        self._sideB_1 = mraa.Gpio(self.pin_mtr_b_1)
        self._sideB_1.dir(mraa.DIR_OUT)
    
    def enable_en(self):
        print 'enable Car'
        self._enA.write(self.speed)
        self._enB.write(self.speed)
    
    def disable_en(self):
        self._enA.write(0)
        self._enB.write(0)
    
    
    def go_backward(self, speed = 0.5): 
        self.speed = speed
        self._enA.write(speed)
        self._enB.write(speed)

        self._sideA_0.write(0)
        self._sideA_1.write(1)
        
        self._sideB_0.write(0)
        self._sideB_1.write(1)
        
    def go_forward(self, speed = 0.5): 
        self.speed = speed
        self._enA.write(speed)
        self._enB.write(speed)

        self._sideA_0.write(1)
        self._sideA_1.write(0)
        
        self._sideB_0.write(1)
        self._sideB_1.write(0)
    
    def _get_dir(self):
        if self._sideA_0.read() == 1 and self._sideA_1.read() == 0 and self._sideB_0.read() == 1 and self._sideB_1.read() == 0:
            return 'forward'
        if self._sideA_0.read() == 0 and self._sideA_1.read() == 1 and self._sideB_0.read() == 0 and self._sideB_1.read() == 1:
            return 'backward'
        return 'stop'
        
    def turn_left(self, speed = 0.5, angle=0): 
        print "turn left"
        self._enA.write(speed)
        self._enB.write(speed)
        
        dir = self._get_dir()
        self._sideA_0.write(1)
        self._sideA_1.write(0)
        
        self._sideB_0.write(0)
        self._sideB_1.write(1)
    
    def turn_right(self, speed = 0.5, angle=0):
        print "turn right"
        self._enA.write(speed)
        self._enB.write(speed)

        dir = self._get_dir()
        self._sideA_0.write(0)
        self._sideA_1.write(1)
        
        self._sideB_0.write(1)
        self._sideB_1.write(0)
    
    def stop_now(self): 
        print "stop"
        self._sideA_0.write(1)
        self._sideA_1.write(1)
        
        self._sideB_0.write(1)
        self._sideB_1.write(1)
    
    def stop_gradually(self):
        print "going to stop"
        self._sideA_0.write(0)
        self._sideA_1.write(0)
        
        self._sideB_0.write(0)
        self._sideB_1.write(0)  
