<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON:API Menu items Hypermedia — agent index

Glue submodule of `jsonapi_menu_items`. Adds a `menu_items` link (one per menu) to the `/jsonapi`
**root document** so the parent module's `/%jsonapi%/menu_items/{menu}` endpoints are discoverable.
Requires `jsonapi_menu_items` **and** `jsonapi_hypermedia`. No config, permissions, schema, or Drush.

- **The JSON:API Hypermedia LinkProvider plugin + its per-menu deriver** →
  [plugins/link-provider.md](plugins/link-provider.md)

Key facts:
- Provides one plugin: `MenuItemsLinkProvider` (id `jsonapi_menu_items.top_level.menu_items`,
  `link_relation_type = "menu_items"`), derived per `menu` entity by `MenuItemsLinkProviderDeriver`.
- Each derivative adds a root-document link `menu_items--<menu>` → `Url('jsonapi_menu_items.menu', ['menu' => <menu>])`,
  access `AccessResult::allowed()`.
- Parent resource this points at: `/%jsonapi%/menu_items/{menu}` (see
  [../../../../1.2.x/agent/api/resource.md](../../../../1.2.x/agent/api/resource.md)).
- Auto-installed by the parent's `hook_update_8001` when `jsonapi_hypermedia` is enabled.
