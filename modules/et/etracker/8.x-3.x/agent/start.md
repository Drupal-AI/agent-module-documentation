<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# eTracker Analytics (etracker) — agent index

Integrates the **etracker** web-analytics service by attaching its client-side tracking snippet to configured
pages. No PHP dependencies; core `^9 || ^10 || ^11`; package `Statistics`; license GPL-2.0-or-later; version
8.x-3.x (installed release 8.x-3.2). An etracker account (paid) is required. Procedural code (`.module`), no
entities or plugins.

- **Settings form, config object/schema, permissions, install/enable** → [config/settings.md](config/settings.md)
- **How the tracking script is emitted (libraries, page attachments, inline script, event JS, CSP)** →
  [api/tracking.md](api/tracking.md)

## What it actually is

- No routes except the admin form `etracker.admin_settings_form` (`/admin/config/system/etracker`,
  `_permission: 'administer etracker'`; menu link under *Configuration → System*).
- Config object **`etracker.settings`** (schema `config/schema/etracker.schema.yml`, install defaults
  `config/install/etracker.settings.yml`). Editable only via `EtrackerAdminSettingsForm`
  (`src/Form/EtrackerAdminSettingsForm.php`).
- Two permissions (`etracker.permissions.yml`): **`administer etracker`** (settings form) and
  **`opt-in or out of etracker tracking`** (per-user tracking choice on the user form).
- One service: `etracker.csp_subscriber` → `src/EventSubscriber/CspSubscriber.php` (adds the tracking domain
  to CSP `script-src`/`script-src-elem` when the `csp` module is present).
- String constants (config name, JS URL, mode values) in `src/Helper/Constants.php`.
- `hook_requirements()` (runtime) warns if `account_key` is empty (`etracker.install`); update hooks
  `etracker_update_8101/8102` seed new config keys / slash-prefix track paths.
- Submodule **cookies_etracker** (own nested doc tree) integrates with COOKiES consent.

## Key mechanism (from source, `etracker.module`)

- `hook_library_info_build()`: defines library `etracker/etracker.js` = external
  `https://code.etracker.com/code/e.js` (id `_etLoader`, `async`, `data-secure-code` = account key,
  `data-block-cookies`, `data-respect-dnt`); optionally a header scope; and library `etracker/event_tracking`
  (`js/etracker.js`) when any event tracking is on.
- `hook_page_attachments()`: if `account_key` set and `_etracker_path_should_be_tracked()` &&
  `_etracker_user_should_be_tracked()`, attaches the libraries + `drupalSettings.etracker` (event flags,
  extensions, messages) + an inline `<head>` script of `rawurlencode`d `et_pagename`/`et_areas` and
  `_btNoJquery`.
- `hook_form_user_form_alter()` + submit: per-user opt-in/out stored in `user.data` (`etracker` /
  `etracker_enable_tracking`).

## Notes for agents

- The **account key** is validated `/^\w{6,}$/` and is emitted publicly in the page as `data-secure-code` —
  it is etracker's client-side site identifier, **not** a stored secret; there is no API key, no Key entity,
  no `getenv`/dotenv path. All tracking is client-side; the module makes **no** server-side HTTP calls.
- Default `etracker_track_paths` excludes `/admin`, `/admin/*`, `/batch`, `/node/add*`, `/node/*/*`,
  `/user/*/*`.
