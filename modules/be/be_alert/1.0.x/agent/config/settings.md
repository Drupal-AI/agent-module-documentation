<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BE-Alert configuration & API keys

## Install / enable
`drush en be_alert -y`. No composer or module dependencies (core only). No `.install` file, no
`config/install/` defaults — the `be_alert.settings` object starts empty until the form is saved.

## Settings form
- Route `be_alert.global_settings` → path `/admin/config/system/be-alert-settings`, form
  `Drupal\be_alert\Form\GlobalSettingsForm` (extends `ConfigFormBase`), permission
  **`administer site configuration`** (`be_alert.routing.yml`). Menu link defined in
  `be_alert.links.menu.yml` under `system.admin_config_system`.
- Two text fields inside `sandbox` and `production` fieldsets (both `#tree => TRUE`):
  each an `api_key` textfield. `submitForm()` writes `sandbox.api_key` and `production.api_key`
  into `be_alert.settings`. `getEditableConfigNames()` returns `['be_alert.settings']`.

## Config object & schema
- Config object: **`be_alert.settings`** (`config/schema/be_alert.schema.yml`), type `config_object`:
  - `sandbox.api_key` — string
  - `production.api_key` — string
- Block schema: **`block.settings.be_alert_live`** (type `block_settings`) with one mapping
  key `use_sandbox` (boolean) — the per-block environment toggle.

## Notes
- Keys are plain config strings (no Key-module integration). They are sent only as the `x-api-key`
  HTTP request header to publicalerts.be, never placed in a URL.
- Which key is used is decided by each block instance's `use_sandbox` setting, not by a global
  environment switch. A block with sandbox on uses `sandbox.api_key` + the sandbox feed; off uses
  `production.api_key` + the production feed.
