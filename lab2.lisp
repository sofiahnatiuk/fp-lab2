(defun remove-seconds (lst &optional (index 1))
  (cond
    ((null lst) nil)
    ((oddp index) (cons (car lst) (remove-seconds (cdr lst) (1+ index)))) 
    (t (remove-seconds (cdr lst) (1+ index)))))

(defun list-set-symmetric-difference (set1 set2)
  (let ((unique-in-set1 (remove-if (lambda (x) (member x set2 :test #'equal)) set1))
        (unique-in-set2 (remove-if (lambda (x) (member x set1 :test #'equal)) set2)))
    (append unique-in-set1 unique-in-set2)))

(defun check-remove-seconds (name input expected)
  (format t "~:[FAILED~;passed~]: ~a~%" 
          (equal (remove-seconds input) expected) name))

(defun test-remove-seconds ()
  (check-remove-seconds "Test 1" '() '())              ; Expected: NIL
  (check-remove-seconds "Test 2" '(1) '(1))            ; Expected: (1)
  (check-remove-seconds "Test 3" '(1 2 3 4 5 6) '(1 3 5)) ; Expected: (1 3 5)
  (check-remove-seconds "Test 4" '(1 2 a b 3 4 d) '(1 a 3 d))) ; Expected: (1 A 3 D)

(defun check-list-set-symmetric-difference (name set1 set2 expected)
  (format t "~:[FAILED~;passed~]: ~a~%"
          (equal (list-set-symmetric-difference set1 set2) expected) name))

(defun test-list-set-symmetric-difference ()
  (check-list-set-symmetric-difference "Test 1" '() '() '()) ; Expected: NIL
  (check-list-set-symmetric-difference "Test 2" '(1 2 3) '() '(1 2 3)) ; Expected: (1 2 3)
  (check-list-set-symmetric-difference "Test 3" '() '(4 5 6) '(4 5 6)) ; Expected: (4 5 6)
  (check-list-set-symmetric-difference "Test 4" '(1 2 3) '(1 2 3) '()) ; Expected: NIL
  (check-list-set-symmetric-difference "Test 5" '((1 2) 3 4) '(3 (1 2) 5) '(4 5))) ; Expected: (4 5)

(defun run-all-tests ()
  (format t "~%Running remove-seconds tests:~%")
  (test-remove-seconds)
  (format t "~%Running list-set-symmetric-difference tests:~%")
  (test-list-set-symmetric-difference))

(run-all-tests)
