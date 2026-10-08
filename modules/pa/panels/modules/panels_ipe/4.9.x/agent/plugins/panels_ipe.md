# panels_ipe — IPEAccess plugin type

Panels IPE defines one plugin type for pluggable editor access rules.

- Manager: `plugin.manager.ipe_access` (`Drupal\panels_ipe\Plugin\IPEAccessManager`, a
  `default_plugin_manager`)
- Namespace: `Plugin/IPEAccess`
- Annotation: `@IPEAccess` (has `id`, `label`)
- Interface: `IPEAccessInterface`; base `IPEAccessBase`

Use it to add access logic on top of the base `access panels in-place editing` permission
(for example, only allow the IPE in certain contexts or for certain displays).

```php
namespace Drupal\my_module\Plugin\IPEAccess;

use Drupal\panels_ipe\Plugin\IPEAccessBase;

/**
 * @IPEAccess(
 *   id = "my_rule",
 *   label = @Translation("My IPE access rule")
 * )
 */
class MyRule extends IPEAccessBase {
  // Implement IPEAccessInterface access logic.
}
```

The related `InPlaceEditorDisplayBuilder` (DisplayBuilder plugin id `ipe`) — which actually
renders the editor — is documented with the parent module's plugin types; see
[../../../../4.9.x/agent/plugins/panels.md](../../../../4.9.x/agent/plugins/panels.md).
