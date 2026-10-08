<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# pmfs configuration

Config object: **`pmfs.settings`** (route `pmfs.settings` at `/admin/config/system/pmfs`,
`administer site configuration`). Schema: `config/schema/pmfs.schema.yml`. Install defaults:
`config/install/pmfs.settings.yml`. Config-translation is supported (`pmfs.config_translation.yml`).

## Shape
```yaml
form:
  _global:            # the default applied to every form when it has no per-id entry
    status: false     # master default; a per-form entry usually sets status: true
    timeout: 30        # seconds the lock is held
    skip_timeout: false
    message: 'The form still processing, please, try again later.'
    attach_form_lib: false
  <form_id>:          # per-form override, e.g. user_register_form
    status: true
    timeout: 30
    skip_timeout: false
    message: '...'
    attach_form_lib: false
custom:               # per-custom-operation entries (see service-api.md)
  <custom_id>:
    status: true
    timeout: 30
    skip_timeout: false
    message: '...'
    # note: 'custom' entries have no attach_form_lib key
```

## Keys (constants in `Drupal\pmfs\Pmfs`)
- **status** (`KEY_STATUS`) — enable pmfs for this form/custom id. A form is only altered when
  `isFormEnabled()` is true. `_global.status` is the fallback default (ships `false`).
- **timeout** (`KEY_TIMEOUT`) — seconds the persistent lock is held after a submit (default 30).
- **skip_timeout** (`KEY_SKIP_TIMEOUT`) — release the lock as soon as the initial submit
  finishes, so only genuine concurrency (not the whole window) is blocked.
- **message** (`KEY_MESSAGE`) — validation/error text shown when a duplicate is rejected.
  For the `_global` form entry this message is required (admin form validation rejects empty).
- **attach_form_lib** (`KEY_FORCE_ATTACH_FORM_LIBRARY`) — forms only: force-attach
  `core/drupal.form` to the configured form (helps when the library was not attached).

Per-form settings resolve via `getFormSettings()` = `_global` defaults merged with the
`form.<id>` entry; custom settings via `getCustomSettings()` similarly.

## Admin form (`src/Form/Settings.php`)
- "Form settings": the `_global` item plus one collapsible item per configured form id;
  a "New configuration item" row (enter a Form ID, Save) adds an entry via AJAX; each existing
  item has a Remove button. Saving releases any currently-held lock for that form id.
- "Custom request settings": one item per known custom id (or "No custom calls detected.").
- "Development tools": a checkbox to enable dev mode (State `pmfs.dev_mode.enabled`) and a
  read-only list of detected form ids (State `pmfs.dev_mode.detected_form_ids`) to help you
  discover the exact `form_id` values to configure. Disabling dev mode clears the detected list.

## Finding a form id
Enable development mode, visit the pages whose forms you want to protect, then return to the
settings page — every rendered form id appears in the "detected FORM_IDs" list. Add a form
entry for the id you want and set `status: true`.
