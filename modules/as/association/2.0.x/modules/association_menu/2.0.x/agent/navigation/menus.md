<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Association menus: storage, items, rendering

## Data model

Menu items live in the module's own `association_menu` table (see `association_menu.install`), not in
core menu links. `AssociationMenuStorage` (service `association_menu.storage`) reads/writes it with the
DB API query builder. Each row belongs to one `association` and stores: serialized `title`, JSON
`options`, JSON `route` or plain `uri` or `entity` (`type:id`), plus `parent`, `weight`, `depth`,
`enabled`, `expanded`.

`createItem()` reconstructs one of three `MenuItemInterface` classes:
- `AssociatedEntityMenuItem` — when `entity` is set and loads to an `AssociatedEntityInterface`; URL is
  the entity's canonical URL.
- `RoutedMenuItem` — when `route.route_name` is set; URL from route name + params.
- `UriMenuItem` — when `uri` is set; `Url::fromUri($uri, $options)`.

Titles are `unserialize()`d with `allowed_classes` restricted to `FormattableMarkup` /
`TranslatableMarkup`; options and route are JSON-decoded. All lookups/writes use parameterized
`->condition()` / `->fields()` — no string-built SQL.

## Managing items

- **Tree overview**: `AssociationMenuForm` at `/association/{association}/menu`. Saves structural
  changes via `updateMenuStore`/`updateMenuTree()`, which whitelists only `parent/enabled/expanded/
  depth/weight` so a drag-and-drop reorder can't rewrite a link's URL.
- **Add/edit**: `MenuItemEditForm` (`…/menu/add`, `…/menu/{id}`). For entity-backed items the URL is
  fixed and only the title/attributes are editable. For custom items, `validateForm()` accepts a
  special route name (`<front|nolink|none|button>`), an external URL (`UrlHelper::isValid($s, TRUE)`),
  or an internal path starting `/` (`UrlHelper::isValid`). `submitForm()` splits query/fragment,
  routes internal paths through `path.validator` (`getUrlIfValid`), and only stores an external `uri`
  when `UrlHelper::isExternal()` is true. Link attributes: target (select), rel (pattern-restricted),
  class (`css_class`).
- **Delete**: `MenuItemDeleteConfirm` (`…/menu/{id}/delete`). `deleteMenuItem()` only removes rows that
  are `isNull('entity')` — entity-backed items are managed automatically, not hand-deleted.

All four routes require `_entity_access: association.manage` **and** the restricted permission
`access association menu management` (defense in depth). Forms are standard `FormBase` (CSRF-protected).

## Auto-tracking (hooks)

`association_menu_entity_insert` calls `addAssociated()` for any new `AssociatedEntityInterface`
(dedup-guarded), defaulting the item's enabled state from the type's `enabled_tags` Toolshed config.
`association_menu_association_link_delete` removes the item (unless the association is purging), and
`association_menu_association_delete` deletes the whole menu.

## Rendering & access

`AssociationMenuBuilder::getMenu()` builds the tree, then for each **routed** item runs
`access_manager->checkNamedRoute($name,$params,$account, TRUE)` and stores the result; `buildItem()`
drops items where `hasAccess()` is false, so a viewer only sees links they can reach. Output is a
`#theme => 'menu'` array (`menu.html.twig`), and titles are `TranslatableMarkup`/`FormattableMarkup` —
rendered through the theme layer's autoescaping, not raw. Cache: `cache.association_menu` bin +
`association:menu:{id}` tag; entity-backed items add their entity's cache metadata.

## Rebuild

`RefreshMenuLinksForm` at `/admin/structure/association/menu-overview`
(`_permission: 'administer entity association configurations'`) rebuilds association content menus in
bulk.
