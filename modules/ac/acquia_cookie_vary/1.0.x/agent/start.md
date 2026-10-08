<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Acquia Cookie Vary (acquia_cookie_vary) — agent index

Adds Acquia-specific `Vary` HTTP headers to cacheable responses so the Acquia platform's **Varnish**
layer can full-page-cache content that differs by cookie. Package `performance`. Core
`^10.3 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.0.0. **No module dependencies**, no
composer requirements, no submodules, no permissions of its own, no Drush, no entities/fields/plugins.

- **The one config object, the settings form, the route/permission, and exactly how the header
  logic works** → [config/settings.md](config/settings.md)

## What it actually is

- **One event subscriber**: `ResponseSubscriber`
  (`src/EventSubscriber/ResponseSubscriber.php`), service id
  `acquia_cookie_vary.response_subscriber` (`acquia_cookie_vary.services.yml`, `autowire: true`),
  subscribed to `KernelEvents::RESPONSE` at priority **1000** via `onKernelResponse()`.
- **One settings form**: `SettingsForm` (`src/Form/SettingsForm.php`), a `ConfigFormBase`, form id
  `acquia_cookie_vary_settings`.
- **One config object**: `acquia_cookie_vary.settings` — keys `custom_cookie` (string, default `''`)
  and `debug` (boolean, default `false`). Schema in `config/schema/acquia_cookie_vary.schema.yml`;
  defaults in `config/install/acquia_cookie_vary.settings.yml`. `provides_config_schema: true`.
- **One route**: `acquia_cookie_vary.settings` → `/admin/config/services/acquia-cookie-vary`,
  `_form: SettingsForm`, `_permission: 'administer site configuration'`
  (`acquia_cookie_vary.routing.yml`). Admin menu link in `acquia_cookie_vary.links.menu.yml`.

## Mechanism (from source)

- `onKernelResponse()` acts only when the response is a `CacheableResponseInterface`. It reads the
  response's cache contexts via `getCacheableMetadata()->getCacheContexts()`.
- Fixed mapping `PLATFORM_COOKIES` (a class constant): `acquia_a → X-Acquia-Cookie-A`,
  `acquia_b → X-Acquia-Cookie-B`, `acquia_c → X-Acquia-Cookie-C`. For each, if the context
  `cookies:<name>` is present, it calls `$response->setVary('<header>', FALSE)` (the `FALSE`
  **appends** rather than replacing the existing `Vary`).
- The configured `custom_cookie` name, if its `cookies:<name>` context is present, adds
  `Vary: X-Acquia-Cookie-Key` **and** `Vary: X-Acquia-Cookie-Value`.
- **Only adds `Vary` values that mirror cache contexts the page already declares** — it never
  removes varying and never caches content that was not already varied by that cookie.
- **Debug mode** (`debug` == true): additionally reflects the current request's cookie value(s)
  back as `X-Acquia-Cookie-*` response headers (e.g. `X-Acquia-Cookie-A: <acquia_a value>`) to help
  verify plumbing. Off by default.

## Tests (reference for behavior)

- `tests/src/Kernel/ResponseSubscriberTest.php`, `tests/src/Functional/ResponseSubscriberTest.php`,
  `tests/src/Functional/SettingsFormTest.php`, plus a helper submodule
  `tests/modules/acquia_cookie_vary_test/` (config override fixture). Not shipped/enabled in
  production.
