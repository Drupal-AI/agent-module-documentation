# BlockFieldSelection plugin type

The module defines one plugin type controlling **which blocks a block_field offers**.

- Manager service: `plugin.manager.block_field_selection`
  (`BlockFieldSelectionManager`, extends `DefaultPluginManager`).
- Discovery dir: `src/Plugin/block_field/BlockFieldSelection/`.
- Annotation: `@BlockFieldSelection` (`Drupal\block_field\Annotation\BlockFieldSelection`
  — `id`, `label`).
- Interface / base: `BlockFieldSelectionInterface` / `BlockFieldSelectionBase`.
- Alter hook: `hook_block_field_block_field_selection_info_alter()`.

Built-in plugins: `blocks` (whitelist plugin IDs) and `categories` (allow by category).

## Implement one
```php
namespace Drupal\my_module\Plugin\block_field\BlockFieldSelection;

use Drupal\block_field\BlockFieldSelectionBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * @BlockFieldSelection(
 *   id = "my_selection",
 *   label = @Translation("My selection"),
 * )
 */
class MySelection extends BlockFieldSelectionBase {

  public function defaultConfiguration() {
    return ['my_setting' => []] + parent::defaultConfiguration();
  }

  // Form shown on the field settings form under "Selection settings".
  public function buildConfigurationForm(array $form, FormStateInterface $form_state) {
    $form = parent::buildConfigurationForm($form, $form_state);
    // add elements...
    return $form;
  }

  // Return the block plugin IDs this handler allows for the widget's select list.
  public function getReferenceablePluginIds() {
    // ...
  }
}
```
Config schema for your handler goes under `block_field_selection.my_selection` (see
`config/schema/block_field.yml`). The manager caches definitions in
`block_field_block_field_selection_plugins`.

## Field plugins (for reference)
Field type `block_field` (`BlockFieldItem`), widget `block_field_default`
(`BlockFieldWidget`), formatters `block_field` (`BlockFieldFormatter`) and
`block_field_label` (`BlockFieldLabelFormatter`).
