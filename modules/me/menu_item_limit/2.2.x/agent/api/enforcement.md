<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the limit is enforced

## The constraint

`menu_item_limit_entity_type_alter()` adds a `MenuItemOverLimit` validation constraint to
the **`menu_link_content`** entity type:

```php
$entity_types['menu_link_content']->addConstraint('MenuItemOverLimit');
```

- Constraint plugin: `Drupal\menu_item_limit\Plugin\Validation\Constraint\MenuItemOverLimit`
  (id `MenuItemOverLimit`), message
  *"New link cannot be added because the menu item limit has been reached."*
- Validator: `MenuItemOverLimitValidator`.

## When it fires

`MenuItemOverLimitValidator::validate()`:

1. **Skips items that are not new** — `if (!$entity->isNew()) return;`. Existing links can be
   re-saved and moved; the cap only blocks *creating* a new link. It also does **not**
   retroactively invalidate a menu that is already over the limit.
2. Only acts on `MenuLinkContent` entities.
3. Reads the limit from `menu_item_limit.settings` for the item's menu
   (`$entity->getMenuName()`). If the limit is `0`/empty → no restriction.
4. Otherwise loads the menu's link tree via `menu.link_tree`
   (`load($menu_name, getCurrentRouteMenuTreeParameters(...))`), counts the items, and if
   `count >= limit` adds the violation.

## Implications

- Because validation runs on entity save, the block applies through the menu-link add form,
  the content menu-settings widget, and programmatic `MenuLinkContent::create()->save()`
  (validation is triggered where the entity is validated).
- The count is based on the loaded menu tree; module-provided `*.links.menu` YAML items are
  part of the tree but are not `menu_link_content` entities, so you cannot add a new content
  link once the tree already meets the limit.
- To change behavior, implement your own validator or adjust the per-menu limit; there is no
  hook or plugin type to extend.
