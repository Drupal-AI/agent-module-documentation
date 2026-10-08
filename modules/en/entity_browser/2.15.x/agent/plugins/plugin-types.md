# Plugin types Entity Browser defines

Entity Browser defines **six** plugin types, each with a manager service
(`plugin.manager.entity_browser.*`), an annotation class in `src/Annotation/`, and a
plugin directory under `src/Plugin/EntityBrowser/{Type}/`. All use annotation discovery
(no PHP attributes yet).

| Type | Annotation | Manager service | Dir | Core plugins |
|---|---|---|---|---|
| Display | `@EntityBrowserDisplay` | `plugin.manager.entity_browser.display` | `Display/` | iframe, modal, standalone |
| Widget | `@EntityBrowserWidget` | `plugin.manager.entity_browser.widget` | `Widget/` | view, upload, media_image_upload |
| WidgetSelector | `@EntityBrowserWidgetSelector` | `plugin.manager.entity_browser.widget_selector` | `WidgetSelector/` | tabs, drop_down, single |
| SelectionDisplay | `@EntityBrowserSelectionDisplay` | `plugin.manager.entity_browser.selection_display` | `SelectionDisplay/` | multi_step_display, view, no_display |
| FieldWidgetDisplay | `@EntityBrowserFieldWidgetDisplay` | `plugin.manager.entity_browser.field_widget_display` | `FieldWidgetDisplay/` | label, rendered_entity, thumbnail |
| WidgetValidation | `@EntityBrowserWidgetValidation` | `plugin.manager.entity_browser.widget_validation` | `WidgetValidation/` | cardinality, entity_type, file |

Implement one by dropping a class in your module's
`src/Plugin/EntityBrowser/{Type}/` extending the matching base
(`DisplayBase`, `WidgetBase`, `WidgetSelectorBase`, `SelectionDisplayBase`,
`FieldWidgetDisplayBase`, or `WidgetValidationBase` in `src/`).

```php
namespace Drupal\mymodule\Plugin\EntityBrowser\Widget;

use Drupal\entity_browser\WidgetBase;

/**
 * @EntityBrowserWidget(
 *   id = "my_widget",
 *   label = @Translation("My widget"),
 *   description = @Translation("Custom selection source."),
 *   auto_select = FALSE
 * )
 */
class MyWidget extends WidgetBase {
  public function getForm(array &$original_form, FormStateInterface $form_state, array $additional_widget_parameters) { /* ... */ }
  public function submit(array &$element, array &$form, FormStateInterface $form_state) {
    // Build entities, then:
    $this->selectEntities($entities, $form_state);
  }
}
```

Each type has an alter hook to tweak discovered definitions — see
[../hooks/hooks.md](../hooks/hooks.md). Run `drush cr` after adding a plugin.
The `entity_form` widget lives in the Entity Browser IEF submodule.
