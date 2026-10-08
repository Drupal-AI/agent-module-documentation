<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# REST Menu Tree — enabling & using the endpoint

The module ships **no config UI**; it plugs into core REST.

## Enable the resource
After `drush en rest_menu_tree`, the `menu_tree` REST resource is registered but **disabled**. Enable
it one of two ways:
- **REST UI** (`drupal/restui`, suggested): *Configuration → Web services → REST* → enable
  **Menu Tree**, choose methods (`GET`), formats (`json`, `hal_json`, …), and authentication
  (`cookie`, `basic_auth`, OAuth, …).
- **Config**: add a `menu_tree` entry under `rest.settings` `resources:` with the same
  method/format/auth structure core REST expects.

## Grant access
Reading the endpoint requires the core-generated permission **`restful get menu_tree`**. Grant it to
the roles (often `anonymous`/`authenticated`, or an API role) that may read menus. Access is entirely
core REST + this permission — the module adds no permission of its own.

## Call it
```
GET /entity/menu/{menu}/tree?_format=json
```
`{menu}` = a menu config entity id (`main`, `footer`, `admin`, or a custom menu). Send the
`Authorization`/cookie your chosen auth requires and an `Accept`/`_format` matching an enabled format.

## Response
Nested array of menu link items (each with its link + `subtree`), serialized by **Menu Normalizer**.
Notable processing in `MenuTreeResource::get()`:
- Loads the tree with `menu.link_tree->load()` + `MenuTreeParameters` (full tree, no depth limit).
- Sorts via the `generateIndexAndSort` manipulator.
- `checkAccess()` drops any link whose `view` access (per current user) is not allowed; links with no
  access result but `isEnabled() === false` are also dropped.
- `removeKeys()` reindexes arrays so JS clients don't reorder by key.

## Caching
The response is fully cacheable and varies correctly: it adds the menu entity, **every** link's access
result (including inaccessible ones, so the cache varies by the same contexts), each link's own cache
metadata, and list cache tags / referenced-entity cache tags for dynamic (entity-derived) links
(`addLinkCacheDependencies()`).

## Access notes
- The endpoint only exposes menu **link** data, and each link is filtered by the requesting user's
  core `view` access — it does not bypass access control. Treat granting `restful get menu_tree` to
  anonymous as publishing your menu structure (normal for decoupled sites).
