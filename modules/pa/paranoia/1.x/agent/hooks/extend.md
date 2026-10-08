<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extending Paranoia — hooks

Paranoia has no `.api.php`; the hooks are invoked with `moduleHandler()->invokeAll()` and merged. Implement any of these in your own module (function name `MYMODULE_<hook>`) to register more risky items. Each returns a flat array; Paranoia collects them from all modules.

| Hook | Return | Effect |
|---|---|---|
| `hook_paranoia_disable_modules()` | module machine names | Uninstalled on install and re-uninstalled if enabled via the modules form. |
| `hook_paranoia_hide_modules()` | module machine names | Hidden from the modules and uninstall admin pages. |
| `hook_paranoia_hide_permissions()` | permission strings | Removed from the permissions form entirely and revoked from every role on submit/install. |
| `hook_paranoia_hide_routes()` | route names | Route `_access` requirement set to `FALSE` (route becomes inaccessible). |
| `hook_paranoia_risky_forms()` | form IDs | Form gets `#access` FALSE + an always-fail validator (blocks submit; mitigates serialized-array RCE). |

Paranoia can implement a hook "on behalf of" a module by prefixing with that module's name (e.g. `devel_paranoia_hide_permissions`, `googleanalytics_paranoia_hide_permissions`) — the same convention works in your own module.

## Example
```php
// Hide a contrib eval permission and lock down an import form + route.
function mymodule_paranoia_hide_permissions() {
  return ['administer some_risky_thing'];
}
function mymodule_paranoia_risky_forms() {
  return ['some_module_php_import_form'];
}
function mymodule_paranoia_hide_routes() {
  return ['some_module.dangerous_route'];
}
```
Clear caches (`drush cr`) after adding a hook that affects routes.
