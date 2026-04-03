# Compage PHP Skeleton Base Image (php:8.4-fpm-alpine)

**`WORKDIR` is /app**.<br>
All Projectfiles should be bound to `/app`.<br>

## Image Details

**Dockerfile:** [Dockerfile @ Github](https://github.com/PamoDev/php-skeleton/blob/dev/etc/PhpAlpineDockerfile)

**Dockerhub:** [php-fpm-alpine @ Dockerhub](https://hub.docker.com/r/pamodev/php-fpm-alpine)

### Stages & Targets
We provide two tailored build stages for your needs:
*   `pamodev/php-fpm-alpine:latest` (or `:8.4`): **Prod Stage**. Optimized footprint, limited memory (64M), logs to `stderr`, and **no xDebug/Profiler**.
*   `pamodev/php-fpm-alpine:dev`: **Dev Stage**. Includes `xDebug` (with Profiler), increased memory (256M), and enabled error display.

### Environment & Tooling
**Env:** `PHP8.4-fpm, Git, Composer, xDebug (dev only), PHPUnit 12.5, PHPStan Level 9, Imagemagick/Imagick, Redis`

**Php-ext:** `zip, intl, gd (--with-jpeg), pdo, pdo_mysql, bcmath, soap, fileinfo, imagick, redis, opcache`

## Quality Standards & Coverage
This skeleton enables strict quality standards out-of-the-box (configurable via `composer.json` scripts):
*   **PHPStan Level 9:** Enforced via `composer run phpstan`. Exceptions require documented `@phpstan-ignore` tags.
*   **100% Code Coverage Target:** `composer run phpunit-coverage-gaps` highlights missing test coverage. Use `@codeCoverageIgnore` with care and documentation (e.g., for infrastructure failsafes).
*   **Testing DX:** Prefer **Stubs over Mocks** (`createStub()`) where possible to reduce PHPUnit 12 strictness noise. The skeleton includes `vfsStream` for mocked filesystems.

## Volume Bindings
*Custom PHP Ini File:* <br>-v `/path/to/host/customPhpIniFile.ini`:`/usr/local/etc/php/conf.d/custom.ini`

*Multiple Ini:* <br>-v `/etc/phpIni/folder`:`/usr/local/etc/php/conf.d/`

*Project Files:* <br>-v `.`:`/app`

> **Important:** if you overwrite the `/app/vendor` folder or `composer.json`, the available scripts and tooling will be overridden by your project.

# Example: `docker run`

### Dependency Management
*Composer in current Dir*
```sh
docker run -v .:/app -it --rm pamodev/php-fpm-alpine:dev composer install
docker run -v .:/app -it --rm pamodev/php-fpm-alpine:dev composer update
```

*Composer Scripts*
```sh
docker run -v .:/app -it --rm pamodev/php-fpm-alpine:dev composer run-script $scriptName
```

### Composer Binaries
The directory `/app/vendor/bin` is added to the `$PATH`. Binaries can be called directly.
```sh
docker run -v .:/app -it --rm pamodev/php-fpm-alpine:dev phpunit
docker run -v .:/app -it --rm pamodev/php-fpm-alpine:dev phpcs
docker run -v .:/app -it --rm pamodev/php-fpm-alpine:dev phpstan
```

# Example: `Tooling on existing Projects`

Foreign Projects are tricky, but you could do something like this (using the dev stage for tooling):
```sh
docker run --rm -it \
  -v .:/src:ro \
  -w /src \
  pamodev/php-fpm-alpine:dev \
  /app/vendor/bin/phpunit --bootstrap /app/vendor/autoload.php .
```
*   Bind the Existing Project to `/src`
*   Make it `:ro` (read-only) so we don't modify stuff accidentally
*   We can now use the tooling but need to specify any path changes via params


[docker-compose.yaml @ Github](https://github.com/PamoDev/php-skeleton/blob/dev/docker-compose.yaml)
