<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Service decorators & form processing

The module ships no plugins and no routes; its behaviour comes entirely from four service decorators
(`dkan_json_form_tweak.services.yml`) that extend the equivalent `json_form_widget` classes, plus
theme hooks and two JS behaviors. Each decorator calls its parent and layers on the tweak.

## FormBuilder — `src/FormBuilder.php`
Decorates `json_form.builder` (args: `@json_form.router`, `@json_form.schema_ui_handler`,
`@json_form.logger_channel`). `getJsonForm($data, $form_state)` calls the parent then mutates the
render array. It distinguishes the top-level dataset form from a sub-schema form by the presence of
`$form['data']['data']`.

- **navigation** (when `settingEnabled('navigation')`): iterates `Element::children()` of the form
  part, collecting each visible child's `#title` into `$items` as `['#markup' => …]`, and appends a
  `#theme => 'dkan_json_form_navigation'` element (`#label` "Go to property:", `#weight => -1`). Sets
  `data-json-form-navigation="true"` on the sub-schema container and attaches library
  `dkan_json_form_tweak/dkan_json_form_navigation`.
- **remove_multivalue**: for multi-value properties (`count(...) > 1`) it wraps each simple value in a
  `container` holding the original `value` plus a `remove_item` checkbox; for `details`-typed values it
  adds `remove_item` inside each item. This checkbox is consumed later by `ValueHandler`.
- **close_details** (only for properties whose first item is a `details` element): appends a
  `#theme => 'dkan_json_form_close_button'` element. Attaches library
  `dkan_json_form_tweak/dkan_json_form_close_details` and passes translated `close_label`/`open_label`
  into `drupalSettings`.
- `settingEnabled(?FormStateInterface, $setting)`: pulls `form_display` from form-state storage and
  returns its `dkan_json_form_tweak` third-party setting, else `FALSE`.

## ValueHandler — `src/ValueHandler.php`
Decorates `json_form.value_handler`. Realises the "remove" action on save.
- `getObjectInArrayData()`: after the parent builds the data, unsets any array item whose
  `[$property]['remove_item']` value is truthy, then `array_values()` to re-key.
- `flattenArraysInArrays($value)`: returns `[]` for a value whose `remove_item` is set (dropping it),
  otherwise unwraps the `value` container that `FormBuilder` added and defers to the parent. Together
  these strip removed entries so they are not persisted.

## FieldTypeRouter — `src/FieldTypeRouter.php`
Decorates `json_form.router`. `getFormElement()` calls the parent and marks the produced element with
`#dkan_field_type_router = TRUE` (on the element, or on the named sub-element when the top level has no
`#type`). This flag drives the theme suggestions below.

## SchemaUiHandler — `src/SchemaUiHandler.php`
Decorates `json_form.schema_ui_handler`. `applySchemaUi($form)` additionally walks a sub-schema form
(`$form['data']['data']`) and applies each property's schema-UI spec via `handlePropertySpec()` before
calling the parent. Per the in-code note, it currently only handles the "hidden" widget spec correctly
for sub-schemas because DKAN cannot resolve references inside sub-schemas (e.g. publisher in
distribution).

## Theme layer — `dkan_json_form_tweak.module` + `templates/`
`hook_theme()` registers `dkan_json_form_navigation` (`label`, `items`) and
`dkan_json_form_close_button` (`label`, `status`). `theme_suggestions_fieldset_alter` and
`theme_suggestions_form_element_alter` add `fieldset__dkan_field_type_router` /
`form_element__dkan_field_type_router` suggestions when `#dkan_field_type_router` is set. Templates
(`dkan-json-form-navigation.html.twig`, `dkan-json-form-close-button.html.twig`) render Bootstrap
dropdown / button markup.

## JS behaviors — `js/`
`dkanJsonFormNavigation.js` (`Drupal.behaviors.DkanJsonFormTweakNavigation`): clicking a dropdown item
closes the Bootstrap dropdown and focuses the first visible focusable input of the target property
(handles both top-level and sub-form via `[data-json-form-navigation="true"]`).
`dkanJsonFormCloseDetails.js` (`Drupal.behaviors.DkanJsonFormTweakCloseDetails`, uses `once()`): the
Close button toggles `data-buttonstatus` and adds/removes the `open` attribute on all sibling
`details`, swapping label between `drupalSettings.dkan_json_form_tweak.close_label`/`open_label`.
