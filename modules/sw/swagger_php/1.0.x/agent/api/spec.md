<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Swagger-PHP — generating and serving the spec

## Endpoints
- `GET /api/spec` — OpenAPI 3 JSON (`OpenApiController::specJson`), permission `access swagger_php spec`, `no_cache: TRUE`.
- `GET /api/docs` — Swagger UI page (`swaggerUi`), permission `access swagger_php docs`.
- `/admin/config/services/swagger_php` — set `scan_folder`, permission `administer swagger_php settings` (`restrict: true`).

## How generation works
`OpenApiSpecGenerator::generateJsonSpec()`:
1. Reads `swagger_php.settings:scan_folder` (default `modules/custom`).
2. Scan path = `DRUPAL_ROOT . '/' . scan_folder`.
3. `OpenApi\Generator::scan([$scan_path], ['exclude' => ['*/.git','*/.svn','*/node_modules'], 'logger' => new SilentLogger()])`.
4. Returns `$openapi?->toJson()`.

Attributes are parsed, not executed. Document endpoints with `#[OA\Info]`, `#[OA\Get]`, `#[OA\Path]` etc. in files under the scanned folder.

## Install requirements
- `composer require zircote/swagger-php`.
- Swagger UI dist assets at `/libraries/swagger-ui/dist/` (library `swagger_php/swagger-ui`).

## Access guidance
Grant `access swagger_php spec` / `access swagger_php docs` only to trusted roles if the documented API reveals internal endpoints/params you do not want anonymous users to enumerate.
