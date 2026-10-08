<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Normalize a storage / item in code

## Wrap a storage

`NormalizedReadOnlyStorage` decorates any `StorageInterface`, running the normalizer plugins on
every `read()` / `readMultiple()`. It is **read-only** (writes throw, like core
`ReadOnlyStorage`).

```php
use Drupal\config_normalizer\Config\NormalizedReadOnlyStorage;

$active  = \Drupal::service('config.storage');           // storage to normalize
$manager = \Drupal::service('plugin.manager.config_normalizer');

$normalized = new NormalizedReadOnlyStorage($active, $manager, [
  'normalization_mode'        => 'compare',              // 'compare' (default) or 'provide'
  'reference_storage_service' => $active,                // storage to normalize against
]);

$data = $normalized->read('system.site');                // e.g. keys sorted, uuid/_core reconciled
```

## The context array

`NormalizedReadOnlyStorageInterface::DEFAULT_CONTEXT`:

| Key | Meaning |
|---|---|
| `normalization_mode` | `compare` (`NORMALIZATION_MODE_COMPARE`, the default) or `provide` (`NORMALIZATION_MODE_PROVIDE`). Sorting/`filter_format` run **only** in compare mode; `provide` keeps data write-safe. |
| `reference_storage_service` | The storage the data is normalized against; when it is `config.storage`, the `active` plugin replicates install-time property changes (uuid/_core). |

Set/read it with `setContext()` / `getContext()`; `createCollection()` preserves the context.

## Normalize a single item

```php
use Drupal\config_normalizer\ConfigItemNormalizer;

$itemNormalizer = new ConfigItemNormalizer(\Drupal::service('plugin.manager.config_normalizer'));
$normalizedData = $itemNormalizer->normalize('system.site', $data, [
  'normalization_mode' => 'compare',
]);
```

## Build a normalized StorageComparer

Use `NormalizedStorageComparerTrait` on a class that can reach `config.manager` and
`plugin.manager.config_normalizer` (call `setConfigManager()` / `setNormalizerManager()`), then:

```php
$comparer = $this->createStorageComparer($sourceStorage, $targetStorage);
// = new StorageComparer(
//     new NormalizedReadOnlyStorage($source, $mgr, [mode, reference => target]),
//     new NormalizedReadOnlyStorage($target, $mgr, [mode, reference => source]),
//     $configManager);
$comparer->createChangelist();
```

Each side is normalized against the *other* storage, so the resulting changelist reflects only
meaningful differences. `createStorageComparer()` accepts an optional `$mode` (defaults to
`compare`).
