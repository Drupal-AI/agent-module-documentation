# ImcePlugin plugin type

IMCE defines the **`ImcePlugin`** plugin type. Managed by `plugin.manager.imce.plugin`
(`Drupal\imce\ImcePluginManager`); discovered in `Plugin/ImcePlugin/`, annotation
`@ImcePlugin`, base class `ImcePluginBase`, interface `ImcePluginInterface`.
Core plugins: `Core`, `Upload`, `Delete`, `Newfolder`, `Resize`.

## Define one
```php
namespace Drupal\my_module\Plugin\ImcePlugin;

use Drupal\imce\ImcePluginBase;
use Drupal\imce\ImceFM;

/**
 * @ImcePlugin(
 *   id = "rename",
 *   label = @Translation("Rename"),
 *   weight = 5,
 *   operations = { "rename": "opRename" }   // op name -> handler method
 * )
 */
class Rename extends ImcePluginBase {

  // Contribute folder-permission checkboxes shown in profiles.
  public function permissionInfo() {
    return ['rename_files' => $this->t('Rename files')];
  }

  // Add JS libraries / render additions to the file-manager page.
  public function buildPage(array &$page, ImceFM $fm) {
    $page['#attached']['library'][] = 'my_module/rename';
  }

  // Handle the "rename" operation dispatched from JS.
  public function opRename(ImceFM $fm) {
    // $fm->getSelection(), $fm->activeFolder, $fm->response ...
  }
}
```

## Interface hooks (each plugin may implement)
`permissionInfo()`, `alterProfileForm()`, `validateProfileForm()`, `processUserConf()`,
`buildPage()`, `alterJsResponse()`. The manager fans these out with `invokeAll()`.
Operations are declared in the annotation `operations` map and dispatched by
`ImcePluginManager::handleOperation($op, $fm)`.

Alter discovered definitions with `hook_imce_plugin_info_alter()` — see
[../hooks/hooks.md](../hooks/hooks.md).
