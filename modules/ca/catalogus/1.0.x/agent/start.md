<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dominican Catalogus (catalogus) — agent index

**Community catalogue content solution with Entity Print PDF export.**

- **Version:** 1.0.x · **Core:** ^8.8 || ^9 || ^10 · **PHP:** 7.3
- **Config:** `catalogus.form` → `/admin/config/content/catalogus` (`administer site configuration`).
- **Routes:** `catalogus.back_on` `/community/{cid}/back-on/{date}` (`access content`, placeholder controller). Entity Print PDF at `catalogus/pdf`.
- **Depends:** address, node, taxonomy, entity_print_views, computed_field, field_group, auto_entitylabel, and more.

**Security:** settings route permission-gated; `back_on` route uses `access content` (effectively public) but only returns placeholder markup; no external calls or secrets.
