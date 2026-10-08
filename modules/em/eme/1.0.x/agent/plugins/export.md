<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin types

eme defines two annotation-based plugin types. Both are `DefaultPluginManager`
subclasses discovered from any module's `src/Plugin/Eme/...` namespace.

## 1. Export plugins

- Manager service: `eme.export_plugin_manager` (`Export\ExportPluginManager`).
- Discovery dir: `Plugin/Eme/Export`. Annotation: `@Export` (id, label,
  description). Interface: `Export\ExportPluginInterface`. Base:
  `Export\ExportPluginBase`.
- Shipped plugin: **`json_files`** (`Plugin\Eme\Export\JsonFiles`) — the only
  one, and the default for both the UI and `drush eme:export`.

An export plugin drives the export as an ordered list of **task methods**
returned by `tasks()`. The manager validates each plugin on instantiation
(`getExportPluginViolations`): every task must be a `protected` method returning
`void` whose single parameter is a by-reference `\ArrayAccess` (the batch
context). Base `ExportPluginBase::tasks()`:

```
initializeExport → discoverContentReferences → writeMigrationPlugins
  → buildModule → finishExport
```

`JsonFiles` inserts `writeEntityDataSource` and `writeMigratedFiles` after
discovery to emit the per-entity JSON and copy `file` assets, and overrides
`createMigrationPluginDefinition()` to add the Migrate Plus `url`/`file`/`json`
source config.

Config passed to `createInstance()` (defaults filled in the constructor):
`types`, `module`, `name`, `id-prefix`, `group`, `path` (a codebase path, or
`NULL` to build the downloadable `temporary://eme.tar.gz` archive instead).

Minimal custom plugin:

```php
// mymodule/src/Plugin/Eme/Export/MyExport.php
namespace Drupal\mymodule\Plugin\Eme\Export;

use Drupal\eme\Export\ExportPluginBase;

/**
 * @Export(
 *   id = "my_export",
 *   label = @Translation("My export"),
 *   description = @Translation("...")
 * )
 */
class MyExport extends ExportPluginBase {

  public function tasks(): array {
    return array_merge(parent::tasks(), ['myExtraStep']);
  }

  protected function myExtraStep(\ArrayAccess &$context): void {
    // ... use $this->temporaryExport()->addFileWithContent(...) etc.
    $context['finished'] = 1;
  }
}
```

Select it with `drush eme:export --plugin my_export ...`.

## 2. Reference discovery plugins

- Manager service: `eme.discovery_plugin_manager`
  (`ReferenceDiscovery\DiscoveryPluginManager`).
- Discovery dir: `Plugin/Eme/ReferenceDiscovery`. Annotation:
  `@ReferenceDiscovery` (id only). Interfaces:
  `DirectReferenceDiscoveryPluginInterface::fetchReferences()` and/or
  `ReverseReferenceDiscoveryPluginInterface::fetchReverseReferences()`. Bases:
  `DirectReferenceDiscoveryPluginBase`, `ReverseReferenceDiscoveryPluginBase`.

During `discoverContentReferences`, every export plugin runs all direct- and
reverse-discovery plugins against each entity to widen the export set so
migrations do not break on missing dependencies.

Shipped plugins (`Plugin\Eme\ReferenceDiscovery`): `EntityReference` (follows
entity-reference / entity_reference_revisions fields), `MenuLinkContent`,
`PathAlias`, `Crop`, `Flagging`, `LayoutOverride`.

```php
// @ReferenceDiscovery(id = "my_refs")
class MyRefs extends DirectReferenceDiscoveryPluginBase {
  public function fetchReferences(ContentEntityInterface $entity): array {
    return [/* referenced ContentEntityInterface objects */];
  }
}
```

The manager exposes `getDirectReferenceDiscoveryPluginInstances()` and
`getReverseReferenceDiscoveryPluginInstances()`, splitting definitions by the
interface each plugin class implements.
