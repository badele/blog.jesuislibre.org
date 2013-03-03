all: build upload

clean:
	rm -rf _build

build:
	run-rstblog build

serve:
	run-rstblog serve

upload:
	#rsync -a _build/ blog.jesuislibre.org:/www/blog.jesuislibre.org/
	@echo "Done..."
