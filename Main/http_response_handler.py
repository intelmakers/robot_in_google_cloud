import BaseHTTPServer
import time
from camera2D import Camera
from servo import Servo
from sparkfun_board import Sparkfun
from development_board import DevBoard
#CLOUD from google_cloud import GoogleCloud

SERVO_PIN = 21 #14 # or 9
SERVO_ANG = 90

import os
# get board type
car =  Sparkfun() #DevBoard() #Sparkfun()
car.enable_en()
camera = Camera()
<<<<<<< HEAD

#CLOUD cloud = GoogleCloud()

=======
#CLOUD cloud = GoogleCloud()
>>>>>>> cf8f611ce1f18eb389d7ac3288754dd27f97944e
servo = Servo()
#servo.attach(SERVO_PIN)

servo_ang = SERVO_ANG
servo.write(SERVO_ANG)
time.sleep(0.05);

class HTTPRequestHandler(BaseHTTPServer.BaseHTTPRequestHandler):
    def __init__(self, request, client_address, server):
        self.html = ["Error loading main.html"]
        with open("main.html", "r") as html:
            self.html = html.readlines()
        with open("favicon.ico", "rb") as favicon:
            self.favicon = favicon.read()
        
        BaseHTTPServer.BaseHTTPRequestHandler.__init__(self, request, client_address, server)
        

    def do_HEAD(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()

    def do_GET(self):
        if '/favicon.ico' in self.path:
            self.send_response(200)
            self.send_header("Content-type", 'image/x-icon')
            self.end_headers()
            self.wfile.write(self.favicon)
            return

        if '/camera.jpg' in self.path:
            self.send_response(200)
            self.send_header("Content-type", 'image/jpg')
            self.end_headers()
			try:
		        with open("camera.jpg", "rb") as camera_file:
			        self.wfile.write(camera_file.read())
			except:
			    print "error: access to image"
            return

        global car,camera,servo,cloud,servo_ang
        
        if self.path == "/up":
            car.go_forward(0.3)
            
        elif self.path == "/down":
            car.go_backward(0.3)
            
        elif self.path == "/right":
            car.turn_right(0.2)
        elif self.path == "/left":
            car.turn_left(0.2)
        elif self.path == "/":
            pass
        
        elif self.path == "/stop":
            car.stop_now()
        elif self.path == "/camera_down":
            servo_ang -=2
            servo.write(servo_ang)
            print 'camera_down:' + str(servo_ang)
        elif self.path == "/camera_up":
            servo_ang +=2
            servo.write(servo_ang)
            print 'camera_up:' + str(servo_ang)
        elif self.path == "/camera_center":
            try:
			    os.remove('camera.jpg')
			except:
			    print "error: no image to remove"
            camera.create_image('camera.jpg')
        
<<<<<<< HEAD
#CLOUD        elif self.path == "/send":
#CLOUD            cloud.annotate('camera.jpg')
=======
        #CLOUD elif self.path == "/send":
        #CLOUD     cloud.annotate('camera.jpg')
>>>>>>> cf8f611ce1f18eb389d7ac3288754dd27f97944e
            
        else:
            
            self.send_response(400)
            return
        
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        for line in self.html:
            self.wfile.write(line)
