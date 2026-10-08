# Plugins — Config Patch output plugins

Config Patch defines one plugin type, **`output`**, that decides what happens to a generated
patch (print it, write a file, open a PR/MR, etc.).

- Manager: `plugin.manager.config_patch.output` (`src/PluginManager.php`), a
  `DefaultPluginManager` + `FallbackPluginManagerInterface`.
- Directory: `Plugin/config_patch/output`.
- Annotation: `@ConfigPatchOutput` (`src/Annotation/ConfigPatchOutput.php`) — `id`, `label`,
  `action` (button-hint text).
- Interface: `OutputPluginInterface`; base class: `OutputPluginBase`.
- Optional interface `CliOutputPluginInterface` — implement it to support `drush config:patch`.
- **Fallback:** unknown plugin ids resolve to `config_patch_output_text`
  (`getFallbackPluginId`).

## Interface surface

`OutputPluginInterface` (extends the standard plugin inspection interfaces):

- `getId()`, `getLabel()`, `getAction()` — implemented by `OutputPluginBase`.
- `output(array $patches, FormStateInterface $form_state)` — act on the patch set on form
  submit. `$patches` is keyed by config collection, then config name → patch string.
- `alterForm(array $form, FormStateInterface $form_state)` — add fields to the Patch form
  (e.g. a repo/target selector). Base returns `$form` unchanged.

`CliOutputPluginInterface`:

- `outputCli(array $patches, array $config_changes = [], array $params = [])` — return the
  string Drush should print/write.

## Minimal example

```php
namespace Drupal\my_module\Plugin\config_patch\output;

use Drupal\config_patch\Plugin\config_patch\output\OutputPluginBase;
use Drupal\config_patch\Plugin\config_patch\output\CliOutputPluginInterface;
use Drupal\Core\Form\FormStateInterface;

/**
 * @ConfigPatchOutput(
 *   id = "my_module_download",
 *   label = @Translation("Download patch file"),
 *   action = @Translation("Download patch")
 * )
 */
class Download extends OutputPluginBase implements CliOutputPluginInterface {

  public function output(array $patches, FormStateInterface $form_state) {
    // e.g. build a file response, submit to an API, etc.
  }

  public function outputCli(array $patches, array $config_changes = [], array $params = []) {
    $out = '';
    foreach ($patches as $collection) {
      foreach ($collection as $name => $patch) {
        $out .= $patch;
      }
    }
    return $out;
  }
}
```

The bundled `Text` plugin (`config_patch_output_text`) simply concatenates the patches; its
`output()` sends a `text/plain` response and `exit()`s. Contrib submodules
(`config_patch_gitlab`, `config_patch_github_api`, `config_patch_gitea`,
`config_patch_azure_api`) add plugins that submit patches to hosted Git providers.
