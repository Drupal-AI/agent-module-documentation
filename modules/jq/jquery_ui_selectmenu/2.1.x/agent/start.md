# jquery_ui_selectmenu — agent start

Re-provides the deprecated jQuery UI **Selectmenu** widget (removed from Drupal core) as an
asset library so themes/modules can keep rendering styled, themeable `<select>` dropdowns. No
config UI, no permissions, no services, no PHP of its own — it just carries the assets and
depends on the base `jquery_ui` and `jquery_ui_menu` modules. jQuery UI is End-of-Life
upstream — prefer migrating off it for new code.

## Attach the library

- [Attach `jquery_ui_selectmenu/selectmenu` and why this module exists](theming/jquery_ui_selectmenu.md) —
  the one library id, attaching it via `#attached`, its `jquery_ui` / `jquery_ui_menu`
  dependencies, and the post-core-removal rationale.

```php
$build['#attached']['library'][] = 'jquery_ui_selectmenu/selectmenu';
```
