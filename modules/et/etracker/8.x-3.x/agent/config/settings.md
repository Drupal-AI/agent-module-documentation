<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# eTracker settings, config & permissions

## Install & enable

```bash
composer require drupal/etracker
drush en etracker -y
```

No PHP/library dependencies. `hook_requirements()` (`etracker.install`, runtime phase) shows a
`REQUIREMENT_WARNING` ("Not configured") on the status report until `account_key` is set.

## Route, menu & permissions

- Route **`etracker.admin_settings_form`** — `/admin/config/system/etracker`, `_form` =
  `\Drupal\etracker\Form\EtrackerAdminSettingsForm`, `requirements: _permission: 'administer etracker'`
  (`etracker.routing.yml`). Menu link under `system.admin_config_system` (`etracker.links.menu.yml`).
- Permissions (`etracker.permissions.yml`):
  - **`administer etracker`** — access the settings form.
  - **`opt-in or out of etracker tracking`** — see and set the per-user tracking checkbox on the user form.

## Config object `etracker.settings`

Written by `EtrackerAdminSettingsForm::submitForm()`; schema in `config/schema/etracker.schema.yml`; install
defaults in `config/install/etracker.settings.yml`. Constant `Constants::ETRACKER_SETTINGS_CONFIG_NAME`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `account_key` | string | `''` | etracker account key, emitted as `data-secure-code`. Validated `/^\w{6,}$/` (≥6 word chars), trimmed. **Required** on the form. |
| `etracker_scope_script` | string | `header` | `header` or `footer` (`Constants::ETRACKER_SCOPE_SCRIPT_*`). Header adds `'header' => TRUE` to the library. |
| `etracker_track_path_mode` | string | `all_pages` | `all_pages` = track everywhere except listed; `listed_pages` = only listed (`ETRACKER_TRACK_PATHS_MODE_*`). |
| `etracker_track_paths` | string | `/admin`,`/admin/*`,`/batch`,`/node/add*`,`/node/*/*`,`/user/*/*` (newline list) | Path patterns (`*` wildcard, `<front>` token). Each line must start with `/` or be `<front>` (validated). |
| `etracker_track_roles_mode` | string | `all_roles` | `all_roles` = all except selected; `listed_roles` = only selected (`ETRACKER_TRACK_ROLES_MODE_*`). |
| `etracker_track_roles` | sequence | `[]` | Role IDs to include/exclude. |
| `etracker_track_user` | string | `no_customization` | `no_customization`, `tracking_on` (opt-out), `tracking_off` (opt-in) (`ETRACKER_TRACK_USER_*`). |
| `etracker_mode_breadcrumb_as_area` | string | `breadcrumb_exclude_home` | `breadcrumb_off`, `breadcrumb_on`, `breadcrumb_exclude_home` (`ETRACKER_MODE_BREADCRUMB_*`). |
| `etracker_script_settings.data_block_cookies` | bool | `true` | Cookie-less tracking → `data-block-cookies` attribute. |
| `etracker_script_settings.data_respect_dnt` | bool | `true` | Respect Do-Not-Track → `data-respect-dnt` attribute. |
| `event_tracking.track_mailto` | bool | `true` | Track `mailto:` clicks. |
| `event_tracking.track_download` | bool | `true` | Track download-link clicks. |
| `event_tracking.track_download_extensions` | string | `pdf doc docx` | Space-separated extensions treated as downloads. |
| `event_tracking.track_external` | bool | `true` | Track outbound-link clicks. |
| `event_tracking.track_system_messages` | sequence | `[]` | Any of `status`/`warning`/`error` to track as events. |

## Settings form (`EtrackerAdminSettingsForm`)

`ConfigFormBase`, form id `etracker_admin_settings`, `getEditableConfigNames()` = `['etracker.settings']`.
Fields are grouped: a **General** details (account key + script position) and a **Tracking scope**
`vertical_tabs` set with details groups *Pages*, *Roles*, *Users*, *Breadcrumb*, *Links and downloads*,
*Messages*, *Privacy* (the vertical tabs attach `etracker/etracker.admin`, `js/etracker.admin.js`, which only
renders tab summaries).

- `validateForm()`: trims `account_key`/`etracker_track_paths`, filters role/message checkboxes, enforces the
  `/^\w{6,}$/` account-key rule and the leading-slash rule on each track path.
- `submitForm()`: assembles `etracker_script_settings` (privacy) and `event_tracking` maps, saves, then
  `Cache::invalidateTags(['library_info'])` so `hook_library_info_build()` re-runs with the new attributes.

## Config export example

```yaml
# etracker.settings
account_key: 'AbC123'
etracker_scope_script: header
etracker_track_path_mode: all_pages
etracker_track_paths: "/admin\n/admin/*\n/batch\n/node/add*\n/node/*/*\n/user/*/*"
etracker_track_roles_mode: all_roles
etracker_track_roles: {  }
etracker_track_user: no_customization
etracker_mode_breadcrumb_as_area: breadcrumb_exclude_home
etracker_script_settings:
  data_block_cookies: true
  data_respect_dnt: true
event_tracking:
  track_mailto: true
  track_download: true
  track_download_extensions: 'pdf doc docx'
  track_external: true
  track_system_messages: {  }
```

## Per-user opt-in/out (`hook_form_user_form_alter`)

When the current user has `opt-in or out of etracker tracking` **and** `etracker_track_user` is not
`no_customization`, a fieldset with an *Enable user tracking* checkbox is added to the user form; its default
follows the site setting (on/off) unless the user already chose. The submit handler
`etracker_form_user_form_submit()` stores the choice in `user.data` under module `etracker`, key
`etracker_enable_tracking`. `_etracker_user_should_be_tracked()` reads it back when deciding whether to attach
the tracker.

## Update hooks (`etracker.install`)

- `etracker_update_8101()` — seeds `event_tracking` and merges `etracker_script_settings` defaults from
  `config/install`.
- `etracker_update_8102()` — prefixes existing `etracker_track_paths` entries with `/` if missing.
