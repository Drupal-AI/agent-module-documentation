<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Styled Google Map Demo — agent index

Hidden example submodule of `styled_google_map`. Defines a **`real_estate` content entity
type** (with a `geofield` location) and a **`real_estate` taxonomy vocabulary**, purely to
demo the parent module's maps. No configuration of its own (`configure: null`). Depends on
`styled_google_map`, `taxonomy`, `image`, `text`.

- **The `real_estate` entity type — fields, routes, permissions, how to create one** →
  [api/entity.md](api/entity.md)

Key facts:
- Entity type id `real_estate`, base table `real_estate`, label key `name`.
- Fields: `name` (string), `price` (int), `location` (**geofield**), `category` (entity
  reference → `real_estate` vocabulary), plus `user_id`, `status`, `created`, `changed`.
- Taxonomy vocabulary `real_estate` with image field `field_icon` (used as per-type map pin).
- Routes: `/real_estate/add`, `/real_estate/{real_estate}`, `/admin/content/real_estate`,
  settings `/admin/structure/real_estate/settings` (route `real_estate.settings`).
- Permissions: `administer real estate entities`, `add`/`edit`/`delete real estate entities`,
  `view published`/`view unpublished real estate entities`.
- `hidden: true` — not shown on the normal Extend list.
