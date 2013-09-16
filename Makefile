PY=python
PELICAN=pelican
PELICANOPTS=

BASEDIR=$(CURDIR)
INPUTDIR=$(BASEDIR)/content
OUTPUTDIR=$(BASEDIR)/output
CONFFILE=$(BASEDIR)/pelicanconf.py
PUBLISHCONF=$(BASEDIR)/publishconf.py

# Pelican
html:
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)


clean:
	[ ! -d $(OUTPUTDIR) ] || rm -rf $(OUTPUTDIR)

serve:
ifdef PORT
	cd $(OUTPUTDIR) && $(PY) -m pelican.server $(PORT)
else
	cd $(OUTPUTDIR) && $(PY) -m pelican.server
endif

devserver:
ifdef PORT
	$(BASEDIR)/develop_server.sh restart $(PORT)
else
	$(BASEDIR)/develop_server.sh restart
endif

# RSTBLOG
build:
	run-rstblog build
#serve:
#	run-rstblog serve

push:
	git push github master

upload:
#	cp .htaccess _build/
#	cp googlea3540b86a38da267.html _build/
	echo "" > output/drafts/index.html
	rsync -ar --delete output/ blog.jesuislibre.org@10.0.0.6:/home/blog.jesuislibre.org/public_html/
	@echo "Done..."
