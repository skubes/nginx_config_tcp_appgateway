FROM alpine:latest
RUN \
build_pkgs="build-base linux-headers wget zlib-dev mercurial pcre-dev" && \
apk --update add ${build_pkgs} && \
cd /tmp/ && \
wget http://nginx.org/download/nginx-1.13.4.tar.gz && \
tar zxf nginx-1.13.4.tar.gz && \
rm nginx-1.13.4.tar.gz && \
hg clone http://hg.nginx.org/njs && \
cd nginx-1.13.4 && \
./configure --add-module=/tmp/njs/nginx --with-stream && \
make && \
make install

FROM alpine:latest
RUN apk --update add pcre
RUN mkdir -p /usr/local/nginx
COPY --from=0 /usr/local/nginx /usr/local/nginx
COPY ./conf/nginx.conf /usr/local/nginx/conf/
COPY ./conf/port_translation_filter.js /usr/local/nginx/conf/

EXPOSE 80
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
