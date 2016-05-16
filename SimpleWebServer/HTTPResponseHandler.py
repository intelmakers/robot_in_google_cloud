import BaseHTTPServer


# Python's analog for a static constructor
def _load_class_data():
    html = ["Error loading main.html"]
    with open("main.html", "r") as html:
        html = html.readlines()
    with open("favicon.ico", "rb") as favicon:
        favicon = favicon.read()
    return html, favicon


class HTTPRequestHandler(BaseHTTPServer.BaseHTTPRequestHandler):

    html, favicon = _load_class_data()

    def do_HEAD(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()

    def do_GET(self):
        if '/favicon.ico' in self.path:
            self.send_response(200)
            self.send_header("Content-type", 'image/x-icon')
            self.end_headers()
            self.wfile.write(HTTPRequestHandler.favicon)
            return

        if '/camera.jpg' in self.path:
            self.send_response(200)
            self.send_header("Content-type", 'image/jpg')
            self.end_headers()
            with open("camera.jpg", "rb") as camera:
                self.wfile.write(camera.read())
            return

        if not ((self.path == "/") or (self.path == "/left") or (self.path == "/right") or (self.path == "/up") or (self.path == "/down") or (self.path == "/stop")):
            self.send_response(400)
            return

        if self.path == "/left":
            # TODO: Add code to turn left
            pass

        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        for line in HTTPRequestHandler.html:
            self.wfile.write(line)
