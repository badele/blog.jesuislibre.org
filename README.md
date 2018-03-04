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
git clone https://github.com/badele/blog.jesuislibre.org.git
cd blog.jesuislibre.org
mkdir themes
cd themes
git clone git@github.com:badele/beautifulhugo.git
cd beautifulhugo
git remote add fork git@github.com:halogenica/beautifulhugo.git
git fetch fork
```

```bash
cd blog.jesuislibre.org/themes
git checkout master
git rebase fork/master
git checkout -b used_by_my_blog 2d5a6fb059247405ffa5bbb812a787aecdd329b9
```
