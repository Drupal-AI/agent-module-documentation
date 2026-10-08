<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# cl_editorial API surface

Everything here is meant to be called from your own module. `configure` is null; there is nothing
to set up in the UI.

## Form element: `cl_component_selector`

`Drupal\cl_editorial\Element\ComponentSelectorElement` (`@FormElement("cl_component_selector")`).
A searchable radio list of SDC components (thumbnail, name, status, README).

```php
$form['component'] = [
  '#type' => 'cl_component_selector',
  '#title' => $this->t('Pick a component'),
  '#default_value' => ['machine_name' => 'mymodule:card'],   // stored value shape
  '#filters' => [
    'allowed' => [],                 // only these plugin ids (empty = all)
    'forbidden' => [],               // exclude these plugin ids
    'statuses' => ['stable', 'experimental'],  // ExtensionLifecycle statuses
  ],
  // optional '#ajax' => [...],
];
```

- The submitted value is an array with a `machine_name` key = the chosen component's plugin id.
- `#process` (`populateOptions`) builds the search box, a "show deprecated" checkbox, and the radios;
  `#element_validate` (`validateExistingComponent`) errors if the id no longer exists.
- Attaches the module's selector library and themes each radio with
  `form_element__radio__cl_component`.

## Service: `NoThemeComponentManager`

`Drupal\cl_editorial\NoThemeComponentManager` (service id = the class name; decorates
`plugin.manager.sdc`). Lists SDC components **regardless of the active theme**.

```php
/** @var \Drupal\cl_editorial\NoThemeComponentManager $mgr */
$mgr = \Drupal::service(\Drupal\cl_editorial\NoThemeComponentManager::class);

$components = $mgr->getFilteredComponents(
  $allowed = [],      // plugin ids to include (empty = all)
  $forbidden = [],    // plugin ids to exclude
  $statuses = ['stable', 'experimental']
);                    // => [plugin_id => \Drupal\Core\Plugin\Component], ksorted

$mgr->getDefinitions();                     // proxy to the SDC manager
$mgr->find('mymodule:card');                // Component or ComponentNotFoundException
$mgr->createInstanceAndCatch('mymodule:card'); // Component or NULL (never throws)
```

It drops definitions that are `replaces`-overridden (`getDefinitionsWithoutReplacements()`).

## Helper: `cl_editorial_component_mappings_form()`

Builds a form that maps a component's **props** (from its JSON schema) and **slots** into editor
input. Backed by `ComponentInputToForm` + the `cl_editorial.form_generator` service
(`SchemaForms\Drupal\FormGeneratorDrupal`).

```php
$element = cl_editorial_component_mappings_form(
  $selected_component,        // plugin id string
  $current_input,             // ['props' => [...], 'slots' => ['slot' => ['format' => ..., 'value' => ...]]]
  $form,
  $form_state,
  $supported_token_types = [] // e.g. ['node'] to show a token tree when Token is installed
);
// $element['props']  -> generated from the schema
// $element['slots'][<slot>] -> a #type text_format per component slot
// $element['tree']   -> token_tree_link (only if the token module exists)
```

## Trait: `ComponentFiltersFormTrait`

`Drupal\cl_editorial\Form\ComponentFiltersFormTrait::buildSettingsForm(...)` renders the
allowed/forbidden/status **filter** sub-form (with AJAX refine) used to constrain which components
apply. `validates()` errors if a component is in both the allowed and forbidden lists;
`onChangeAjaxCallback()` re-renders the refine section. sdc_tags' `ComponentTagDefault` uses this
trait — see the submodule docs for a working example.

## Util

`Drupal\cl_editorial\Util::isPropOrSlot(Component $component, string $input): ?string` returns
`'prop'`, `'slot'`, or `NULL` for a given input name on a component.

## Notes

- No config entities or settings; state lives wherever the *consuming* module stores the selected
  id + prop/slot input.
- The props form generator depends on the `SchemaForms` and `Shaper` PHP libraries; Markdown README
  rendering in the selector is optional via `league/commonmark`.
