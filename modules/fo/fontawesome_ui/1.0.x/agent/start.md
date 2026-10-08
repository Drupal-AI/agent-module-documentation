<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Font Awesome UI (fontawesome_ui) — agent index

**Integrates the Font Awesome icon library (CDN or local) with an admin settings form, an icon manager, and a Drush downloader.**

- **Version:** 1.0.x (1.0.0-rc5)
- **Core:** ^9.5 || ^10 || ^11
- **Configure:** `fontawesome.settings` → `/admin/config/user-interface/fontawesome`
- **Permission:** `administer fontawesome ui` (gates all routes).
- **Routes:** `/admin/structure/icon` (list) + add/edit/delete/duplicate; `/admin/config/user-interface/fontawesome` (+ `/form`).
- **Drush:** `fa:download` (aliases `fadl`, `fa-download`) — fetches the library (source = fixed module library `remote`) into `libraries/fontawesome` and `extract()`s it.

**Security:** all routes require `administer fontawesome ui`; no anonymous/mutating web endpoints. Drush `fa:download` extracts a zip from a **fixed, code-defined** URL into a **fixed** path (`substr==='fontawesome'` guard), CLI-only — no web-exploitable zip-slip/traversal. `unserialize()` uses `allowed_classes => FALSE` (no object injection).

See [configure/settings.md](configure/settings.md) and [drush/download.md](drush/download.md).
