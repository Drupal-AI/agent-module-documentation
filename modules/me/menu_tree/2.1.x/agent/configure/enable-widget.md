# Enabling the tree widget

There is **no module settings page** and no config object of the module's own. The widget is
turned on **per content type** through a single boolean stored as a node-type third-party setting.

| What | Value |
| --- | --- |
| Entity | `node_type` (a content type) |
| Third-party provider | `menu_tree` |
| Setting key | `use_tree_widget` (boolean, default `FALSE`) |
| Config schema | `node.type.*.third_party.menu_tree` → `use_tree_widget` (`config/schema/menu_tree.schema.yml`) |

## UI

Edit the content type (e.g. `/admin/structure/types/manage/page`), open the **Menu settings**
vertical tab, check **Use tree widget for parent link**, save. The checkbox is injected by
`Hooks::nodeTypeFormAlter()` and persisted by its `nodeTypeFormBuilder` entity builder.

Prerequisite for the widget to actually appear on node forms: the content type must have at least
one menu enabled under menu_ui's **Available menus** (`menu_ui`/`available_menus`). With no available
menus, `Hooks::nodeFormAlter()` returns early and core's normal parent selector is shown.

## Drush

```bash
# Turn it on for the "page" content type.
drush php:eval "\Drupal::entityTypeManager()->getStorage('node_type')->load('page')->setThirdPartySetting('menu_tree','use_tree_widget',TRUE)->save();"

# Read the current value.
drush php:eval "var_dump(\Drupal::entityTypeManager()->getStorage('node_type')->load('page')->getThirdPartySetting('menu_tree','use_tree_widget',FALSE));"
```

## PHP

```php
$type = \Drupal::entityTypeManager()->getStorage('node_type')->load('page');
$type->setThirdPartySetting('menu_tree', 'use_tree_widget', TRUE);
$type->save();
```

## Config export

The flag lives inside the content type's own config entity, e.g. `node.type.page.yml`:

```yaml
third_party_settings:
  menu_tree:
    use_tree_widget: true
```

## Lifecycle notes

- `hook_install` calls `module_set_weight('menu_tree', 1)` so this module's form alters run after
  `menu_ui`.
- `hook_uninstall` walks every node type and calls `unsetThirdPartySetting('menu_tree', 'use_tree_widget')`,
  so removing the module cleans up the flag. Menu link data itself is untouched.
- Update hooks `menu_tree_update_103201/103202/103203` migrated a legacy `menu_tree.settings`
  config object (and an old `administer menu_tree settings` permission) into these per-node-type
  third-party settings; there is nothing left to configure globally.
