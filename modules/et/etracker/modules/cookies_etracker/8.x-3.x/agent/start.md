<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# COOKiES eTracker Analytics (cookies_etracker) — agent index

Submodule of the **etracker** project that gates the etracker tracker on **COOKiES** cookie consent. Package
`COOKiES`; core `^9 || ^10 || ^11`; license GPL-2.0-or-later; version 8.x-3.x (installed release 8.x-3.2).
Depends on modules **`cookies`** and **`etracker`**. Procedural (`cookies_etracker.module`); no routes, no
permissions, no own settings form (it alters etracker's).

- **Knockout modes, hooks, JS behaviors, config & install** → [config/consent.md](config/consent.md)

## What it actually is

- Config object **`cookies_etracker.settings`** — single key `knockout_mode` (schema
  `config/schema/etracker_config.schema.yml`; default `block_cookies_true_without_consent` in
  `config/install/cookies_etracker.settings.yml`).
- COOKiES service config **`cookies.cookies_service.etracker`** (`config/install/`, id `etracker`, group
  `tracking`) describing etracker cookies + consent text; enforces `cookies_etracker` as a dependency.
- Two JS libraries (`cookies_etracker.libraries.yml`): `knockout_without_consent`
  (`js/cookies_etracker-knockout_without_consent.js`) and `block_cookies_true_without_consent`
  (`js/cookies_etracker-block_cookies_true_without_consent.js`).
- Hooks in `cookies_etracker.module`: `hook_help`, `hook_library_info_alter`, `hook_page_attachments`,
  `hook_form_etracker_admin_settings_alter` (adds the "Blocking mode" radios), plus a save helper.
- `hook_install` enables etracker's `data_block_cookies`; update hooks `cookies_etracker_update_8001` (enforce
  dependency on the COOKiES analytics service) and `_8002` (seed `knockout_mode`).

## Four knockout modes (config `knockout_mode`)

- `block_cookies_true_without_consent` — *Most accuracy*: cookie-less before consent, cookies after.
- `knockout_without_consent_block_cookies_true` — *Most privacy*: no tracking until consent, then cookie-less.
- `knockout_without_consent_block_cookies_false` — *Mixed*: no tracking until consent, then with cookies.
- `block_cookies_true` — *Ignore consent*: unchanged etracker behaviour.

## Notes for agents

- Purely a consent-gating layer over etracker; no server-side HTTP, no secrets, no credentials. All consent
  reaction happens in the browser on the `cookiesjsrUserConsent` event.
- Only acts when etracker's `data_block_cookies` is enabled; otherwise it no-ops (and the form warns the admin).
