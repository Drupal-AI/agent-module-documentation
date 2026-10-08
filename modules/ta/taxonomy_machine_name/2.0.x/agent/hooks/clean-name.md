# hook_taxonomy_machine_name_clean_name_alter()

The only hook the module invites (`taxonomy_machine_name.api.php`). It lets you replace the
default slug algorithm. It is invoked at the end of `taxonomy_machine_name_clean_name()`, so
`$machine_name` already holds the module's default result when your hook runs.

```php
/**
 * Implements hook_taxonomy_machine_name_clean_name_alter().
 *
 * @param string $machine_name  (by ref) the slug to override.
 * @param string $name          the original term name.
 * @param bool   $force         whether regeneration was forced.
 */
function mymodule_taxonomy_machine_name_clean_name_alter(&$machine_name, $name, $force) {
  // Example: use dashes instead of underscores.
  $machine_name = strtolower(str_replace(' ', '-', $name));
  $machine_name = preg_replace('/[^a-z0-9\-]/', '-', $machine_name);
  $machine_name = trim($machine_name, '-');
}
```

Notes:
- Runs on every term save (via `taxonomy_machine_name_taxonomy_term_presave`), before
  uniqueness suffixing — so your value may still gain a `_0`/`_1` suffix to stay unique.
- Keep the result to `[a-z0-9_...]`-style characters; downstream uses it as a queryable key,
  a token, and a CSS class. Note the reserved words `add`/`list`/`delete`/`update` are only
  blocked in the *form* validator, not here — avoid emitting them.
- `$force` is TRUE when a caller explicitly requested regeneration; branch on it if you only
  want to intervene on forced rebuilds.
