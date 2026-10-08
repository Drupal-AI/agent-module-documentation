# Service: `node_keep_token.helper` (NodeKeepTokenService)

`\Drupal::service('node_keep_token.helper')` — constructed with `entity_type.manager` and
`language_manager`. All lookups consider only **protected** nodes (`node_keeper = 1`) that have a
`keeper_machine_name`.

| Method | Returns |
|---|---|
| `getProtectedNodes()` | Array keyed by nid: `['label', 'machine_name', 'id']` for each protected, named node. |
| `getProtectedMachineNames()` | Same data but keyed by machine name. |
| `getProtectedNodesAsOptions($key = 'machine_name', $value = 'machine_name')` | Flat map for select `#options`; key/value each one of `machine_name`, `id`, `label`. |
| `isMachineNameUsed($machine_name, $exception_nid)` | Count of other protected nodes using that name (0 = free). Used for uniqueness validation. |
| `getProtectedNodeByMachineName($machine_name, $language_fallback = TRUE)` | The node entity for a machine name, returning the current-language translation when available; `NULL` if none (and `$language_fallback` is FALSE for a missing translation). |

Example:

```php
$helper = \Drupal::service('node_keep_token.helper');
$home = $helper->getProtectedNodeByMachineName('home');   // Node entity or NULL
$options = $helper->getProtectedNodesAsOptions('machine_name', 'label'); // ['home' => 'Home Page', ...]
```

There is no config and no configure route; behaviour is driven entirely by node field values.
