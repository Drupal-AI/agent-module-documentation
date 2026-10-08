# Plugin type: Vado group widget

A group widget controls how a `commerce_vado_group`'s items are presented and selected on the Add-to-Cart
form (and how its default value is computed). Each `commerce_vado_group` stores one widget plugin in its
`group_widget` field.

## Type definition

- Declared in `commerce_vado.plugin_type.yml` as `commerce_vado.vado_group_widget`.
- Manager service **`plugin.manager.commerce_vado_group_widget`** → `VadoGroupWidgetManager`
  (extends `DefaultPluginManager`; alter hook `commerce_vado_group_widget_info`; cache key
  `commerce_vado_group_widget_plugins`).
- Discovery: annotation **`@CommerceVadoGroupWidget`** (`Annotation\CommerceVadoGroupWidget`;
  properties `id`, `label`, `allows_multiple` (bool, default FALSE)) in namespace
  `Plugin\Commerce\VadoGroupWidget`.
- Interface `VadoGroupWidgetInterface` (extends Configurable/Dependent/PluginForm/PluginInspection +
  commerce `ParentEntityAwareInterface`); base class `VadoGroupWidgetBase`.
- Registered as a Commerce referenceable plugin type via `ReferenceablePluginTypesSubscriber`
  (event `commerce.referenceable_plugin_types`), so the `group_widget` field renders as a
  `commerce_plugin_select` element.

## Built-in widgets

| Plugin id | Class | `allows_multiple` | Notes |
|---|---|---|---|
| `checkboxes` | `Checkboxes` | TRUE | checkboxes; no empty "- None -" option |
| `radios` | `Radios` | FALSE | radios; empty option only when group not required |
| `select_list` | `SelectList` | FALSE | select; title display before/after/invisible |
| `select_list_multiple` | `SelectListMultiple` (extends SelectList) | TRUE | multi-select |
| `static_list` | `StaticList` | TRUE | non-interactive `<ul>`; **all** items are hidden-input defaults (a fixed bundle, also add-able via the standard Add-to-Cart form alter) |

Interactive widgets fire the Add-to-Cart form's `ajaxRefresh` on change so the live price updates.

## Widget configuration (stored in the `group_widget` plugin config)

From `VadoGroupWidgetBase::defaultConfiguration()` / `buildConfigurationForm()`:
- `group_title_display` — `before`/`visible` vs `invisible` (SelectList adds `after`).
- `group_item_title_renderer` — `default` (uses the group item label) or `views` (renders each option's
  label through a Views display; see views/views.md). View output is XSS-filtered (admin tags minus `<a>`).
- `group_item_view` — when the renderer is `views`, the chosen `view_id:display_id` (a
  `commerce_vado_group_item_display` or `commerce_vado_group_display`).

Default selection: `getDefaultValue()` returns the group's `default` items (array for multi, single id/NULL
otherwise); `static_list` returns *all* item ids. `VadoGroupForm::validateForm()` blocks multiple default
items when the chosen widget is single-select.

## Add a custom widget

Create `src/Plugin/Commerce/VadoGroupWidget/MyWidget.php` in your module:

```php
namespace Drupal\my_module\Plugin\Commerce\VadoGroupWidget;

use Drupal\commerce_vado\Plugin\Commerce\VadoGroupWidget\VadoGroupWidgetBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * @CommerceVadoGroupWidget(
 *   id = "my_widget",
 *   label = @Translation("My widget"),
 *   allows_multiple = TRUE,
 * )
 */
class MyWidget extends VadoGroupWidgetBase {

  public function buildElement(array $form, FormStateInterface $form_state) {
    return [
      '#type' => 'checkboxes',
      '#title' => $this->parentEntity->label(),           // the VadoGroup
      '#options' => $this->buildGroupItemOptions(),        // published items, respects settings
      '#default_value' => $this->getDefaultValue(),
      '#required' => $this->parentEntity->isRequired(),
      '#ajax' => [
        'callback' => [get_class($form_state->getFormObject()), 'ajaxRefresh'],
        'wrapper' => $form['#wrapper_id'],
      ],
    ];
  }
}
```

`buildGroupItemOptions()`, `allowsUnpublishedVariations()`, `showEmptyOption()` and the Views-renderer
plumbing are inherited from the base class.
