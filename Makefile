all: build upload

clean:
	rm -rf _build

build:
	run-rstblog build

serve:
	run-rstblog serve

push:
	git push github master

upload:
	rsync -a _build/ blog.jesuislibre.org@10.0.0.6:/home/blog.jesuislibre.org/public_html/
	@echo "Done..."
