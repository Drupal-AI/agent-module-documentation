<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Noscript Tag (noscript_tag) — agent index

**Injects a configurable `<noscript>` message so JavaScript-disabled visitors see a notice.**

- **Version:** 3.0.x
- **Core:** ^9.3 || ^10
- **Depends:** none
- **Configure:** `/admin/config/development/noscript-tag-setting` (route `noscript_tag.settings`, `administer noscript tag`).
- **Permissions:** `administer noscript tag`, `view noscript tag`.

**Surface:** one settings form (`NoscriptTagSettingsForm`); config `noscript_tag.settings`; message rendered inside a `<noscript>` element.

**Security:** message is admin-entered config; administration gated by `administer noscript tag`. No dynamic/user input handling. Presentational only.
