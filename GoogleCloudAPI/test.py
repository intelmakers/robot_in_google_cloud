import argparse
import base64
import httplib2

from googleapiclient.discovery import build
from oauth2client.client import GoogleCredentials

import logging
logging.basicConfig(filename='debug.log',level=logging.DEBUG)


def printAnnotations(type, annotations):
    if annotations is None:
        return
    for annotation in annotations:
        line = type + ": " + annotation['description'].encode("ascii", "replace");
        if 'score' in annotation:
            line += " Score: {}".format(annotation['score'])
        print line

def main(photo_file):
    '''Run a label request on a single image'''

    http = httplib2.Http()

    credentials = GoogleCredentials.get_application_default().create_scoped(['https://www.googleapis.com/auth/cloud-platform'])
    credentials.authorize(http)

    API_DISCOVERY_FILE = 'https://vision.googleapis.com/$discovery/rest?version=v1'
    service = build('vision', 'v1', http, discoveryServiceUrl=API_DISCOVERY_FILE)

    with open(photo_file, 'rb') as image:
        image_content = base64.b64encode(image.read())
        service_request = service.images().annotate(
            body={
                'requests': [{
                    'image':
                    {
                        'content': image_content
                    },
                    'features': [
                        {
                            'type': 'LABEL_DETECTION',
                            'maxResults': 20,
                        },
                        {
                            'type': 'LOGO_DETECTION',
                            'maxResults': 20,
                        },
                        {
                            'type': 'TEXT_DETECTION',
                            'maxResults': 20,
                        }
                    ],
                    "imageContext":
                    {
                    },
                }]
            })
        response = service_request.execute()
        responses = response['responses']
        for resp in responses:
            if 'labelAnnotations' in resp:
                printAnnotations("Label", resp['labelAnnotations'])
            if 'textAnnotations' in resp:
                printAnnotations("Text", resp['textAnnotations'])
            if 'logoAnnotations' in resp:
                printAnnotations("Logo", resp['logoAnnotations'])
    return 0


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('image_file', help='The image you\'d like to label.')
    args = parser.parse_args()
    main(args.image_file)