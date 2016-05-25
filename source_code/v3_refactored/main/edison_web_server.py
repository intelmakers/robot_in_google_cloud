import os
import time
import BaseHTTPServer
import socket

from camera.camera2D import Camera
from servo.servo import Servo
from chassis.sparkfun_board import Sparkfun
from chassis.development_board import DevBoard
#CLOUD from cloud.google_cloud import GoogleCloud

SERVO_PIN = 0 #14 # or 9
SERVO_ANG = 90


#socket.gethostname() 
HOST_NAME = '' 
PORT_NUMBER = 8080  # Maybe set this to 9000.
print("hostname: " + HOST_NAME)


# get board type
car =  Sparkfun() #DevBoard() #Sparkfun()
car.enable_en()
camera = Camera()
#CLOUD cloud = GoogleCloud()
servo = Servo()
#servo.attach(SERVO_PIN)

servo_ang = SERVO_ANG
servo.write(SERVO_ANG)

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
				print "error: failed to access camera.jpg"
				
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
				print "error: failed to remove camera.jpg"

            camera.create_image('camera.jpg')
        
        #CLOUD elif self.path == "/send":
        #CLOUD    cloud.annotate('camera.jpg')
            
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
    