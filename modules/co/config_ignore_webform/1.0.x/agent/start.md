<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Ignore Webform (config_ignore_webform) — agent index

info.yml name **"Config Ignore Webform"**, version **1.0.1**, package **Webform**. A small helper that
makes [Config Ignore](https://www.drupal.org/project/config_ignore) ignore **all** webform config during
config import/export, with automatic and configurable exceptions. Core `^10.3 || ^11`, PHP `>=8.1`,
GPL-2.0-or-later.

Hard dependencies: **`config_ignore:config_ignore`** (`^3`) and **`webform:webform`** (`^6`). No install
hooks, no `.permissions.yml`, no Drush, no plugin types, no entities.

- **The whole mechanism, config object, routes, service and hook** → [config/settings.md](config/settings.md)

## What it actually is (from source)

- One `hook_config_ignore_ignored_alter()` implementation. Modern OO hook:
  `src/Hook/ConfigIgnoreHooks.php` (`#[Hook('config_ignore_ignored_alter')]`), with a `#[LegacyHook]`
  procedural shim in `config_ignore_webform.module` for Drupal 10. It delegates to the service
  `WebformTemplateConfigIgnore::alterIgnored()` (`src/WebformTemplateConfigIgnore.php`).
- The service adds two ignore patterns — `webform.webform.*` and `webform.webform_options.*` — to every
  Config Ignore list (directions `import`/`export` × operations `create`/`update`/`delete`), then adds
  `~`-prefixed **exception** patterns so certain items still sync.
- Exceptions are built dynamically because Config Ignore matches by config name only:
  1. **Templates** — every `webform.webform.{id}` whose stored data has `template: true` (checked in
     both active and sync storage) → `~webform.webform.{id}`.
  2. **Allowlisted webforms** — IDs in `config_ignore_webform.settings:excluded_webforms`.
  3. **Allowlisted option lists** — IDs in `config_ignore_webform.settings:excluded_webform_options`
     (option lists have no template flag; allowlist-only).
- One settings form `WebformConfigIgnoreSettingsForm` (`ConfigFormBase`), form id
  `config_ignore_webform_settings`, editing config object **`config_ignore_webform.settings`**.

## Routes (both `_permission: 'administer webform'`)

- `config_ignore_webform.settings` → `/admin/config/development/configuration/webform-ignore`
  (local task "Webforms" next to Config Ignore on config sync; also a menu link under config sync).
- `config_ignore_webform.settings_webform` → `/admin/structure/webform/config/ignore`
  (local task "Config ignore" in the Webforms admin). Both render the same form.

## Config

- Object `config_ignore_webform.settings` — two sequences: `excluded_webforms`,
  `excluded_webform_options` (schema in `config/schema/`, empty defaults in `config/install/`).

Not to be confused with the older, separate **Webform Config Ignore** (Config Filter based) module.
