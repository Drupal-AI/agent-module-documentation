<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Warning — configure (config_warning)

**Settings route:** `/admin/config/development/config-warning`
(`config_warning.settings`, permission `administer site configuration`).

## Fields
- **Enable warning message** (`enabled`) — master on/off. Handy to leave off in dev and
  enable on production.
- **Warning message** (`warning_message`, translatable) — the text shown as a Drupal
  warning message on config-altering admin forms.
- **Page path conditions** — a wrapped core `request_path` condition plugin:
  - **Paths** — one path per line, wildcards allowed (`/admin/structure/block/*`).
  - **Exclude matching paths** (`negate`, default TRUE) — when checked, the warning is
    *hidden* on matching paths; when unchecked, the warning shows *only* on matching paths.

## How the warning is decided
`FormHooks::formAlter()` (a `#[Hook('form_alter')]` service) fires on every form but:
1. returns immediately unless the current route is an admin route;
2. evaluates each configured condition plugin — if any `execute()` returns FALSE the
   warning is skipped;
3. returns if `enabled` is FALSE;
4. otherwise flags the form as config-altering when the form object either implements
   `getEditableConfigNames()`, is an `EntityForm` editing an existing `ConfigEntity`, is
   the `UserPermissionsForm`, or is the `BlockListBuilder`.

When flagged, the configured message is added via the messenger.

## Config export shape
```yaml
enabled: true
warning_message: 'Alterations to this form may alter the running configuration...'
conditions:
  request_path:
    id: request_path
    negate: true
    pages: ''
```
