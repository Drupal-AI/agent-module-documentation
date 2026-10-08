# The `FieldWidgetAction` plugin type

An action is a plugin discovered from `Plugin/FieldWidgetAction/` in any module, declared
with the attribute `Drupal\field_widget_actions\Attribute\FieldWidgetAction` and implementing
`FieldWidgetActionInterface`. Manager: `plugin.manager.field_widget_actions`
(`FieldWidgetActionManager`), alter hook `field_widget_action_info`, cache key
`field_widget_action_plugins`.

## Attribute properties

`FieldWidgetAction(id, label, widget_types, field_types, category?, multiple?, deriver?, description?)`

| Property | Meaning |
|----------|---------|
| `id` | Plugin id. Must equal the group or be prefixed `group:xxx` (a discovery quirk noted in the attribute). |
| `label` | `TranslatableMarkup` shown in the *Add action* dropdown. |
| `widget_types` | Widget plugin ids this action applies to; **empty array = all widgets**. |
| `field_types` | Field types this action applies to; **empty array = all field types**. |
| `category` | Optgroup in the dropdown (defaults to "Other"). |
| `multiple` | **Deprecated** in 1.3.1 (removed in 2.0). Use the per-action `multiple` config instead. |
| `deriver` | Optional deriver class. |
| `description` | Optional help text. |

`FieldWidgetActionManager::getAllowedFieldWidgetActions($widget_type, $field_type)` filters
definitions by these two lists; `getFieldWidgetActionFormDefinitions()` returns only actions
that instantiate to a `FieldWidgetFormActionInterface`.

## Base class hierarchy

- **`FieldWidgetActionBase`** — implement this for a **direct-fill or suggestions** action.
  You typically override `getAjaxCallback()` to name a method on the class that returns an
  `AjaxResponse`; the base wires the button's `#ajax` to it. Helpers available:
  - `returnSuggestions($suggestions, $selector)` — opens a modal listing suggestions
    (theme `field_widget_actions_suggestions`) that the user can click to fill the target.
  - `getSuggestionsTarget()` / `getTargetElement()` / `getTargetElementFieldName()` /
    `getTargetElementDelta()` — resolve the field element the button belongs to.
  - `buildEntity($form, $form_state)` — the entity with the current unsaved form values
    (drops literal-NULL field values first to avoid a core `massageFormValues` TypeError).
  - `isAvailable()` (default TRUE — override to hide when prerequisites are missing),
    `getLibraries()` (extra libraries to attach), `isMultiple()`.
  - Override the constant `FORM_ELEMENT_PROPERTY` (default `'value'`) when the target
    property differs, e.g. `'target_id'` for entity reference, `'alt'` for image alt text.
- **`FieldWidgetFormActionBase`** (`FieldWidgetFormActionInterface`) — implement this for an
  action that opens a **modal form**. It is plugin + `FormInterface` + controller in one.
  Implement `buildModalForm(...)` and `submitModalFormFillFields(...)`. The button becomes a
  `use-ajax` link opening the wrapper form; state is stashed in the private tempstore
  `field_widget_actions_form_collection` keyed `{plugin_id}-{uuid}`, and the submit routes
  through `field_widget_actions.modal_form_action`. Insertion is done with the AJAX fill
  commands (see [api/services.md](../api/services.md)).
- **`FieldWidgetRefinableFormActionBase`** (`RefinementAwareInterface`) — implement this for
  **generate → refine → insert** content actions (the AI-authoring shape). Implement only:
  - `generateContent(?ContentEntityInterface $entity, array $context_data): string`
  - `refineContent(string $content, string $prompt, ?ContentEntityInterface $entity, array $context_data): string`

  The base builds the modal (a `textarea`, or a `text_format` element when the target is
  rich text), and — when the *Enable interactive refinement* config is on — adds a refinement
  prompt and a **Refine** button that rebuilds the modal with `refineContent()`'s output. No
  custom JavaScript is needed; Drupal's form/dialog APIs drive the loop. If refinement is off
  and the plugin supplies its own `getAjaxCallback()`, the button keeps direct-fill behaviour.

## Minimal example

```php
namespace Drupal\my_module\Plugin\FieldWidgetAction;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\field_widget_actions\Attribute\FieldWidgetAction;
use Drupal\field_widget_actions\FieldWidgetActionBase;
use Drupal\Core\Ajax\AjaxResponse;
use Drupal\Core\Form\FormStateInterface;

#[FieldWidgetAction(
  id: 'my_action',
  label: new TranslatableMarkup('Suggest text'),
  widget_types: [],                 // all widgets
  field_types: ['string', 'text_long'],
  category: new TranslatableMarkup('My module'),
)]
class MyAction extends FieldWidgetActionBase {

  public function getAjaxCallback(): ?string {
    return 'suggest';
  }

  public function suggest(array &$form, FormStateInterface $form_state): AjaxResponse {
    $selector = $this->getSuggestionsTarget($form, $form_state);
    return $this->returnSuggestions(['Option A', 'Option B'], $selector);
  }
}
```

See the `field_widget_actions_test` module in the source (`tests/modules/`) for worked
examples of each base class, including `RefinableTextsTestAction`.
