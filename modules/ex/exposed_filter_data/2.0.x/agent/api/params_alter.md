<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alter hook: hook_exposed_filter_data_params_alter()

Documented in `exposed_filter_data.api.php`. Invoked by the block's `build()` via
`ModuleHandlerInterface::alter('exposed_filter_data_params', $params)` before the parameters are handed
to the template. This is the only extension point of the module.

## Signature
```php
function hook_exposed_filter_data_params_alter(array &$params): void
```
- `$params` — passed by reference; the current request's query-string parameters
  (`$request->query->all()`), i.e. keys = query keys, values = query values (strings or arrays).

## Purpose
The block otherwise prints the raw query string — machine keys and coded values. Implement this hook to:
- **Relabel keys** — replace a machine name key with a friendly label.
- **Map values** — turn coded values into words (the api.php example maps `status=1` → `Status:
  Published`, `status=2` → `Status: Not Published`, then `unset($params['status'])`).
- **Remove noise** — `unset()` pager (`page`), sort (`sort_by`, `sort_order`), or unrelated params so
  they don't show in the "Filtered by:" summary.
- **Reformat** — combine or rewrite values before display.

## Example (from `exposed_filter_data.api.php`)
```php
function hook_exposed_filter_data_params_alter(&$params) {
  foreach ($params as $filter => $value) {
    if ($filter == 'status') {
      if ($value == 1) {
        $params['Status'] = 'Published';
      }
      elseif ($value == 2) {
        $params['Status'] = 'Not Published';
      }
      unset($params[$filter]);
    }
  }
}
```

## Notes
- Whatever remains in `$params` after the hook is what the template renders (any key whose value is
  truthy). Both keys and values are auto-escaped by Twig.
- Place the implementation in a custom module's `.module` file; no service or config is required.
