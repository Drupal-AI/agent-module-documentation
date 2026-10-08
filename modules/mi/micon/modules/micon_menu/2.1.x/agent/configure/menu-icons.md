<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring menu-link icons

## Permission
- **`use micon menu`** — controls whether the icon control appears on the node form's Menu
  settings and on the menu-link-edit form (`#access` check in `micon_menu.module`).
- The global settings form is gated by **`administer micon`** (the parent module's permission).

## Global config: `micon_menu.config`
| key | type | meaning |
|---|---|---|
| `packages` | list of micon ids | packages offered in the menu icon pickers (empty/`[]` = all) |

Edit at **`/admin/structure/micon/link`** (route `micon_menu.micon_menu_config_form`,
`MiconMenuConfigForm`). Read/set with drush:
```
drush config:get micon_menu.config packages
drush config:set micon_menu.config packages.0 fa -y   # restrict to the fa package
```

## Where the icon is stored
On the `menu_link_content` entity's `link` field value:
`link.options.attributes.data-icon` = the icon selector (e.g. `fa-home`), and
`link.options.attributes.data-icon-position` = `before` | `after` | `icon_only`.

Set programmatically:
```php
$mlc = \Drupal\menu_link_content\Entity\MenuLinkContent::create([
  'title' => 'Home',
  'menu_name' => 'main',
  'link' => [
    'uri' => 'internal:/',
    'options' => ['attributes' => ['data-icon' => 'fa-home', 'data-icon-position' => 'before']],
  ],
]);
$mlc->save();
```
For an existing item, read/modify `->get('link')->first()->get('options')->getValue()` and
re-save.

## Rendering
`hook_preprocess_menu()` runs on every themed menu: for each item whose Url has a `data-icon`
option it replaces the title with `MiconIconize::iconize($title)->setIcon($data_icon)` (and
`setIconAfter()` / `setIconOnly()` per `data-icon-position`), then removes the attribute so it
is not also emitted on the `<a>`. No template overrides are needed.

## The `micon_menu` widget
`hook_entity_base_field_info_alter()` forces the `menu_link_content` `link` field's **form**
widget to `micon_menu` (settings `target`/`position` on by default). It reuses
`micon_link`'s `MiconLinkWidgetTrait`, so behaviour matches the `micon_link` widget.
