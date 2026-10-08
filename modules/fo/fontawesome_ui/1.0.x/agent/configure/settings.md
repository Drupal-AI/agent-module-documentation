<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Font Awesome UI — settings & icon manager

All routes require the **`administer fontawesome ui`** permission.

## Global settings — `/admin/config/user-interface/fontawesome` (`fontawesome.settings`)
Key options (`src/Form/FontAwesomeSettings.php`):
- **Method** — `cdn` or local library.
- **CDN** provider + **integrity** (SRI) value shown when method = cdn.
- **Version** of Font Awesome to target.
- **Load / hide** toggles and theme + page-path restrictions (states-driven visibility).
- Delivery: SVG+JS vs webfonts+CSS, minified vs source, RTL support.
- Icon form settings at `/admin/config/user-interface/fontawesome/form`.

## Icon manager — `/admin/structure/icon` (`fontawesome.admin`)
An icon list with actions:
- **Add** — `/admin/structure/icon/add` (`FontAwesomeForm`)
- **Edit** — `/admin/structure/icon/edit/{icon}`
- **Delete** — `/admin/structure/icon/delete/{icon}`
- **Duplicate** — `/admin/structure/icon/duplicate/{icon}`
- A filter form narrows the list.

Stored icon `options` are read with `unserialize(..., ['allowed_classes' => FALSE])` — no object injection.
