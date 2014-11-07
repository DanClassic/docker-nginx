FROM nginx
RUN rm /etc/nginx/conf.d/default.conf
RUN rm /etc/nginx/conf.d/example_ssl.conf
RUN rm /var/log/nginx/error.log
RUN rm /var/log/nginx/access.log
COPY content /usr/nginx/share/html
COPY conf /etc/nginx

RUN apt-get update && apt-get install -y \
	php5-fpm

RUN sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php5/fpm/php.ini

VOLUME ["/etc/nginx","/var/log/nginx/","/etc/php5/fpm/pool.d/","/var/run/"]

CMD service php5-fpm restart && nginx -g "daemon off;"
#CMD ["service", "php5-fpm", "restart", "&&", "nginx", "-g", "daemon off;"]
