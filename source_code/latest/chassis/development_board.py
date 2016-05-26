'''
Created on May 22, 2016

@author: satia
'''
import sys
import mraa
import time

from robotcar import RobotCar 

class DevBoard(RobotCar):
    def __init__(self):
        
        # A
        print "init...."
        self._enA = mraa.Gpio(3)
        self._enA.dir(mraa.DIR_OUT)
                
        self._dirA0 = mraa.Gpio(2)
        self._dirA0.dir(mraa.DIR_OUT)
                
        self._dirA1 = mraa.Gpio(4)
        self._dirA1.dir(mraa.DIR_OUT)
        
        # B
        self._enB = mraa.Gpio(5)
        self._enB.dir(mraa.DIR_OUT)
        
        self._dirB0 = mraa.Gpio(6)
        self._dirB0.dir(mraa.DIR_OUT) 
               
        self._dirB1 = mraa.Gpio(7)
        self._dirB1.dir(mraa.DIR_OUT)
    
    def enable_en(self):
        print 'enable Car'
        self._enA.write(1)
        self._enB.write(1)
    
    def disable_en(self):
        self._enA.write(0)
        self._enB.write(0)
    
    
    def go_backward(self, speed = 0.5): 
        self._dirA0.write(0)
        self._dirA1.write(1)
        
        self._dirB0.write(0)
        self._dirB1.write(1)
        
    def go_forward(self, speed = 0.5): 
        self._dirA0.write(1)
        self._dirA1.write(0)
        
        self._dirB0.write(1)
        self._dirB1.write(0)
    
    def _get_dir(self):
        if self._dirA0.read() == 1 and self._dirA1.read() == 0 and self._dirB0.read() == 1 and self._dirB1.read() == 0:
            return 'forward'
        if self._dirA0.read() == 0 and self._dirA1.read() == 1 and self._dirB0.read() == 0 and self._dirB1.read() == 1:
            return 'backward'
        return 'stop'
        
    
    
        
    def turn_left(self, speed = 0.2, angle=0): 
        print "turn left"
        
        dir = self._get_dir()
        self._dirA0.write(1)
        self._dirA1.write(0)
        
        self._dirB0.write(0)
        self._dirB1.write(1)
        time.sleep(0.1)
        if dir == 'forward':
            self.go_forward()
        elif dir == 'backward':
            self.go_backward()
        else:
            self.stop_now()
    
    def turn_right(self, speed = 0.2, angle=0):
        print "turn right"
        dir = self._get_dir()
        self._dirA0.write(0)
        self._dirA1.write(1)
        
        self._dirB0.write(1)
        self._dirB1.write(0)
        time.sleep(0.1)
        if dir == 'forward':
            self.go_forward()
        elif dir == 'backward':
            self.go_backward()
        else:
            self.stop_now()
    
    def stop_now(self): 
        print "stop"
        self._dirA0.write(1)
        self._dirA1.write(1)
        
        self._dirB0.write(1)
        self._dirB1.write(1)
    
    def stop_gradually(self):
        print "going to stop"
        self._dirA0.write(0)
        self._dirA1.write(0)
        
        self._dirB0.write(0)
        self._dirB1.write(0)  