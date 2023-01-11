.PHONY: new_website
new_website:
	hugo new site website
	cd website\
	&& git init\
	&& git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke themes/ananke\
	&& echo "theme = 'ananke'" >> config.toml\
	&& hugo new posts/my-first-post.md\
	&& gsed -i "s/draft: true/draft: false/g" content/posts/my-first-post.md\
	&& echo "public">.gitignore

.PHONY: clean
clean:
	docker images -f "dangling=true" | grep -v kindest | awk 'NR!=1{print $$3}' | xargs docker rmi

.PHONY: build
build:
	hugo

.PHONY: image
image: build
	docker build --no-cache -f website.dockerfile -t yuexclusive/evolve_website:latest .
	make clean

.PHONY: run
run: image
	docker run --rm -it -p 8884:80 yuexclusive/evolve_website:latest