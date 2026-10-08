<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Association Menu (association_menu) — agent index

Submodule of **[Entity Association](../../../../2.0.x/agent/start.md)** (depends on `association`,
`toolshed`). Per-association navigation menus + breadcrumbs, stored in a dedicated table. Version
2.0.0-alpha9, core `^10.2 || ^11`.

## What it provides (from source)

- **Storage** `association_menu.storage` (`AssociationMenuStorage`) — CRUD over the `association_menu`
  DB table using the DB API query builder (parameterized `->condition()`; no raw SQL). Items are
  loaded into `MenuItemInterface` objects: `AssociatedEntityMenuItem` (entity ref), `RoutedMenuItem`
  (route+params), or `UriMenuItem` (`Url::fromUri`). Titles are stored serialized with
  `allowed_classes` limited to `FormattableMarkup`/`TranslatableMarkup`; options/route as JSON.
  Caches per association via `cache.association_menu` bin and tag `association:menu:{id}`.
- **Builder** `association_menu.builder` (`AssociationMenuBuilder`) — builds `#theme => 'menu'` trees;
  `getMenu()` runs `access_manager->checkNamedRoute()` per routed item and drops inaccessible items.
- **Routes** (`association_menu.routing.yml`), all `_entity_access: association.manage` **and**
  `_permission: 'access association menu management'`:
  `/association/{association}/menu` (`AssociationMenuForm` tree overview),
  `…/menu/add` & `…/menu/{menu_item_id}` (`MenuItemEditForm`),
  `…/menu/{menu_item_id}/delete` (`MenuItemDeleteConfirm`).
  Plus `/admin/structure/association/menu-overview` (`RefreshMenuLinksForm`,
  `_permission: 'administer entity association configurations'`).
- **Permission**: `access association menu management` (restricted).
- **Hooks** (`association_menu.module`): `hook_entity_operation` adds a "Manage menu" op; auto-add on
  `hook_entity_insert` for associated entities; auto-remove on `association_link`/`association` delete.
- **Events** (`Event/`): `MENU_LINK_PRECREATE`, `MENU_LINK_CREATE`, `MENU_LINKS_LOAD`,
  `MENU_LINKS_ALTER` (`AssociationMenuEvents`).
- **Block**: `association_menu` block (`Plugin/Block/AssociationMenuBlock`).
- **Toolshed integration**: `Plugin/Toolshed/ThirdPartyConfig/AssociationMenuThirdPartyConfig` — adds
  `association.type.*.third_party.association_menu` (`menu_nesting`, `enabled_tags`).

## Solution docs

- Menu storage, item types, URL validation, rendering & access → [navigation/menus.md](navigation/menus.md)
