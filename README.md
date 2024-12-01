<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПіСКС</b></p>
<p align="center">
<b>Звіт з лабораторної роботи 2</b><br/>
"Рекурсія"<br/>
дисципліни "Вступ до функціонального програмування"
</p>
<p align="right"> <b>Студент(-ка)</b>: <i>Гнатюк Софія Валентинівна КВ-12</i><p>
<p align="right"><b>Рік</b>: <i>2024</i><p>
  
### Загальне завдання
Реалізуйте дві рекурсивні функції, що виконують деякі дії з вхідним(и) списком(-ами), за можливості/необхідності використовуючи різні види рекурсії. Функції, які необхідно реалізувати, задаються варіантом. Вимоги до функцій:
1. Зміна списку згідно із завданням має відбуватись за рахунок конструювання нового списку, а не зміни наявного (вхідного).
2. Не допускається використання функцій вищого порядку чи стандартних функцій для роботи зі списками, що не наведені в четвертому розділі навчального посібника.
3. Реалізована функція не має бути функцією вищого порядку, тобто приймати функції в якості аргументів.
4. Не допускається використання псевдофункцій (деструктивного підходу).
5. Не допускається використання циклів.

### Завдання за варіантом 5
1. Написати функцію remove-seconds , яка видаляє зі списку кожен другий елемент:
```lisp
CL-USER> (remove-seconds '(1 2 a b 3 4 d))
(1 A 3 D)
```
2. Написати функцію list-set-symmetric-difference , яка визначає симетричну різницю двох множин, заданих списками атомів (тобто, множину елементів, що не входять до обох множин):
```lisp
CL-USER> (list-set-symmetric-difference '(1 2 3 4) '(3 4 5 6))
(1 2 5 6) ; порядок може відрізнятись
```

## <Лістинг функції <remove-seconds>
```lisp
(defun remove-seconds (lst &optional (index 1))
  (cond
    ((null lst) nil)
    ((oddp index) (cons (car lst) (remove-seconds (cdr lst) (1+ index)))) 
    (t (remove-seconds (cdr lst) (1+ index)))))
```
### Тестові набори та утиліти
```lisp
(defun check-remove-seconds (name input expected)
  (format t "~:[FAILED~;passed~]: ~a~%" 
          (equal (remove-seconds input) expected) name))

(defun test-remove-seconds ()
  (check-remove-seconds "Test 1" '() '())              ; Expected: NIL
  (check-remove-seconds "Test 2" '(1) '(1))            ; Expected: (1)
  (check-remove-seconds "Test 3" '(1 2 3 4 5 6) '(1 3 5)) ; Expected: (1 3 5)
  (check-remove-seconds "Test 4" '(1 2 a b 3 4 d) '(1 a 3 d))) ; Expected: (1 A 3 D)
```
### Тестування

```lisp
Running remove-seconds tests:
passed: Test 1
passed: Test 2
passed: Test 3
passed: Test 4
```
## Лістинг функції <list-set-symmetric-difference>
```lisp
(defun list-set-symmetric-difference (set1 set2)
  (let ((unique-in-set1 (remove-if (lambda (x) (member x set2 :test #'equal)) set1))
        (unique-in-set2 (remove-if (lambda (x) (member x set1 :test #'equal)) set2)))
    (append unique-in-set1 unique-in-set2)))
```
### Тестові набори та утиліти
```lisp
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
```
### Тестування
```lisp
Running list-set-symmetric-difference tests:
passed: Test 1
passed: Test 2
passed: Test 3
passed: Test 4
passed: Test 5
```
