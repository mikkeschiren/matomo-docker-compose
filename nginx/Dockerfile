# https://hub.docker.com/_/nginx/
FROM nginx:alpine

# Add www-data user
RUN set -x \
	&& addgroup -g 82 -S www-data \
	&& adduser -u 82 -D -S -G www-data www-data