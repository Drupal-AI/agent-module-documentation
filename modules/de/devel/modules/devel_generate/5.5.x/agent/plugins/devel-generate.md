# Plugin type: DevelGenerate

Devel Generate defines the `DevelGenerate` plugin type — one plugin per kind of entity it can
bulk-create. Add a generator for a custom entity type by implementing one.

- Manager: `Drupal\devel_generate\DevelGeneratePluginManager`
- Discovery dir: `src/Plugin/DevelGenerate/`
- Annotation: `Drupal\devel_generate\Annotation\DevelGenerate`
  (`id`, `label`, `description`, `url`, `permission`, `settings`, `dependencies`)
- Base class: `DevelGenerateBase` (interface `DevelGenerateBaseInterface`)
- Alter hook: `hook_devel_generate_alter()` (see [../hooks/hooks.md](../hooks/hooks.md))

## Implement one
```php
// src/Plugin/DevelGenerate/WidgetDevelGenerate.php
namespace Drupal\my_module\Plugin\DevelGenerate;

use Drupal\devel_generate\DevelGenerateBase;

/**
 * @DevelGenerate(
 *   id = "widget",
 *   label = @Translation("Widgets"),
 *   description = @Translation("Generate a given number of widgets."),
 *   url = "widget",
 *   permission = "administer devel_generate",
 *   settings = { "num" = 50, "kill" = FALSE }
 * )
 */
class WidgetDevelGenerate extends DevelGenerateBase {
  public function settingsForm(array $form, FormStateInterface $form_state) { /* … */ }
  public function generateElements(array $values) { /* create entities */ }
  public function validateDrushParams(array $args, array $options = []) { /* … */ }
}
```
The plugin is automatically exposed both as a UI form (at its `url`) and, when wired via the
`Generator` attribute on a Drush command method, on the CLI.
