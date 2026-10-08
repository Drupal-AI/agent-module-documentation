# panels — plugin types

Panels defines three plugin types. (The `panels_variant` display variant itself is an
implementation of ctools/core's `DisplayVariant` type, not a new type.)

## PanelsStorage — where a display is stored

- Manager: `panels.storage_manager` (`Drupal\panels\Storage\PanelsStorageManager`)
- Namespace: `Plugin/PanelsStorage`
- Annotation: `@PanelsStorage` (a bare `PluginID` — id only)
- Interface: `Drupal\panels\Storage\PanelsStorageInterface`; base
  `Drupal\panels\Storage\PanelsStorageBase`
- Alter hook: `hook_panels_storage_info_alter()`; cache key `panels_storage`

Implement `load($id)`, `save(PanelsDisplayVariant $panels_display)`, and
`access($id, $op, AccountInterface $account)` where `$op` is one of
`create|read|update|delete|change layout`. Bundled plugin:
`PageManagerPanelsStorage` (id `page_manager`) stores displays inside Page Manager page
variants. The `_panels_storage_access` route access check (`PanelsStorageAccess`) delegates
to the relevant storage plugin's `access()`.

```php
namespace Drupal\my_module\Plugin\PanelsStorage;

use Drupal\panels\Storage\PanelsStorageBase;

/**
 * @PanelsStorage("my_storage")
 */
class MyStorage extends PanelsStorageBase {
  public function load($id) { /* return a PanelsDisplayVariant or NULL */ }
  public function save(\Drupal\panels\Plugin\DisplayVariant\PanelsDisplayVariant $display) {}
  public function access($id, $op, \Drupal\Core\Session\AccountInterface $account) {}
}
```

## PanelsPattern — tempstore/context wiring for the wizard

- Manager: `plugin.manager.panels.pattern` (`Drupal\panels\PanelsPatternManager`)
- Namespace: `Plugin/PanelsPattern`
- Annotation: `@PanelsPattern` (bare `PluginID`)
- Interface: `PanelsPatternInterface`; default plugin `DefaultPattern`

Supplies `getMachineName()`, `getDefaultContexts($tempstore, $tempstore_id, $machine_name)`
and `getBlockListUrl(...)` — how a given hosting pattern (e.g. Page Manager) locates its
tempstore and default contexts and builds block-add URLs.

## DisplayBuilder — how a display renders

- Manager: `plugin.manager.panels.display_builder`
  (`Drupal\panels\Plugin\DisplayBuilder\DisplayBuilderManager`)
- Namespace: `Plugin/DisplayBuilder`
- Annotation: `@DisplayBuilder` (has `label`, `description`)
- Interface: `DisplayBuilderInterface`; base `DisplayBuilderBase`

`StandardDisplayBuilder` (id `standard`) is the default renderer. The `panels_ipe`
submodule provides `InPlaceEditorDisplayBuilder` (id `ipe`) to render the front-end editor.
A display picks its builder via the `builder` config key.
