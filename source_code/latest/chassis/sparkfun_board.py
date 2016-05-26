'''
Created on May 22, 2016

@author: satia
'''
from robotcar import RobotCar 
from hbridge_sparkfun_tb6612 import HBridge_SparkFun_TB6612

class Sparkfun(RobotCar):
    def __init__(self):
        self.h_ridge = HBridge_SparkFun_TB6612() 
        self.h_ridge.disable_motors(False) 
 
    
    
    def enable_en(self):
        print 'enable engine'
        
    
    def disable_en(self):
        print 'enable engine'
        
    
    def go_forward(self, speed = 0.5): 
        print "go_forward" 
        self.h_ridge.disable_motors(False) 
        self.h_ridge.drive(speed,speed) 
 
 
    def go_backward(self, speed = 0.5): 
        print "go_backward" 
        self.h_ridge.disable_motors(False) 
        self.h_ridge.drive(-1*speed,-1*speed) 
 
 
    def turn_left(self, speed = 0.2, angle=0): 
        print "turn_left" 
        self.h_ridge.disable_motors(False) 
        self.h_ridge.drive(0,speed) 
 
 
    def turn_right(self, speed = 0.2, angle=0): 
        print "turn_right" 
        self.h_ridge.disable_motors(False) 
        self.h_ridge.drive(speed,0) 
 
 
    def stop_now(self): 
        print "stop_now" 
        self.h_ridge.brake(True, True) 
 
 
    def stop_gradually(self): 
        print "going to stop" 
        self.h_ridge.disable_motors() 
