all: build

hugoinstall:
	cd /tmp/ && curl -LO https://github.com/gohugoio/hugo/releases/download/v0.30.2/hugo_0.30.2_Linux-64bit.tar.gz
	cd /tmp/ && tar -xvzf /tmp/hugo_* hugo
	cp /tmp/hugo ~/local/bin/

build:
	hugo --cleanDestinationDir

clean:
	hugo --cleanDestinationDir

serve:
	hugo gen chromastyles -v --style=monokai > themes/beautifulhugo/static/css/chroma_syntax.css
	hugo serve -v --buildDrafts

serve-debug:
	hugo serve -v --buildDrafts --renderToDisk

publish: build
	rsync -avr --delete public/ w4a153382@ssh.web4all.fr:/datas/vol3/w4a153382/var/www/blog.jesuislibre.org/htdocs/
