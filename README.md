# Image Based on php:8.4-fpm-alpine

**`WORKDIR`is /app**.<br>
All Projectfiles should be bound to /app.<br>

## Image Details

Dockerfile: [Dockerfile @ Github](https://github.com/PamoDev/php-skeleton/blob/dev/etc/PhpAlpineDockerfile)

Dockerhub: [php-fpm-alpine @ Dockerhub](https://hub.docker.com/r/pamodev/php-fpm-alpine)

Env: `PHP8.4-fpm, Git, Composer, xDebug, PHPUnit12.0.10, Imagemagick/Imagick`

Php-ext: `Zip Gd(--with-jpeg) intl pdo pdo_mysql bcmath gd soap fileinfo intl openssl imagick`

## Volume Bindings
*Custom PHP Ini File:* <br>-v `/path/to/host/customPhpIniFile.ini`:`/usr/local/etc/php/conf.d/custom.ini`

*Multiple Ini:* <br>-v `/etc/phpIni/folder`:`/usr/local/etc/php/conf.d/`

*Project Files:* <br>-v `.`:`/app`

> **Important:** if you overwrite the /app/vendor folder or composer.json, the available scripts and tooling will be available instead of the built-in image tooling that is used below.

# Example; `docker`

*Composer in current Dir*
<br>`docker run -v .:/app -it --rm pamodev/php-fpm-alpine composer install`
<br>`docker run -v .:/app -it --rm pamodev/php-fpm-alpine composer update`


*Composer Scripts*
<br>`docker run -v .:/app -it --rm pamodev/php-fpm composer run-script $scriptName`

**Composer Binarys**<br>
/app/vendor/bin is in the $PATH
<br>`docker run -v .:/app -it --rm pamodev/php-fpm phpunit`
<br>`docker run -v .:/app -it --rm pamodev/php-fpm phpcs`
<br>`docker run -v .:/app -it --rm pamodev/php-fpm phpcbf`

> The Directory **/app/vendor/bin** is added to the path. Bins can be called directly

# Example; `Tooling on existing Projects`

Foreign Projects are tricky, but you could do something like:
```
docker run --rm -it \
  -v .:/src:ro \
  -w /src \
  pamodev/php-fpm-alpine \
  /app/vendor/bin/phpunit --bootstrap /app/vendor/autoload.php .
  ```
* Bind the Existing Project to /src
* Make it :ro (read-only) so we dont modfiy stuff
* We can now use the tooling but need to specify any path changes via params


[docker-compose.yaml @ Github](https://github.com/PamoDev/php-skeleton/blob/dev/docker-compose.yaml)