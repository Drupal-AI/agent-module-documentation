<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov KeyNav (localgov_keynav) — agent index

**Keyboard-shortcut navigation: type key sequences to jump around the site; permission-gated with a per-user opt-out.**

- **Version:** 1.1.x (1.1.0) · **Core:** ^10 || ^11 · **Package:** LocalGov Drupal
- **Configure:** route `localgov_keynav.settings` → `admin/config/user-interface/localgov-keynav` (perm `Add LocalGov Keynav shortcuts`).
- **Permissions:** `Use LocalGov keynav` (receive shortcuts), `Add LocalGov Keynav shortcuts` (configure).
- **Library/JS:** `localgov_keynav/keynav` (`keynav.js`, `keynav-sequences.json`); settings via `drupalSettings.localgovKeyNav`.
- **Per-user opt-out:** boolean user field `localgov_keynav` (install config); `hook_preprocess_page` attaches only if permitted and not disabled; `hook_entity_field_access` guards the field.
- **Security:** settings route permission-gated; no external calls; navigation is client-side; no mutating public endpoints. No security findings.

See [configure/settings.md](configure/settings.md)
