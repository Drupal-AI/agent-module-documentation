<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Project Browser API Browser (api_browser) — agent index

Builds **Project Browser source plugins from external JSON APIs**. Each connection is an
`api_browser_service` **config entity**; a deriver turns every service into a Project Browser
source that appears as its own tab under *Extend*. Version **2.0.0-beta1**. Core `^11.2 || ^12`,
PHP **>=8.3**. License GPL-2.0-or-later.

- **Depends on** core-ecosystem `project_browser` (`^2.1`) and the composer lib
  `mtdowling/jmespath.php` (`^2.7`). Suggests `drupal/key`. No Drush.
- **Permission** (one): `administer api_browser_service` (`restrict access: true`) — gates every
  route and all entity operations (`ApiBrowserServiceAccessControlHandler`).
- **Config entity** `api_browser_service` (prefix `service`) — the whole feature. Schema in
  `config/schema/api_browser.schema.yml`; six example services ship in `config/install/`.
- **Settings** config object `api_browser.settings` (`concurrency`, `max_retries`, `debug.enable`).
- **Plugin** `ProjectBrowserSource` `api_browser_project` (deriver `ApiBrowserProjectBrowser`).
- **Service** `api_browser.retry_middleware` — an `http_client_middleware` that retries 429/503.
- **Alter hooks** for request/response/project/auth customisation (`api_browser.api.php`).

## Solution docs

- **The service config entity — request pipeline, JMESPath, Twig field mapping, pagination,
  filters** → [entities/service.md](entities/service.md)
- **Authentication (API key / bearer / basic / OAuth2) and Key-module secrets** →
  [entities/authentication.md](entities/authentication.md)
- **The source plugin, deriver, tabs, filters, routes & permissions, controller actions** →
  [plugins/source.md](plugins/source.md)
- **Module settings, retry middleware, caching & the credentials status warning** →
  [config/settings.md](config/settings.md)
- **Alter hooks** → [api/hooks.md](api/hooks.md)

## What it actually is (from source)

- No content entities, no fields, no formatters. The unit of configuration is the
  `ApiBrowserService` config entity (`src/Entity/ApiBrowserService.php`), which also carries the
  entire HTTP/mapping engine as protected methods.
- A service = a **listing** request (required, returns many records) + an optional **project**
  request (per record, fills in detail) + a **field_mapping** (Twig per Project field). JMESPath
  `path` values pull records out of each JSON body; Twig templates reshape them.
- Every service is derived into the `api_browser_project:<id>` source plugin. Enabling that source
  in Project Browser's own settings makes it a tab. Nothing is enabled automatically.
- All HTTP goes through Drupal's `\Drupal::httpClient()` (TLS verified by default); the module's
  own retry middleware only acts on requests that opt in.
