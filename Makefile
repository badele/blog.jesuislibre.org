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
	cp .htaccess _build/
	cp googlea3540b86a38da267.html _build/
	rsync -ar --delete _build/ blog.jesuislibre.org@10.0.0.6:/home/blog.jesuislibre.org/public_html/
	@echo "Done..."
