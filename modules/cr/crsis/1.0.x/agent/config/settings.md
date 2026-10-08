<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CRSIS configuration, routes & permissions

## Install & enable

```bash
composer require drupal/crsis
drush en crsis -y
```

Only dependency is core **`node`** (`crsis.info.yml`). PHP `>=8.1` (composer.json). No sub-modules,
no Drush commands, no third-party libraries.

## Settings form

- Form `CrsisSettingsForm` (`ConfigFormBase`, `src/Form/`), route **`crsis.settings`** at
  `/admin/config/content/crsis`, permission **`administer crsis`** (`crsis.routing.yml`).
  `configure` link in `crsis.info.yml` points here; menu link under
  *Configuration → Content authoring* (`crsis.links.menu.yml`), local task "Settings"
  (`crsis.links.task.yml`).
- `getEditableConfigNames()` → `['crsis.settings']`. `getFormId()` → `crsis_settings_form`.
- Fields:
  - `enable` — checkbox, "Enable readability analysis", default from config.
  - `minimum_score` — number (`#min` 0, `#max` 100, `#required`), default `config->get('minimum_score') ?? 60`.
- `submitForm()` writes `enable` (cast to bool) and `minimum_score` (cast to int) back to
  `crsis.settings` and saves. Standard `ConfigFormBase` CSRF/form handling applies.

## Config object & schema

Config object **`crsis.settings`**:

| Key | Type | Install default | Meaning |
|---|---|---|---|
| `enable` | boolean | `true` | Whether readability analysis is considered enabled. Drives the dashboard warning banner; does not stop the scoring loop. |
| `minimum_score` | integer | `60` | Threshold below which a node gets a "below minimum" suggestion (used in `ReadabilityService::getSuggestions()`). |

- Schema: `config/schema/crsis.schema.yml` (`crsis.settings` as `config_object` with the two
  mappings above).
- Install defaults: `config/install/crsis.settings.yml` (`enable: true`, `minimum_score: 60`).

Config export example:

```yaml
# crsis.settings.yml
enable: true
minimum_score: 60
```

## Routes

| Route | Path | Controller / Form | Permission |
|---|---|---|---|
| `crsis.dashboard` | `/admin/content/crsis-dashboard` | `DashboardController::view` | `access crsis dashboard` |
| `crsis.settings` | `/admin/config/content/crsis` | `CrsisSettingsForm` | `administer crsis` |

## Permissions (`crsis.permissions.yml`)

- **`access crsis dashboard`** — "Access CRSIS dashboard": view the readability dashboard. Grant to
  content-editor / administrator roles.
- **`administer crsis`** — "Administer CRSIS": configure module settings. Marked
  `restrict access: true` (administrators only).

## Operating notes

- Turning `enable` off does not remove or stop the dashboard; it only shows a warning banner
  linking back to this form. The dashboard is gated purely by the `access crsis dashboard`
  permission.
- The dashboard analyzes only the node **body** field of the 50 most recently changed published
  nodes; there is no per-content-type or per-field configuration.
