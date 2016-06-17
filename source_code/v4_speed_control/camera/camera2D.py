import cv2

class Camera(object):
    def create_image(self,file):
        camera = cv2.VideoCapture(0)
        #camera.set(3,480)
        #camera.set(4,270)
        retval, im = camera.read()
        if retval:
            cv2.imwrite(file, im)
        else:
            print 'Create image fail'