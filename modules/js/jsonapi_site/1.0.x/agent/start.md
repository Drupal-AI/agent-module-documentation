<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON:API Basic Site Settings (jsonapi_site) — agent index

Adds a single read-only endpoint, **`GET /jsonapi/site/site`**, that returns a JSON:API-shaped
document carrying a handful of `system.site` and theme configuration values so a decoupled front end
can read them from Drupal instead of hard-coding its own copies. These values are *configuration*,
not entities, so core JSON:API has no resource for them — this module fills that gap. The whole
module is one controller method
(`JsonapiSiteController::returnJson`, `src/Controller/JsonapiSiteController.php`) that reads three
config objects (`system.site`, `system.theme`, `system.theme.global`), assembles the payload, runs it
through **`hook_jsonapi_site_data_alter()`**, and returns it as `application/vnd.api+json`.

The route (`jsonapi_site.routing.yml`) requires `_user_is_logged_in: 'TRUE'` and restricts
authentication to **`key_auth`** via `options._auth`, so a caller must present a valid Key Auth API
key belonging to a user who holds the `use key authentication` permission; session-cookie auth does
not apply to this route and anonymous requests get a 403. There is no admin form, no config schema of
its own, and no permissions defined by this module — the only extension point is the alter hook
(documented in `jsonapi_site.api.php`), which is how a site both adds custom values and, if it
chooses, adjusts what is returned.

- Depends on: `drupal:jsonapi` (core), `key_auth:key_auth` (contrib — the authentication mechanism).
- Core: `^9 || ^10 || ^11`. Package: `Web services`. Composer: `drupal/jsonapi_site`.
- Settings page / configure route: none. Config schema: none.
- Permissions defined: none (access is `_user_is_logged_in` + `key_auth`). Drush: none. Plugin types: none.
- Hooks invoked: `hook_jsonapi_site_data_alter(&$data)`.

## What you'd do → where
- Call the endpoint, understand the response shape, its access model, and the alter hook → [api/site-endpoint.md](api/site-endpoint.md)

## Key facts (real machine names)
- Route: `jsonapi_site.basic_settings` → path `/jsonapi/site/site`, method `GET`,
  `options._auth: ['key_auth']`, `defaults._is_jsonapi: TRUE`,
  requirements `_content_type_format: api_json`, `_format: api_json`, `_user_is_logged_in: 'TRUE'`.
- Controller: `Drupal\jsonapi_site\Controller\JsonapiSiteController::returnJson`.
- Hook: `hook_jsonapi_site_data_alter(&$data)` (alters `data.attributes`; see `jsonapi_site.api.php`).
- Config read: `system.site` (`uuid`, `name`, `mail`, `slogan`, `page.front`, `page.403`, `page.404`,
  `default_langcode`), `system.theme` (`default`, `admin`), `system.theme.global`
  (`logo.path`, `favicon.path`).
- Response `Content-Type`: `application/vnd.api+json`; `data.type: "site--site"`, `data.id: <site uuid>`.
