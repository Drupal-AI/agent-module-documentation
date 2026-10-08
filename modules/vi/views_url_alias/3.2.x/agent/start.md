<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views URL alias — agent index

Lets Views filter/sort content by URL (path) alias. Maintains a `views_url_alias` mapping
table kept in sync by `path_alias` entity hooks, and exposes it to Views as a relationship +
`alias` field/filter/sort. No config entity, no plugins, no Drush, no own permissions.

- **Use it in a View (relationship + URL Alias filter/sort) and rebuild the index table** →
  [configure/views-and-rebuild.md](configure/views-and-rebuild.md)
- **How it works (the table schema, sync hooks, `views_data`, rebuild batch, state flag)** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- DB table `views_url_alias`: columns `rid`, `entity_type` (default `node`), `entity_id`,
  `langcode`, `alias`. One row per (entity_type, entity_id, langcode).
- Rebuild confirm form: route `views_url_alias.views_url_alias_admin_form` →
  `/admin/config/search/views-url-alias` (permission: core `administer views`).
- Drift is tracked by state key `views_url_alias.needs_rebuild` (drives an admin warning).
- Only entities with **numeric** IDs are indexed. `configure` in info.yml is unset (null).
