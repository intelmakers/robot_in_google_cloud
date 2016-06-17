#!/usr/bin/env python

import os
import time
import BaseHTTPServer
import socket

from camera.camera2D import Camera
from servo.servo import Servo
#from chassis.sparkfun_board import Sparkfun
from chassis.development_board import DevBoard
#CLOUD from cloud.google_cloud import GoogleCloud

SERVO_PIN = 9
SERVO_ANG = 90


#socket.gethostname()
HOST_NAME = ''
PORT_NUMBER = 8080  # Maybe set this to 9000.
print("hostname: " + HOST_NAME)


# get board type
car =  DevBoard() #DevBoard() #Sparkfun()
car.enable_en()
camera = Camera()
#CLOUD cloud = GoogleCloud()
servo = Servo()
servo.attach(SERVO_PIN)

servo_ang = SERVO_ANG
servo.write(SERVO_ANG)

class HTTPRequestHandler(BaseHTTPServer.BaseHTTPRequestHandler):
    def __init__(self, request, client_address, server):
        self.html = ["Error loading main.html"]
        with open("main.html", "r") as html:
            self.html = html.readlines()
        self._update_speed()
        with open("favicon.ico", "rb") as favicon:
            self.favicon = favicon.read()
        BaseHTTPServer.BaseHTTPRequestHandler.__init__(self, request, client_address, server)
    
    def _update_speed(self):
        for idx,ln in enumerate(self.html):
            if(ln.find("Speed") >0):
                self.html[idx]="<br>Speed {}</br>".format(car.speed)
                break
    
    def do_HEAD(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()

    def refresh_image(self):
        global camera
        try:
            os.remove('camera.jpg')
        except:
            print "error: failed to remove camera.jpg"
        camera.create_image('camera.jpg')

    def do_GET(self):
        global car,camera,servo,cloud,servo_ang

        if '/favicon.ico' in self.path:
            self.send_response(200)
            self.send_header("Content-type", 'image/x-icon')
            self.end_headers()
            self.wfile.write(self.favicon)

        if '/camera.jpg' in self.path:
            self.send_response(200)
            self.send_header("Content-type", 'image/jpg')
            self.end_headers()
            try:
                with open("camera.jpg", "rb") as camera_file:
                    self.wfile.write(camera_file.read())
            except:
                print "error: failed to access camera.jpg"


        if self.path == "/up":
            car.go_forward(car.speed)
            self.refresh_image()
        elif self.path == "/down":
            car.go_backward(car.speed)
            self.refresh_image()
        elif self.path == "/right":
            car.turn_right(1.0)
            time.sleep(0.3)
            car.stop_gradually()
            self.refresh_image()
        elif self.path == "/left":
            car.turn_left(1.0)
            time.sleep(0.3)
            car.stop_gradually()
            self.refresh_image()
        elif self.path == "/":
            pass
        elif self.path == "/speed_up":
            if(car.speed < 1.5):
                car.speed += 0.1
            self._update_speed()
        elif self.path == "/speed_down":
            if(car.speed > 0.5):
                car.speed -= 0.1
            self._update_speed()
        elif self.path == "/stop":
            car.stop_now()
            self.refresh_image()
        elif self.path == "/camera_down":
            print 'camera_down:' + str(servo_ang)
            servo_ang -=10
            servo.write(servo_ang)
            time.sleep(0.5)
            self.refresh_image()
        elif self.path == "/camera_up":
            print 'camera_up:' + str(servo_ang)
            servo_ang +=10
            servo.write(servo_ang)
            time.sleep(0.5)
            self.refresh_image()
        elif self.path == "/camera_center":
            self.refresh_image()
        elif self.path == "/send":
            pass
            #cloud.annotate('camera.jpg')
        else:
            self.send_response(400)
            return

        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        for line in self.html:
            self.wfile.write(line)


if __name__ == '__main__':
    httpd = BaseHTTPServer.HTTPServer((HOST_NAME, PORT_NUMBER), HTTPRequestHandler)
    print time.asctime(), "Server Starts - %s:%s" % (HOST_NAME, PORT_NUMBER)
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        pass
    httpd.server_close()
    print time.asctime(), "Server Stops - %s:%s" % (HOST_NAME, PORT_NUMBER)
