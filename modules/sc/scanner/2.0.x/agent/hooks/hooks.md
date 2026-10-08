# scanner — hooks

Declared in `scanner.api.php`. One hook:

## `hook_scanner_info_alter(array &$scanners)`

Alter the discovered Scanner plugin definitions (keyed by plugin id) before they are used —
e.g. swap the handler class for an entity type. Invoked via the plugin manager's
`alterInfo('scanner_info')`.

```php
/**
 * Implements hook_scanner_info_alter().
 */
function mymodule_scanner_info_alter(array &$scanners) {
  // Replace the default Node scanner with a custom class.
  $scanners['scanner_node']['class'] = 'Drupal\mymodule\Plugin\Scanner\CustomNodeScanner';
}
```

Each `$scanners[<id>]` definition carries at least `id`, `type`, `class`, and `provider`.
Use this to override behaviour for an existing entity type without redefining the plugin; to
support a **new** entity type, write a plugin instead — see
[plugins/scanner-plugin.md](../plugins/scanner-plugin.md).
