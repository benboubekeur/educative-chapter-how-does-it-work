FROM tangramor/nginx-php8-fpm


# If there is a conf folder under /var/www/html, the start.sh will
# copy conf/nginx.conf to /etc/nginx/nginx.conf
# copy conf/nginx-site.conf to /etc/nginx/conf.d/default.conf
# copy conf/nginx-site-ssl.conf to /etc/nginx/conf.d/default-ssl.conf


# China alpine mirror: mirrors.ustc.edu.cn
ARG APKMIRROR=""

# start.sh will set desired timezone with $TZ
ENV TZ Africa/Algiers

# China php composer mirror: https://mirrors.cloud.tencent.com/composer/
ENV COMPOSERMIRROR="https://mirrors.cloud.tencent.com/composer/"
# China npm mirror: https://registry.npmmirror.com
ENV NPMMIRROR="https://registry.npmmirror.com"

ENV  WEBROOT='/var/www/html/public'
ENV PHP_REDIS_SESSION_HOST='redis'
ENV CREATE_LARAVEL_STORAGE = '1'


# start.sh will replace default web root from /var/www/html to $WEBROOT
ENV WEBROOT /var/www/html/public

# start.sh will use redis as session store with docker container name $PHP_REDIS_SESSION_HOST
ENV PHP_REDIS_SESSION_HOST redis

# start.sh will create laravel storage folder structure if $CREATE_LARAVEL_STORAGE = 1
ENV CREATE_LARAVEL_STORAGE "1"

# download required node/php packages,
# some node modules need gcc/g++ to build
RUN if [[ "$APKMIRROR" != "" ]]; then sed -i "s/dl-cdn.alpinelinux.org/${APKMIRROR}/g" /etc/apk/repositories ; fi\
    && apk add --no-cache --virtual .build-deps gcc g++ libc-dev make \
    # set preferred npm mirror
    && cd /usr/local \
    && if [[ "$NPMMIRROR" != "" ]]; then npm config set registry ${NPMMIRROR}; fi \
    && npm config set registry $NPMMIRROR \
    && cd /var/www/html \
    # install node modules
    # install php composer packages
    && if [[ "$COMPOSERMIRROR" != "" ]]; then composer config -g repos.packagist composer ${COMPOSERMIRROR}; fi \
    && composer install \
    # clean
    && apk del .build-deps \
    # build js/css
    && npm run dev \
    # set .env
    # change /var/www/html user/group
    && chown -Rf nginx.nginx /var/www/html


# Expose port 9000
EXPOSE 80

# Run the PHP-FPM process
CMD ["php-fpm"]




