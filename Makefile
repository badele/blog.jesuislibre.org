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

doc:
	cd /LIVE/projects/pelican-theme-jesuislibre ; ./generate_pelicanconf-sample.py /LIVE/projects/blog.jesuislibre.org/pelicanconf.py | sort > pelicanconf-sample.py

clean:
	[ ! -d $(OUTPUTDIR) ] || rm -rf $(OUTPUTDIR)

regenerate:
	$(PELICAN) -r $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)

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

push:
	git push github master

upload:
#	cp .htaccess _build/
#	cp googlea3540b86a38da267.html _build/
	echo "" > output/drafts/index.html
	cp output/drafts/index.html output/static/
	rsync -ar --delete --exclude drafts output/ blog.jesuislibre.org@10.0.0.6:/home/blog.jesuislibre.org/public_html/
	@echo "Done..."
