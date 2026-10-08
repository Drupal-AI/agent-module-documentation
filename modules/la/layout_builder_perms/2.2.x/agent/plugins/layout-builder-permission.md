# Plugin type: `LayoutBuilderPermission`

The base module defines a plugin type that lets any module contribute a permission check for a
Layout Builder operation, optionally scoped by context (layout, entity, block type, …). All six
submodules are just implementations of this type.

## Wiring

- Manager service `plugin.manager.layout_builder_perms`
  (`LayoutBuilderPermissionPluginManager`, parent `default_plugin_manager`).
- Discovery: annotation `@LayoutBuilderPermission` (`src/Annotation/LayoutBuilderPermission.php`)
  on classes in `src/Plugin/LayoutBuilderPermission/` of any module.
- Interface `LayoutBuilderPermissionInterface`; base class `LayoutBuilderPermissionBase`
  (uses `ContextAwarePluginTrait`).
- Alter hook `hook_layout_builder_permission_info_alter(&$definitions)`.
- Deriver base `LayoutBuilderPermissionPluginDeriverBase` (helpers:
  `getLayoutBuilderOperations()`, plus submodules add layout/bundle helpers) — used to generate
  one plugin per layout/bundle/block-type/operation combination.

## Definition keys (set on the annotation or by a deriver)

`permission` (the permission string checked), `label`, `description`, and the **filter keys**
used by `AccessManager` to decide which plugins to load for a request: `operation`,
`component`, `action`, `layout`, `block_type`, `entity_type`, `bundle`. Also
`context_definitions` (commonly `operation` [required string], `layout` [layout_section],
`entity`, `block`).

`LayoutBuilderPermissionPluginManager::getPermissionPlugins($filters)` returns instantiated
plugins whose definition matches every provided filter (a definition key that is unset is treated
as matching any value).

## Methods to implement/override

- `getPermission()/getLabel()/getDescription()` — return from the plugin definition by default.
- `applies(): bool` — base returns `operation === definition['operation']` (read from the
  `operation` context). Override to also check runtime context, e.g.:

```php
public function applies(): bool {
  $applies = parent::applies();
  if ($applies) {
    try {
      $layout = $this->getContextValue('layout');
      [, $layout_id] = explode(':', $this->getPluginId());
      if (!$layout || $layout->getLayoutId() !== $layout_id) {
        $applies = FALSE;
      }
    }
    catch (PluginException | ContextException $e) {
      $applies = FALSE; // Fail closed if context is unreadable.
    }
  }
  return $applies;
}
```

- `access(string $operation, AccountInterface $account): AccessResultInterface` — base returns
  `AccessResult::allowedIfHasPermission($account, $this->getPermission())`. Override for custom
  logic.

## Minimal custom plugin

```php
// src/Plugin/LayoutBuilderPermission/MyGate.php
namespace Drupal\my_module\Plugin\LayoutBuilderPermission;

use Drupal\layout_builder_perms\LayoutBuilderPermissionBase;

/**
 * @LayoutBuilderPermission(
 *   id = "my_gate",
 *   permission = "do my custom layout thing",
 *   label = @Translation("Do my custom layout thing"),
 *   operation = "block_add",
 *   context_definitions = {
 *     "operation" = @ContextDefinition("string", required = TRUE)
 *   }
 * )
 */
class MyGate extends LayoutBuilderPermissionBase {}
```

Because results are AND-combined, a custom plugin can only make an operation **more**
restrictive. To add extra runtime contexts, subscribe to
`LayoutBuilderPermissionPluginContexts` (dispatched from `AccessManager::setPluginContext`) — see
`extend/access-model.md`.
