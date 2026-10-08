<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Canvas API (canvas_api) — agent index

Thin Drupal wrapper around Instructure's **Canvas LMS REST API**. The `2.x` branch exposes ONE
chainable service — `canvas_api` — that takes an HTTP method, a relative path, and params, then
returns the JSON-decoded response. No entities, fields, or public routes; just a building block for
custom code plus two admin screens.

- **Version:** 2.0.0-rc2 · **Core:** `^8 || ^9 || ^10 || ^11` · **License:** GPL-2.0-or-later
- **Dependencies (hard):** `canvas_lms` (supplies institution subdomain + environment), `key` (supplies the API token).
- **Provides:** service `canvas_api` (`Drupal\canvas_api\CanvasApiService`); admin settings form + admin tester form.
- **Config object:** `canvas_api.settings` with a single `key` value (a Key entity id). Host/environment live in `canvas_lms.settings` (`institution`, `environment`).
- **No** permissions.yml, schema, plugins, hooks (other than `hook_requirements`), or Drush.

## Routes (both require `administer site configuration`)
- `canvas_api.settings` → `/admin/config/canvas_api` — pick the Key entity holding the token.
- `canvas_api.tester` → `/admin/reports/canvas_api` — ad-hoc method/path/JSON-params request + `print_r` output.

## The service, in one call
```php
$data = \Drupal::service('canvas_api')
  ->setMethod('GET')
  ->setPath('courses/sis_course_id:3456/users')
  ->request();
```
Base URL = `https://<institution>[.test|.beta].instructure.com/api/v1/`. GET auto-paginates via the
`rel="next"` Link header (50-page fail-safe). Token sent as `Authorization: Bearer <token>` over HTTPS.

## Solution docs
- [agent/api/service.md](api/service.md) — `CanvasApiService` methods, URL/auth/pagination internals, param encoding.
- [agent/config/settings.md](config/settings.md) — install/enable, `canvas_lms`+`key` setup, config objects, routes, tester form.
