'''
Created on Apr 13, 2016

@author: satia
'''
import time
import BaseHTTPServer
from http_response_handler import HTTPRequestHandler
import socket


HOST_NAME = '' #socket.gethostname() 
PORT_NUMBER = 8080  # Maybe set this to 9000.
print("hostname: " + HOST_NAME)

if __name__ == '__main__':
    
    
    httpd = BaseHTTPServer.HTTPServer((HOST_NAME, PORT_NUMBER), HTTPRequestHandler)
    print time.asctime(), "Server Starts - %s:%s" % (HOST_NAME, PORT_NUMBER)
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        pass
    httpd.server_close()
    print time.asctime(), "Server Stops - %s:%s" % (HOST_NAME, PORT_NUMBER)
    