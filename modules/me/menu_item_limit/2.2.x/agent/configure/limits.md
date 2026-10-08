<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting a menu's item limit

There is **no dedicated settings page**. The limit is a field on each menu's own edit form.

## Via the UI

1. Go to *Structure → Menus* (`/admin/structure/menu`) and click **Edit menu** on the menu
   you want to cap (path `/admin/structure/menu/manage/<menu>`).
2. In the **Item Limitation** text field, enter the maximum number of items.
   - `0` (the default / empty) means **unlimited**.
   - Any positive integer caps the menu at that many links.
3. **Save**. The submit handler writes the value to config.

The field, validation ("must be 0 or higher"), and save are provided by
`menu_item_limit_form_alter()` on the `menu_edit_form`.

## Where it is stored

The value is saved into the `menu_item_limit.settings` config object, keyed by the menu's
**machine name**:

```yaml
# config: menu_item_limit.settings
main: 8       # "main" menu capped at 8 items
footer: 4
# a menu with no key (or value 0) is unlimited
```

Read/write it directly:

```bash
drush config:get menu_item_limit.settings main
```
```php
// set a cap of 5 on the "main" menu
\Drupal::configFactory()->getEditable('menu_item_limit.settings')
  ->set('main', 5)->save();
// make it unlimited again
\Drupal::configFactory()->getEditable('menu_item_limit.settings')
  ->set('main', 0)->save();   // or ->clear('main')->save();
```

Note: the module ships **no config schema** for this object, so the value is a plain scalar
(the UI stores the raw textfield value). `0`, empty, or a missing key all mean unlimited.
The config exports/deploys with your other configuration.
