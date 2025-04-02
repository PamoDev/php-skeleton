# Image Based on php:8.4-fpm 

**`WORKDIR`is /app**.<br>
All Projectfiles should be bound to /app.<br>

## Image Details

Dockerfile: [Dockerfile @ Github](https://github.com/PamoDev/php-skeleton/blob/dev/etc/PhpDockerfile)

Dockerhub: [php-fpm @ Dockerhub](https://hub.docker.com/r/pamodev/php-fpm)


Env: `PHP8.4-fpm, Git, Composer, xDebug, PHPUnit12.0.10, Imagemagick/Imagick`

Php-ext: `Zip Gd(--with-jpeg) intl pdo pdo_mysql bcmath gd soap fileinfo intl openssl imagick`

## Volume Bindings
*Custom PHP Ini File:* <br>-v `/path/to/host/customPhpIniFile.ini`:`/usr/local/etc/php/conf.d/custom.ini`

*Multiple Ini:* <br>-v `/etc/phpIni/folder`:`/usr/local/etc/php/conf.d/`

*Project Files:* <br>-v `.`:`/app`

# Example; `docker`

*Composer in current Dir*
<br>`docker run -v .:/app -it --rm pamodev/php-fpm composer install`
<br>`docker run -v .:/app -it --rm pamodev/php-fpm composer update`

> **Important:** if you overwrite the /app/vendor folder or composer.json, the available scripts and tooling will be available instead of the built-in image tooling that is used below. 

*Composer Scripts*
<br>`docker run -v .:/app -it --rm pamodev/php-fpm composer run-script $scriptName`

*Composer Binarys*
<br>`docker run -v .:/app -it --rm pamodev/php-fpm <fileNameFrom(vendor/bin)> `
<br>`docker run -v .:/app -it --rm pamodev/php-fpm phpcbf .`
<br>`docker run -v .:/app -it --rm pamodev/php-fpm phpunit`
<br>`docker run -v .:/app -it --rm pamodev/php-fpm phpcs .`


*Run PHPUnit -> ./phpunit.xml*
<br>`docker run -v .:/app -it --rm pamodev/php-fpm phpunit`

*PHP Info* <br>`docker run -v .:/app -it --rm pamodev/php-fpm php -v`

# Example; `docker-compose`

[docker-compose.yaml @ Github](https://github.com/PamoDev/php-skeleton/blob/dev/docker-compose.yaml)