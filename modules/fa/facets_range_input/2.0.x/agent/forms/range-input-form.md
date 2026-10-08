<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# RangeInputForm, JS and templates

## Form: `facets_range_input_form`

File: `src/Form/RangeInputForm.php`
Class: `Drupal\facets_range_input\Form\RangeInputForm extends FormBase`

Constructed directly by the widget: `new RangeInputForm($facet, $configuration)` (constructor stores the
`FacetInterface` and the widget config array). `getFormId()` = `facets_range_input_form`.

### buildForm()

- Sets wrapper classes `js-facets-widget` and `js-facets-<widgetType>`, and `#theme = 'facets_range_input_form'`.
- For each of `minimum` and `maximum` builds a `#type => number` element:
  - `#title` / `#placeholder` from the widget config (`<field>_title` / `<field>_placeholder`).
  - `#field_suffix` = `'<div id="' . $facet->id() . '_' . $field_id . '_validation"></div>'` — the id uses the
    facet machine name + literal field id (admin-defined, not request data).
  - `#maxlength => 10`, `#size => 10`, `#required => TRUE`, and `#attributes` carrying `id`,
    `facet-range-input-input-id`, `facet-range-input-input-title`, `facet-range-input-facet-id` (used by the JS).
- Adds a `validationContainer` container and an **Apply** submit with `#ajax => ['callback' => '::ajaxSubmit', 'event' => 'click']`.
- `#cache = ['max-age' => 0]`.

### validateForm() / submitForm() / ajaxSubmit()

- `validateForm()` returns a bool: treats empty minimum as 0, returns FALSE if maximum is empty or if `min >= max`,
  else TRUE (it is a helper for `ajaxSubmit`, not a standard constraint-adding validator).
- `submitForm()` is empty — the filter is applied client-side via the AJAX callback, not on form submit.
- `ajaxSubmit()` returns an `AjaxResponse`. If `validateForm()` passes it adds an `InvokeCommand(NULL,
  'facetsRangeInputFilter', [$payload])` where `$payload` = `minimum`, `maximum` (from `$form_state->getValue()`),
  `facetId`. Otherwise it adds an `HtmlCommand('#validationContainer', 'Please enter a valid range')`.

## JS: `js/range-input.js`

- `Drupal.behaviors.rangeInput` iterates `settings.facets.rangeInput` and calls `Drupal.facets.rangeInput()`.
- `Drupal.facets.rangeInput(facet, settings)` binds `load keyup keypress change` on the two inputs; per keystroke
  it reads `$(this).val().trim().replace(/\$/g,'')` and, unless it is numeric and `>= 0`, shows an inline
  "Please enter a positive number." message (a **static translated string**, not the entered value) and marks the
  field. It re-populates the inputs from `settings.currentValues[inputId]` only after an `$.isNumeric` check
  (values set via jQuery `.val()`, not `.html()`).
- `$.fn.facetsRangeInputFilter(validatedData)` reads the base URL from
  `drupalSettings.facets.rangeInput[validatedData.facetId].url` and does
  `.replace('__range_input_min__', validatedData.minimum).replace('__range_input_max__', validatedData.maximum)`,
  then `$widget.trigger('facets_filter', [href])` to let Facets core perform the AJAX refresh. The URL is the
  facet's own generated URL with only the numeric bounds substituted into the placeholder tokens.

## Templates (registered by `hook_theme`)

`src/Hook/ThemeHooks.php` (autowired service, `#[Hook('theme')]`; `.module` has a `#[LegacyHook]`
`facets_range_input_theme()` wrapper) registers:

- `facets_range_input` → `templates/facets-range-input.html.twig` (render element `widget`): outputs
  `{{ widget.type }}` into a wrapper class and `{{ widget.form }}` — both via Twig auto-escaping.
- `facets_range_input_form` → `templates/facets-range-input-form.html.twig` (render element `form`): just
  `{{ form }}` (the render array, escaped by the render pipeline).

The `.module` also contains a stray unused `buildWidgitForm()` function (dead code, not wired to any hook).

## Library

`facets_range_input/rangeInput` (`.libraries.yml`): `css/range-input.css` (layout) + `js/range-input.js`.
Attached by `RangeInputWidget::build()`.
