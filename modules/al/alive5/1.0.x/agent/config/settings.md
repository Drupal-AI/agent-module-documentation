<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alive5 settings (config/settings.md)

Everything the module does is driven by the single config object **`alive5.settings`**, edited by
`Alive5SettingsForm` (`src/Form/Alive5SettingsForm.php`, extends `ConfigFormBase`, form id
`alive5_settings_form`).

## Install / enable / route

- `composer require drupal/alive5` then `drush en alive5`. No dependencies (core Node optional).
- Route **`alive5.settings`** → path `/admin/config/system/alive5`, `_form` =
  `\Drupal\alive5\Form\Alive5SettingsForm`, requirement `_permission: 'administer alive5'`.
- Permission **`administer alive5`** (`alive5.permissions.yml`), `restrict access: true` — treat as trusted.
- Menu link `alive5.settings` under `system.admin_config_system` (weight 10); one local task "Settings".
- `hook_requirements('runtime')` in `alive5.install` surfaces state on Reports → Status report:
  `Not configured` (WARNING, no widget id), `Disabled` (INFO, id set but `enabled` off), `Enabled` (OK).

## Config object keys (`config/install/alive5.settings.yml`, schema `config/schema/alive5.schema.yml`)

| key | type | default | meaning |
|---|---|---|---|
| `enabled` | boolean | `true` | Master switch. Off = widget loaded nowhere, rules ignored. |
| `widget_id` | string | `''` | Alive5 widget code id. Empty = nothing loads. |
| `script_url` | uri | `https://alive5.com/js/a5app.js` | Vendor script URL. Must be HTTPS. |
| `visibility_mode` | string | `all` | `all` \| `include` (selected pages only) \| `exclude` (all except selected). |
| `pages` | text | `''` | Newline path patterns; `*` wildcard, `<front>` token; each line starts with `/`. |
| `hide_on_admin` | boolean | `true` | Hide on admin routes (uses `AdminContext::isAdminRoute`). |
| `hide_on_user_pages` | boolean | `false` | Hide on `/user` and `/user/*`. |
| `hide_on_checkout` | boolean | `true` | Hide on `/cart`, `/cart/*`, `/checkout`, `/checkout/*`. |
| `user_visibility` | string | `all` | `all` \| `anonymous` \| `authenticated`. |
| `roles` | sequence | `{}` | Role ids; empty = any role. Match = user has ≥1 selected role. |
| `content_types` | sequence | `{}` | Node bundles; empty = no restriction. Only built when Node installed. |

Constants for the enum strings live on `Alive5WidgetManager`: `MODE_ALL/MODE_INCLUDE/MODE_EXCLUDE`,
`USERS_ALL/USERS_ANONYMOUS/USERS_AUTHENTICATED`.

## Form structure (`buildForm`)

- Top: `enabled` checkbox, `widget_id` textfield (maxlength 64, required via `#states` when enabled).
- `display` details: `visibility_mode` radios, `pages` textarea (shown only for include/exclude),
  `hide_on_admin`, `hide_on_user_pages`, `hide_on_checkout`.
- `audience` details: `user_visibility` radios, `roles` checkboxes (`getRoleOptions()`),
  `content_types` checkboxes (`getContentTypeOptions()`, only when `node` module exists).
- `advanced` details (collapsed): `script_url` (`#type => 'url'`, required, maxlength 255).

## Validation (`validateForm`) and save (`submitForm`)

- Enabled with empty `widget_id` → error. A non-empty `widget_id` must match
  `^[A-Za-z0-9_-]{8,64}$` (letters, digits, dash, underscore, 8–64 chars).
- `script_url` must pass `UrlHelper::isValid(..., TRUE)` **and** `^https://` (HTTPS required).
- If mode ≠ `all` and `pages` empty → error. Each non-empty, non-`<front>` pattern line must start `/`.
- `submitForm` normalises: trims each `pages` line and drops blanks (joined with `\n`); `sort()`s `roles`
  and `content_types`; `content_types` is only written when the element was present
  (`$form_state->hasValue('content_types')`), so removing/reinstalling Node preserves the selection.

## Operating notes

- Rules are AND-combined: a page shows the widget only when enabled, id+url set, and every rule passes
  (see [../services/widget_manager.md](../services/widget_manager.md)).
- Saving invalidates affected pages automatically via the `config:alive5.settings` cache tag (the config
  is a cacheable dependency of every page). Behind Varnish/CDN, purge that tag (e.g. Purge module).
- Config-only module: `drush config:export`/`config:import` round-trips fully; `hook_uninstall` deletes
  `alive5.settings`. No DB tables, no state.
