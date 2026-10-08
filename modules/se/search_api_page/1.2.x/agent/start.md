<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# search_api_page (1.2.x) — agent index

Creates standalone search pages backed by Search API indexes. Each page is a
`search_api_page` **config entity** that binds one index to a URL path; the module
also ships a search-form block. Hard dependency: `search_api` (an index must exist).

- **Configure a search page** (the config entity: fields, admin UI, drush/PHP creation,
  the block) → [configure/search_api_page.md](configure/search_api_page.md)
- **Programmatic access** (entity API, the SearchApiPage display plugin, the alter hook,
  templates) → [api/entity-and-hooks.md](api/entity-and-hooks.md)
- **Permissions** (who can administer pages vs. use search) → [permissions/permissions.md](permissions/permissions.md)
