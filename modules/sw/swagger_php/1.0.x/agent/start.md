<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Swagger-PHP OpenAPI 3 generator (swagger_php) — agent index

**Scans PHP attributes with zircote/swagger-php to produce an OpenAPI 3 spec, served as JSON and via Swagger UI.**

- **Version:** 1.0.x
- **Core:** ^10.2 || ^11.1
- **Library:** `zircote/swagger-php` (Generator::scan) + Swagger UI dist under `/libraries/swagger-ui`
- **Routes / permissions:**
  - `/api/spec` → `OpenApiController::specJson` — `access swagger_php spec` (no_cache)
  - `/api/docs` → `OpenApiController::swaggerUi` — `access swagger_php docs`
  - `/admin/config/services/swagger_php` → `SettingsForm` — `administer swagger_php settings` (restrict)
- **Service:** `swagger_php.generator` (`OpenApiSpecGenerator`), config `swagger_php.settings:scan_folder` (default `modules/custom`)
- **Security:** All three routes are permission-gated; the spec/docs are NOT anonymous by default. The scanner only PARSES attributes (no code execution). `scan_folder` is a DRUPAL_ROOT-relative path set only by an admin (`restrict: true`). Exposing internal endpoints to anonymous users requires an admin to grant the spec/docs permission to the anonymous role — a deliberate configuration, not a default.

See [api/spec.md](api/spec.md)