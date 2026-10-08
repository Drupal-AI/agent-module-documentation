<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Swagger-PHP scans a configurable folder for `#[OA\...]` PHP attributes using zircote/swagger-php's Generator and exposes the resulting OpenAPI 3 document as JSON at `/api/spec`, rendered interactively via Swagger UI at `/api/docs`.
---
The module wraps the `zircote/swagger-php` library. `OpenApiSpecGenerator::generateJsonSpec()` builds the scan path as `DRUPAL_ROOT . '/' . config('swagger_php.settings')->get('scan_folder')` (default `modules/custom`), runs `Generator::scan()` excluding `.git`, `.svn` and `node_modules`, and returns the spec JSON. The scanner only parses attributes/annotations — it does not execute the scanned code — and a `SilentLogger` suppresses parser warnings.

Three routes each carry their own permission: `/api/spec` (`access swagger_php spec`, JSON, `no_cache`), `/api/docs` (`access swagger_php docs`, Swagger UI page), and the settings form `/admin/config/services/swagger_php` (`administer swagger_php settings`, `restrict: true`). Because the spec and docs are permission-gated rather than public by default, exposing internal endpoints to anonymous users only happens if an administrator explicitly grants those permissions to the anonymous role — treat that as a deliberate choice. Swagger UI assets are loaded from a local `/libraries/swagger-ui` install.

Setup: install the `zircote/swagger-php` library via Composer and the Swagger UI dist assets under `/libraries/swagger-ui`, set the folder to scan on the settings form, and grant the spec/docs permissions to the appropriate roles.
---
- Generate an OpenAPI 3 JSON spec from PHP attributes.
- Serve the spec at `/api/spec` as `application/json`.
- Render interactive API docs via Swagger UI at `/api/docs`.
- Configure which folder is scanned for OpenAPI attributes.
- Restrict spec access with the `access swagger_php spec` permission.
- Restrict docs access with the `access swagger_php docs` permission.
- Lock the settings form behind `administer swagger_php settings`.
- Document custom module APIs by annotating controllers with `#[OA\...]`.
- Exclude `.git`, `.svn`, and `node_modules` from scanning automatically.
- Suppress swagger-php parser warnings via the silent logger.
- Keep the spec response uncached (`no_cache`) for live regeneration.
- Point the scanner at `modules/custom` or any DRUPAL_ROOT-relative path.
- Share live API docs with front-end developers.
- Validate that annotated endpoints produce a valid OpenAPI document.
- Expose the spec to authenticated API consumers only.
- Embed Swagger UI in the site using local library assets.
- Regenerate the spec on every request without a rebuild step.
- Audit which endpoints are documented across scanned modules.