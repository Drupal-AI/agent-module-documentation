# Alter hooks (extlink.api.php)

The settings array built from `extlink.settings` is passed through `module_handler->alter()`
before being handed to JavaScript. Implement in `mymodule.module` or a `src/Hook/` class.

| Hook | Signature | Use |
|---|---|---|
| `hook_extlink_settings_alter` | `(array &$settings)` | Mutate the full ExtLink settings array (all `extlink_*` keys, e.g. `extlink_css_exclude`, `extlink_class`) before it reaches the page. |
| `hook_extlink_css_exclude_alter` | `(string &$cssExclude)` | Mutate only the comma-separated CSS-selector exclusion string. |

Example — never decorate links inside your module's buttons:
```php
function mymodule_extlink_css_exclude_alter(&$cssExclude) {
  $cssExclude .= ', .my-module a.button';
}
```
