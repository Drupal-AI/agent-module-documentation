<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom breadcrumbs — agent index

Define breadcrumb trails as **`custom_breadcrumbs` config entities**, matched by content
entity type/bundle (`type: 1`) or URL path pattern (`type: 2`), with per-crumb path + title from
text or **Token** replacement. A high-priority `BreadcrumbBuilder` (priority 1003) applies them.
Requires `token`. One permission: `administer custom_breadcrumbs`.

- **Global settings object + configure route (Home crumb, current-page, admin/site-wide, trim)** →
  [configure/global-settings.md](configure/global-settings.md)
- **The breadcrumb config entity: every field, type 1 vs 2, tokens, `<nolink>`, `<term_hierarchy:>`, extra field** →
  [configure/breadcrumb-entity.md](configure/breadcrumb-entity.md)
- **Permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Global config object: `custom_breadcrumbs.settings` (route `custom_breadcrumbs.config`,
  `/admin/config/user-interface/custom-breadcrumbs`).
- Per-trail entities: `custom_breadcrumbs.custom_breadcrumbs.<id>`; managed at
  `/admin/structure/custom-breadcrumbs`.
- `breadcrumbPaths` / `breadcrumbTitles` are newline-separated, one crumb per line, paired by index.
- Builder service `custom_breadcrumbs.breadcrumb` (tag `breadcrumb_builder`, priority 1003).
