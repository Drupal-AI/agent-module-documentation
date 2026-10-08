<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Static Content Iframe (sci) — agent index

**Stores uploaded static-site zip archives as entities and serves index.html in an iframe.**

- **Version:** 2.0.x
- **Core:** ^9.3 || ^10
- **Package:** Custom
- **Permissions:** add/edit/delete/view static content entities; `administer static content entities` (restrict access)

**Surface:** `static_content` content entity (`src/Entity/StaticContent.php`), `StaticContentAccessControlHandler` (per-op permission checks), `StaticContentForm` extracts uploaded `.zip` into `public://static/<md5>/` via batch and serves discovered `index.html` in an iframe.

**Trust:** uploaded archives are extracted to the public files dir and their HTML/JS is served from the site in the iframe. Grant 'add/edit/view static content entities' only to fully trusted roles (custom perms, not granted to anonymous by default).
