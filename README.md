# blog.jesuislibre.org
source du blog jesuislibre.org

## Hugo installation

```
cd /tmp/ && curl -LO https://github.com/gohugoio/hugo/releases/download/v0.30.2/hugo_0.30.2_Linux-64bit.tar.gz
cd /tmp/ && tar -xvzf /tmp/hugo_* hugo
cp /tmp/hugo ~/local/bin/
```

## Theme installation
```bash
cd blog_destination/themes
git clone git@github.com:badele/beautifulhugo.git
git remote add fork git@github.com:halogenica/beautifulhugo.git
```

```bash
cd blog_destination/themes
git checkout master
git rebase fork/master
git checkout -b used_by_my_blog ebfb6b87803f906382775ba90efdd9e1ebf31280
git rebase piwik
```
