# Docker PHP Skeleton - Architecture & DX Upgrade

Dieses Update hebt das Base-Image und das zugehörige Tooling auf ein neues Level. Der Fokus lag auf der sauberen Trennung von Dev- und Prod-Umgebungen, der Durchsetzung strenger Qualitätsstandards (PHPStan Level 9, 100% Coverage Target) und einer massiven Verbesserung der Developer Experience (DX).

## Änderungen & Warum

### 1. Multi-Stage Docker Build (`etc/PhpAlpineDockerfile` & `.dockerignore`)
*   **Was:** Einführung von `base`, `prod` und `dev` Stages.
*   **Warum:** Bisher gab es nur ein "One-Size-Fits-All"-Image. Jetzt haben wir ein schlankes, performantes `:latest` / `:8.4` Image für Produktion (`memory_limit=64M`, Logging via `stderr`, **kein** Xdebug) und ein vollausgestattetes `:dev` Image für Tooling (`memory_limit=256M`, Xdebug inkl. Profiler aktiviert).
*   **Was:** Docker Layer Caching optimiert und redundante Extensions (gd, intl) entfernt. Native Integration von `redis` und `imagick`.
*   **Warum:** Beschleunigt zukünftige Builds massiv. `redis` ist zwingend für das Caching in den Kind-Projekten erforderlich.
*   **Was:** `.dockerignore` um `tests/`, `public/` und `.idea/` erweitert.
*   **Warum:** Verhindert, dass Skeleton-Dummy-Dateien in den Build-Context der Endnutzer-Projekte "ausbluten" und Konflikte verursachen.

### 2. Dependency Management & Quality Gates (`composer.json`)
*   **Was:** Update auf PHPUnit `^12.5.0`, PHPStan Level 9 Enforcment via `composer phpstan` und Integration von `mikey179/vfsstream`.
*   **Warum:** Angleichung an die Guidelines der Kind-Projekte. `vfsStream` ist ein Architektur-Muss, um die geforderte 100% Code-Coverage bei File-Operationen sauber zu erreichen (Stubs over Mocks).
*   **Was:** Neues Test-Chain Scripting (`"test": ["@phpcs", "@phpstan", "@phpunit"]`) und granulare Coverage-Skripte (z.B. `phpunit-coverage-gaps`). Veraltetes `PSR2` entfernt (Fokus auf `PSR12`).
*   **Warum:** Massive DX-Verbesserung. Ein Entwickler tippt `composer test` und durchläuft lokal die exakt gleiche Pipeline wie später in der CI.

### 3. Developer Experience (DX) & Automation
*   **Was:** `README.md` komplett überarbeitet.
*   **Warum:** Dokumentiert nun glasklar die neuen Docker-Stages, die Quality Standards (Coverage/PHPStan) und liefert copy-paste-fertige `docker run` Befehle.
*   **Was:** Automation-Skripte `etc/DockerBuildPhpFpmAlpine.sh` und `etc/DockerPushPhpFpmAlpine.sh` (inkl. Dev/Prod Split) erstellt.
*   **Warum:** Standardisiert den Release-Prozess für Dockerhub und macht den Build fehlerunanfällig.
