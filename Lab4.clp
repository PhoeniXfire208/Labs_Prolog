;;;   Экспертная система диагностики проблем в программировании

;;  ФУНКЦИИ

(deffunction задать-вопрос (?вопрос $?допустимые-значения)
   (printout t ?вопрос)
   (bind ?ответ (read))
   (if (lexemep ?ответ)
       then (bind ?ответ (lowcase ?ответ)))
   (while (not (member$ ?ответ ?допустимые-значения)) do
      (printout t ?вопрос)
      (bind ?ответ (read))
      (if (lexemep ?ответ)
          then (bind ?ответ (lowcase ?ответ))))
   ?ответ)

(deffunction да-или-нет (?вопрос)
   (bind ?ответ (задать-вопрос ?вопрос да нет д н))
   (if (or (eq ?ответ да) (eq ?ответ д))
       then yes
       else no))

;;  ПРАВИЛА ЗАПРОСА

(defrule определить-компиляцию ""
   (not (code-compiles ?))
   (not (advice ?))
   =>
   (assert (code-compiles (да-или-нет "Компилируется ли код (да/нет)? "))))

(defrule определить-тип-ошибки ""
   (code-compiles no)
   (not (advice ?))
   =>
   (assert (error-type
      (задать-вопрос "Какой тип ошибки вы видите (синтаксическая/компоновщика/среды_выполнения)? "
                     синтаксическая компоновщика среды_выполнения))))

(defrule определить-краш-среды-выполнения ""
   (code-compiles yes)
   (not (advice ?))
   =>
   (assert (runtime-crash (да-или-нет "Крашится ли программа во время выполнения (да/нет)? "))))

(defrule определить-проблему-вывода ""
   (code-compiles yes)
   (runtime-crash no)
   (not (advice ?))
   =>
   (assert (output-incorrect (да-или-нет "Корректный ли вывод программы (да/нет)? "))))

(defrule определить-проблему-производительности ""
   (code-compiles yes)
   (runtime-crash no)
   (output-incorrect no)
   (not (advice ?))
   =>
   (assert (performance-issue (да-или-нет "Работает ли программа медленно (да/нет)? "))))

(defrule определить-segfault ""
   (runtime-crash yes)
   (not (advice ?))
   =>
   (assert (segfault-occurred (да-или-нет "Происходит ли segmentation fault (да/нет)? "))))

(defrule определить-утечку-памяти ""
   (performance-issue yes)
   (not (advice ?))
   =>
   (assert (memory-leak-suspected (да-или-нет "Увеличивается ли потребление памяти (да/нет)? "))))

(defrule определить-проблему-цикла ""
   (output-incorrect yes)
   (not (advice ?))
   =>
   (assert (loop-problem (да-или-нет "Есть ли бесконечный цикл или ошибки итераций (да/нет)? "))))

(defrule определить-исключения ""
   (runtime-crash yes)
   (segfault-occurred no)
   (not (advice ?))
   =>
   (assert (unhandled-exception (да-или-нет "Есть ли необработанные исключения (да/нет)? "))))

(defrule определить-нуль-указатель ""
   (segfault-occurred yes)
   (not (advice ?))
   =>
   (assert (null-pointer-dereference
      (да-или-нет "Может ли быть разыменование нулевого указателя (да/нет)? "))))

;;*  ПРАВИЛА СОВЕТОВ  *

(defrule синтаксическая-ошибка ""
   (error-type синтаксическая)
   (not (advice ?))
   =>
   (assert (advice "Проверьте пропущенные точки с запятой, скобки или опечатки в именах переменных.")))

(defrule ошибка-компоновщика ""
   (error-type компоновщика)
   (not (advice ?))
   =>
   (assert (advice "Проверьте подключение библиотек и наличие всех зависимостей.")))

(defrule деление-на-ноль ""
   (runtime-crash yes)
   (unhandled-exception yes)
   (not (advice ?))
   =>
   (assert (advice "Проверьте деление на ноль или некорректные математические операции.")))

(defrule совет-нуль-указатель ""
   (null-pointer-dereference yes)
   (not (advice ?))
   =>
   (assert (advice "Инициализируйте указатели и проверяйте их на null перед использованием.")))

(defrule логическая-ошибка ""
   (output-incorrect yes)
   (loop-problem no)
   (not (advice ?))
   =>
   (assert (advice "Проверьте значения переменных и условные выражения на логические ошибки.")))

(defrule бесконечный-цикл ""
   (loop-problem yes)
   (not (advice ?))
   =>
   (assert (advice "Проверьте условия выхода из циклов и шаги итераций.")))

(defrule совет-утечка-памяти ""
   (memory-leak-suspected yes)
   (not (advice ?))
   =>
   (assert (advice "Используйте инструменты профилирования памяти и освобождайте выделенную память.")))

(defrule совет-segfault ""
   (segfault-occurred yes)
   (null-pointer-dereference no)
   (not (advice ?))
   =>
   (assert (advice "Проверьте границы массивов и корректность работы с указателями.")))

(defrule оптимизация-алгоритма ""
   (performance-issue yes)
   (memory-leak-suspected no)
   (not (advice ?))
   =>
   (assert (advice "Оптимизируйте алгоритмы или используйте более эффективные структуры данных.")))

(defrule обработка-исключений ""
   (unhandled-exception yes)
   (not (advice ?))
   =>
   (assert (advice "Добавьте блоки try-catch для обработки исключений.")))

(defrule совет-по-умолчанию ""
  (declare (salience -10))
  (not (advice ?))
  =>
  (assert (advice "Обратитесь к документации.")))


;; ПРАВИЛА ЗАПУСКА И ВЫВОДА

(defrule системный-баннер ""
  (declare (salience 10))
  =>
  (printout t crlf crlf)
  (printout t "Экспертная система диагностики проблем в программировании")
  (printout t crlf crlf))

(defrule вывод-совета ""
  (declare (salience 10))
  (advice ?совет)
  =>
  (printout t crlf crlf)
  (printout t "Рекомендуемое действие:")
  (printout t crlf crlf)
  (format t " %s%n%n%n" ?совет))