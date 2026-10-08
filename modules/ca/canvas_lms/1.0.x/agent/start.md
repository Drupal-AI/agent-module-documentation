<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Canvas LMS (canvas_lms) — agent index

A **base/"parent" module** for the Instructure Canvas LMS integration ecosystem. It stores exactly
**two shared settings** — `institution` and `environment` — in the config object
**`canvas_lms.settings`**, and does nothing else. Package `Canvas LMS`. **No dependencies.** Core
requirement `^8 || ^9 || ^10 | ^11` (single-pipe typo before `^11` is in the module's info.yml).
License GPL-2.0-or-later. Version 1.0.0-rc2 (version dir 1.0.x).

- **The settings form, the two config keys, routes and how to read them** →
  [config/settings.md](config/settings.md)

## What it actually is (from source)

- **One form:** `CanvasLmsSettingsForm` (`src/Form/CanvasLmsSettingsForm.php`), a `ConfigFormBase`
  editing `canvas_lms.settings`. Form id `canvas_lms_settings`. Two fields:
  - `institution` — textfield, the `*.instructure.com` subdomain.
  - `environment` — radios: `test` / `beta` / `production`.
  `submitForm()` writes both values back to `canvas_lms.settings` and calls `parent::submitForm()`.
- **Two routes** (`canvas_lms.routing.yml`):
  - `canvas_lms.admin_config` → `/admin/config/canvas_lms`, a `SystemController::systemAdminMenuBlockPage`
    landing page; permission **`administer site configuration`**.
  - `canvas_lms.settings` → `/admin/config/canvas_lms/canvas_lms`, the form above; permission
    **`administer site configuration`**, `_admin_route: TRUE`.
- **Two menu links** (`canvas_lms.links.menu.yml`): the config landing under `system.admin_config`,
  and the settings link under it.

## What it does NOT provide

- No `.module`, `.install`, `.services.yml`, `.permissions.yml` files.
- **No config schema** — there is no `config/schema/` (or any `config/`) directory on disk; the two
  keys are untyped. No default config is installed.
- **No API client, no HTTP calls, no Canvas host construction** — it only stores strings. Consuming
  modules (Canvas API, Canvas LTI) build the actual base URL and handle their own API tokens.
- No entities, no plugins, no field types/formatters/widgets, no Drush commands, no custom
  permissions, no hooks.

## Reading the settings from another module

```php
$config = \Drupal::config('canvas_lms.settings');
$institution = $config->get('institution');   // e.g. "myschool"
$environment = $config->get('environment');    // "test" | "beta" | "production"
```
