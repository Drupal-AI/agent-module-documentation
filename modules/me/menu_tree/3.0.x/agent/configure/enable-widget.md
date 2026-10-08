<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enabling the tree widget & ordering menus

There is **no module settings page** and no config object of the module's own. All
configuration lives in two third-party settings on existing config entities.

## 1. Enable the tree widget on a node type

On node forms the tree is **opt-in per content type** through a single boolean.

| What | Value |
| --- | --- |
| Entity | `node_type` (a content type) |
| Third-party provider | `menu_tree` |
| Setting key | `use_tree_widget` (boolean, default `FALSE`) |
| Config schema | `node.type.*.third_party.menu_tree` → `use_tree_widget` (`config/schema/menu_tree.schema.yml`) |

### UI

Edit the content type (e.g. `/admin/structure/types/manage/page`), open the **Menu settings**
vertical tab, check **Use tree widget for parent link**, save. The checkbox is injected by
`MenuTreeHooks::nodeTypeFormAlter()` and persisted by its `nodeTypeFormBuilder` entity builder.

Prerequisite for the widget to actually appear on node forms: the content type must have at
least one menu enabled under menu_ui's **Available menus** (`menu_ui`/`available_menus`). With
no available menus the `menu_tree` element's process callback returns early and core's normal
parent selector is shown.

### Drush

```bash
# Turn it on for the "page" content type.
drush php:eval "\Drupal::entityTypeManager()->getStorage('node_type')->load('page')->setThirdPartySetting('menu_tree','use_tree_widget',TRUE)->save();"

# Read the current value.
drush php:eval "var_dump(\Drupal::entityTypeManager()->getStorage('node_type')->load('page')->getThirdPartySetting('menu_tree','use_tree_widget',FALSE));"
```

### PHP

```php
$type = \Drupal::entityTypeManager()->getStorage('node_type')->load('page');
$type->setThirdPartySetting('menu_tree', 'use_tree_widget', TRUE);
$type->save();
```

### Config export

The flag lives inside the content type's own config entity, e.g. `node.type.page.yml`:

```yaml
third_party_settings:
  menu_tree:
    use_tree_widget: true
```

**Views UI and menu-link content forms do not use this flag** — on those forms the tree widget
is always shown when the module is installed.

## 2. Order the menus in the widget (per-menu weight)

New in 3.x. The widget can show several menus (all of a node type's available menus, or every
menu on Views/menu-link forms). Their display order is controlled by a per-menu weight.

| What | Value |
| --- | --- |
| Entity | `menu` (`system.menu.*`) |
| Third-party provider | `menu_tree` |
| Setting key | `weight` (integer, default `0`) |
| Config schema | `system.menu.*.third_party.menu_tree` → `weight` |

Set it from the menu edit form (e.g. `/admin/structure/menu/manage/main`), which now carries a
**Weight** field added by `MenuTreeHooks::menuFormAlter()` and saved by its `menuFormBuilder`
entity builder. Menus are sorted ascending by this weight before being rendered
(`MenuTree::processElement()` `uasort`). Drush:

```bash
drush php:eval "\Drupal::entityTypeManager()->getStorage('menu')->load('main')->setThirdPartySetting('menu_tree','weight',-5)->save();"
```

## Lifecycle notes

- There is **no** `hook_install`; load order after `menu_ui` is handled purely by the hooks'
  `#[Hook(..., order: new OrderAfter(['menu_ui']))]` attributes.
- `menu_tree_uninstall()` walks every `node_type` **and** every `menu`, removing any
  `menu_tree` third-party settings it finds (only re-saving entities that actually carry them).
  Menu link data itself is untouched.
- Before upgrading to 3.x, the project's README advises being on the latest 2.x release first.
