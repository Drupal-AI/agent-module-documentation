<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# REST menu items — agent index

Exposes a Drupal menu tree over REST at **`/api/menu_items/{menu_name}`** (resource plugin id
`rest_menu_item`). Depends on core **rest**. Config UI:
`rest_menu_items.config_form` (`/admin/config/services/rest_menu_items`), permission
`administer rest menu items`.

- **The endpoint: path, `_format`, `max_depth`/`min_depth`, response shape, base_url, fragments** →
  [api/endpoint.md](api/endpoint.md)
- **Settings (`rest_menu_items.config`: output_values, allowed_menus, base_url, add_fragment) +
  enabling the REST resource and permission** → [configure/settings.md](configure/settings.md)
- **The two alter hooks for reshaping the tree / output** → [hooks/alter.md](hooks/alter.md)

Key facts:
- Resource `@RestResource(id = "rest_menu_item", uri_paths canonical = "/api/menu_items/{menu_name}")`.
  `_format` is **required** (`json` | `hal_json` | `xml`); missing it gives a 406.
- Config object: `rest_menu_items.config` (plain config via `configFactory`). Children nest under `below`.
- Must be enabled like any REST resource (REST UI or config) and granted
  `restful get rest_menu_item` before it responds; a menu absent from a non-empty
  `allowed_menus` returns 403.
