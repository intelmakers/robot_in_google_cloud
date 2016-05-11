import cv2


camera = cv2.VideoCapture(0)
retval, im = camera.read()
if retval:
   cv2.imwrite("image.jpg", im)
   print "image.jpg captured"
else:
   print "capturing error"
