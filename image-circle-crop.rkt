#lang racket
(require racket/draw)
;weird have to handle name conflics !@#$%^&*
(require (prefix-in htdp: 2htdp/image))
(require test-engine/racket-tests)

(define (processOneImage file)
    (printf "Processing ~a\n" file)
    (htdp:save-image
     (htdp:overlay mask
                   (read-bitmap (path->string file)))
     (outFilePath file))
  )

(define (IsImageFile? file)
  (or (string-contains? (string-upcase (path->string file)) ".JPG")
      (string-contains? (string-upcase (path->string file)) ".GIF")
  )
  )

(check-expect (IsImageFile? "abc.JPG") #t)
(check-expect (IsImageFile? "abc.jpg") #t)
(check-expect (IsImageFile? "abc.GIF") #t)
(check-expect (IsImageFile? "abc.gif") #t)
(check-expect (IsImageFile? "abc.txt") #f)

(check-expect (outFilePath (string->path  "C:\\Users\\Apra\\Downloads\\fractals1000\\fractals\\1.jpg"))
              (string->path  "C:\\Users\\Apra\\Downloads\\fractals1000\\fractals\\out\\1.png")
              )
(define (outFilePath inPath)
  (define-values (path file isDir) (split-path inPath))
   (build-path path "out" (path-replace-extension file ".png"))
  )

(define (make-dir-if path)
  (if (not (directory-exists? path))
      (let ()
        (printf "Creating directory ~a\n" (path->string path))
        (make-directory path)
        )
      (printf "Directory exists: ~a\n" (path->string path))
       ))




(define (processDir  dirName)
;create output directory before you start
  (make-dir-if (build-path dirName "out"))
  (for-each
    processOneImage
    (find-files IsImageFile? dirName))
  )

(define mask (read-bitmap "mask.png"))
(processDir "C:\\Users\\Apra\\Desktop\\Images")