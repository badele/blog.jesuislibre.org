all: build

hugoinstall:
	cd /tmp/ && curl -LO https://github.com/gohugoio/hugo/releases/download/v0.30.2/hugo_0.30.2_Linux-64bit.tar.gz
	cd /tmp/ && tar -xvzf /tmp/hugo_* hugo
	mkdir -p ~/.bin
	cp /tmp/hugo ~/.bin

build-draft:
	GIT_COMMIT_SHA=`git rev-parse --verify HEAD` GIT_COMMIT_SHA_SHORT=`git rev-parse --short HEAD` hugo --buildDrafts --cleanDestinationDir

build:
	GIT_COMMIT_SHA=`git rev-parse --verify HEAD` GIT_COMMIT_SHA_SHORT=`git rev-parse --short HEAD` hugo --cleanDestinationDir

serve:
	# hugo gen chromastyles -v --style=monokai > themes/beautifulhugo/static/css/chroma_syntax.css
	GIT_COMMIT_SHA=`git rev-parse --verify HEAD` GIT_COMMIT_SHA_SHORT=`git rev-parse --short HEAD` hugo serve --buildDrafts --disableFastRender

serve-debug:
	hugo serve -v --buildDrafts --renderToDisk

publishtest: build
	git diff --quiet --exit-code && rsync -avrn --delete public/ w4a153382@ssh.web4all.fr:/datas/vol3/w4a153382/var/www/blog.jesuislibre.org/htdocs/

publish: build
	git diff --quiet --exit-code && rsync -avr --delete public/ w4a153382@ssh.web4all.fr:/datas/vol3/w4a153382/var/www/blog.jesuislibre.org/htdocs/
