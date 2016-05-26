'''
Created on May 22, 2016

@author: satia
'''

from abc import *
class RobotCar(object):
    __metaclass__ = ABCMeta
    def __init__(self):
        pass
    @abstractmethod
    def enable_en(self):
        raise NotImplementedError
        
    @abstractmethod
    def disable_en(self):
        raise NotImplementedError
        
    @abstractmethod
    def go_forward(self, speed = 0.5): 
        raise NotImplementedError
 
    @abstractmethod
    def go_backward(self, speed = 0.5): 
        raise NotImplementedError
 
    @abstractmethod
    def turn_left(self, speed = 0.2, angle=0): 
        raise NotImplementedError
 
    @abstractmethod
    def turn_right(self, speed = 0.2, angle=0): 
        raise NotImplementedError
 
    @abstractmethod
    def stop_now(self): 
        raise NotImplementedError
 
    @abstractmethod
    def stop_gradually(self): 
        raise NotImplementedError
