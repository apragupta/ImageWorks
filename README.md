# ImageWorks

Racket code to process images.

## fixAspect.rkt
Takes any JPG/GIF image and converts to 800x600 by rotating/stretching/cropping. If image is a portrait it rotates it to make a landscape before cropping. aspect ratio of content is never violated. 

## image-circle-crop.rkt
Takes any 800x600 image (e.g. from last program) and applies a circle mask on it. Make sure mask.png is in the same folder.

## Using
The last line of each program needs to be changed to point to the content directory

