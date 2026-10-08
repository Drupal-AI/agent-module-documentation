# Define a new group format — FieldGroupFormatter plugin

Field Group defines the **`FieldGroupFormatter`** plugin type. Each plugin is one selectable
group format (Details, Tabs, HTML element, …). Add one to offer a new grouping/rendering style.

- Namespace: `Plugin/field_group/FieldGroupFormatter`
- Annotation: `@FieldGroupFormatter` (`Drupal\field_group\Annotation\FieldGroupFormatter`)
- Interface: `Drupal\field_group\FieldGroupFormatterInterface`
- Base class: `Drupal\field_group\FieldGroupFormatterBase`
- Manager service: `plugin.manager.field_group.formatters`

```php
namespace Drupal\mymodule\Plugin\field_group\FieldGroupFormatter;

use Drupal\field_group\FieldGroupFormatterBase;

/**
 * @FieldGroupFormatter(
 *   id = "my_card",
 *   label = @Translation("Card"),
 *   description = @Translation("Wraps fields in a card."),
 *   supported_contexts = {"form", "view"},
 *   format_types = {"my_card"}
 * )
 */
class MyCard extends FieldGroupFormatterBase {

  public function preRender(array &$element, $rendering_object) {
    parent::preRender($element, $rendering_object);       // view/display path
    $element['#theme_wrappers'] = ['container'];
    $element['#attributes']['class'][] = 'card';
  }

  public function process(array &$element, $processed_object) {
    // form path (called in #process); build the wrapper element here.
  }

  public function settingsForm() {                          // per-group config UI
    $form = parent::settingsForm();
    $form['heading_tag'] = ['#type' => 'textfield', '#default_value' => $this->getSetting('heading_tag')];
    return $form;
  }

  public function settingsSummary() {                       // one-line summary in Field UI
    return ['Card format'];
  }

  public static function defaultSettings($context = '') {
    return ['heading_tag' => 'h3'] + parent::defaultSettings($context);
  }
}
```

Key annotation keys: `supported_contexts` (`form`/`view`), `format_types` (the group render
mode ids), optional `weight` (order in the format dropdown). Implement `process()` for form
rendering and `preRender()` for entity view. `drush cr`, then the new format appears in the
**Add group** dropdown. Extra annotation keys can be added via
`hook_field_group_formatter_info_alter()`.
