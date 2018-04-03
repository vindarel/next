LISP?=sbcl

build-gtk:
	$(LISP) --disable-debugger \
		--load next.asd \
		--eval '(ql:quickload :next/gtk)' \
		--eval '(asdf:make :next/gtk)' \
		--eval '(quit)'
