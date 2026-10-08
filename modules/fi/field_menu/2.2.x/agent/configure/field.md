<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add and configure a Field Menu field

There is **no admin settings page** (`configure: null`). You configure it entirely through
the normal Field UI / field config of the entity you attach it to.

## Field type

- **Type id:** `field_menu` (label "Menu item"), class
  `Drupal\field_menu\Plugin\Field\FieldType\MenuItemId`.
- **Default widget:** `field_menu_tree_widget`. **Default formatter:** `field_menu_tree_formatter`.
- **Stored columns** (per field value): `menu_title` (string, optional heading),
  `menu_item_key` (string, format `menu_name:parent:link`), `max_depth` (int, `0` = unlimited),
  `include_root` (int/bool).
- `isEmpty()` is true when `menu_item_key` is empty, so a value with only a title is discarded.

## Field-level settings (the field's `settings`)

Set on the field instance (`field.field.<entity_type>.<bundle>.<field_name>` → `settings`):

- `menu_type_checkbox` — array of menu machine names offered in the widget's **Root** selector.
  Empty = offer all menus.
- `menu_type_checkbox_negate` — when true, treat `menu_type_checkbox` as a **hide** list
  (offer every menu *except* those) instead of an allow list.

Defaults (`MenuItemId::defaultFieldSettings()`): `menu_type_checkbox: []`,
`menu_type_checkbox_negate: FALSE`. Schema key: `field_menu.settings`.

## Widget form (per entity edit form)

`field_menu_tree_widget` (`TreeWidget`) renders:
- **Title** (`menu_title`) — optional; if you set a Title you must also select a Root (validated).
- **Root** (`menu_item_key`) — a core "parent" select built by the `menu.parent_form_selector`
  service, filtered by the field settings above.
- **Max depth** (`max_depth`) — number, min 0, 0 means no limit.
- **Include root?** (`include_root`) — checkbox; off = render only the children of the root.

## Create a field programmatically

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_sitemap',
  'entity_type' => 'node',
  'type' => 'field_menu',
])->save();

FieldConfig::create([
  'field_name' => 'field_sitemap',
  'entity_type' => 'node',
  'bundle' => 'page',
  'label' => 'Sitemap',
  // Optional: restrict the Root selector to the main menu only.
  'settings' => ['menu_type_checkbox' => ['main' => 'main'], 'menu_type_checkbox_negate' => FALSE],
])->save();
```

Then add the widget/formatter to the form/view displays (`field_menu_tree_widget` /
`field_menu_tree_formatter`) or accept the field type's defaults.
