# panels — services & display API

## Services (`panels.services.yml`)

| Service | Class | Purpose |
|---|---|---|
| `panels.display_manager` | `PanelsDisplayManager` | Create/encode/decode a `panels_variant` display to & from a config array. Args: `@plugin.manager.display_variant`, `@config.typed`. |
| `panels.storage_manager` | `Storage\PanelsStorageManager` | Plugin manager for `PanelsStorage`; also `load`/`save`/`access` on displays by storage type + id. |
| `plugin.manager.panels.display_builder` | `Plugin\DisplayBuilder\DisplayBuilderManager` | Plugin manager for `DisplayBuilder`. |
| `plugin.manager.panels.pattern` | `PanelsPatternManager` | Plugin manager for `PanelsPattern`. |
| `panels.storage_access` | `Storage\PanelsStorageAccess` | Route access check `_panels_storage_access` → storage plugin `access()`. |
| `panels.tempstore_access` | `Access\TempstoreAccess` | Route access check `_panels_tempstore_access`. |

## Working with a display in code

```php
/** @var \Drupal\panels\PanelsDisplayManagerInterface $dm */
$dm = \Drupal::service('panels.display_manager');
// Build a fresh Panels display variant plugin.
$display = $dm->createDisplay();

// Encode to a storable config array / decode back.
$config = $dm->encodeDisplay($display);
$display = $dm->importDisplay($config);
```

`PanelsDisplayVariant` (the `panels_variant` plugin, extends ctools
`BlockDisplayVariant`, implements ctools `PluginWizardInterface`) is the object you
manipulate. Notable methods:

- `getLayout()` / `setLayout($id, $settings)` — the core Layout plugin.
- `getRegionAssignments()` — blocks grouped by the layout's regions.
- `addBlock($config)` / `getBlock($uuid)` / `updateBlock($uuid, $config)` / `removeBlock($uuid)`.
- `setStorage($type, $id)` / `getStorageType()` / `getStorageId()` — bind it to a
  `PanelsStorage` plugin.
- `getBuilder()` — the active `DisplayBuilder`; `getPattern()` — the `PanelsPattern`.

## Persisting via storage

```php
/** @var \Drupal\panels\Storage\PanelsStorageManagerInterface $sm */
$sm = \Drupal::service('panels.storage_manager');
$display = $sm->load('page_manager', $variant_id);   // load by storage type + id
$sm->save($display);                                  // save back through its plugin
$access = $sm->access('page_manager', $id, 'update', $account);
```

The storage manager dispatches `PanelsEvents` (`PanelsVariantEvent`) so subscribers can
react as displays load/save.
