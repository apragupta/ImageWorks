#lang racket


(require racket/draw)
; to handle name conflicts 
(require (prefix-in htdp: 2htdp/image))
(require test-engine/racket-tests)

(define (rotateif img w h file)
  (printf "~a ~a x ~a \n" (path->string file) w  h)
  (cond
   [(and (= w 800) (= h 600)) (printf "skipping because already good..\n")]
   [(> h w)
     (cond
        [(< (/ 800 600)(/ h w))(htdp:save-image (htdp:crop/align "center" "center" 800 600
                                                (htdp:scale (/ 600 w) (htdp:rotate 90 img))) file)]
        ; cropping height
        ; case originally accounted for
        
        [else (htdp:save-image (htdp:crop/align "center" "center" 800 600
                                     (htdp:scale (/ 800 h) (htdp:rotate 90 img))) file)])]
        ;case not yet accounted for 

   [(>= w h)
     (cond
       [(< (/ 800 600)(/ w h)) (htdp:save-image (htdp:crop/align "center" "center" 800 600
                                                (htdp:scale (/ 600 h) img)) file)]
        ;originally accounted for
        [else (htdp:save-image (htdp:crop/align "center" "center" 800 600
                                                (htdp:scale (/ 800 w) img)) file)])]
    ;case not yet accounted for
    [else (printf "should never come...\n")])
    )
  

(define (process img file)
   (rotateif img (send img get-width) (send img get-height) file)
  )

(define (processOneImage file)
    (process (read-bitmap (path->string file)) file)
  )

(define (IsJPG/GIFImageFile? file)
  (or (string-contains? (string-upcase (path->string file)) ".JPG")
      (string-contains? (string-upcase (path->string file)) ".GIF")
  )
  )

(check-expect (IsJPG/GIFImageFile? "abc.JPG") #true)
(check-expect (IsJPG/GIFImageFile? "abc.jpg") #true)
(check-expect (IsJPG/GIFImageFile? "abc.GIF") #true)
(check-expect (IsJPG/GIFImageFile? "abc.gif") #true)
(check-expect (IsJPG/GIFImageFile? "abc.txt") #false)

(for-each
 processOneImage
  (find-files IsJPG/GIFImageFile?
              "C:\\Users\\Apra\\Desktop\\Images"))

;case not accounted for aspect ratio less than 800/600
