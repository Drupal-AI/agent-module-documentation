# Applying tampers in code

## Manager service
`plugin.manager.tamper` (`Drupal\tamper\TamperManagerInterface`, class `TamperManager`,
extends `DefaultPluginManager`). Discovers `Plugin/Tamper/*`, alter hook `hook_tamper_info_alter()`,
cache key `tamper_info_plugins`.

```php
/** @var \Drupal\tamper\TamperManagerInterface $manager */
$manager = \Drupal::service('plugin.manager.tamper');

// createInstance() REQUIRES a 'source_definition' in the configuration.
$config = [
  'source_definition' => new \Drupal\tamper\SourceDefinition([]),
  // plus plugin-specific settings, e.g. for find_replace:
  'find' => 'foo', 'replace' => 'bar',
];
$plugin = $manager->createInstance('find_replace', $config);

$result = $plugin->tamper('foo baz');   // -> 'bar baz'
```

- `getDefinitions()` — list all available tamper definitions (id, label, category, itemUsage…).
- `SourceDefinition` (`src/SourceDefinition.php`) describes the available source properties;
  pass one even if empty. Plugins that need it read it in their constructor.

## Tamperable items
Plugins with `itemUsage` REQUIRED/OPTIONAL receive a `Drupal\tamper\TamperableItemInterface`
as the 2nd `tamper()` arg. Implement it (or use `TamperItem`) to expose the whole row:
- `getSource(): array`
- `getSourceProperty($property)`
- `setSourceProperty($property, $data)`
`TamperableComplexDataAdapter` adapts core ComplexData objects to this interface.

## Control-flow exceptions (`src/Exception/`)
- `TamperException` — the plugin cannot process the data (hard error).
- `SkipTamperDataException` — skip the calling process for this data value.
- `SkipTamperItemException` — skip the entire item.
- `MissingItemException` — an item was required but not provided.

## Collections
`TamperPluginCollection` holds and lazily instantiates an ordered set of configured tamper
plugins — how a consumer (e.g. Feeds) stores a per-field chain of transformations.
