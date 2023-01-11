from nginx:alpine
RUN rm -fr /usr/share/nginx/html/*
copy public /usr/share/nginx/html
copy default.conf /etc/nginx/conf.d/default.conf
