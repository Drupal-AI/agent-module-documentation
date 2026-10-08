<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# a11y_autocomplete: render element, widget & library

## Install / enable
1. `drush en a11y_autocomplete_element` (pulls core `options`).
2. Install the `@drupal/autocomplete` JS library one of three ways (checked in this order by
   `_a11y_autocomplete_element_find_library()` in `.install`):
   - git clone / manual extract to `DRUPAL_ROOT/libraries/a11y_autocomplete/src/a11y.autocomplete.js`
   - asset-packagist → `DRUPAL_ROOT/libraries/drupal--autocomplete/dist/a11y.autocomplete.min.js`
   - `npm i -S @drupal/autocomplete` above the Drupal root →
     `<drupal-root>/../node_modules/@drupal/autocomplete/dist/a11y.autocomplete.min.js`. When found here
     the file (and its CSS) is **copied into `public://a11y_autocomplete`** so AdvAgg / no-aggregation
     setups can serve it; a `hash('sha256')` + `hash_equals()` check re-copies only when it changed.
3. Check the status report — `hook_requirements()` reports OK with the found path, or ERROR if missing.
   If the `foxy` module is enabled, `hook_requirements()` returns early (foxy manages the asset) and the
   `.foxy.yml` library definition (serving `js/a11y-autocomplete.mjs`) is used instead.

## Render element (`#type => 'a11y_autocomplete'`)
`src/Element/A11yAutocomplete.php` — `final class A11yAutocomplete extends \Drupal\Core\Render\Element\Select`,
annotated `@FormElement("a11y_autocomplete")`. Drop-in for `#type => 'select'`; **every `#select` key works**
(`#options`, `#multiple`, `#required`, `#default_value`, `#empty_option`, etc.).

- `getInfo()` calls `parent::getInfo()` then appends `processA11yAutocomplete` to `#process`.
- `processA11yAutocomplete()` attaches library `a11y_autocomplete_element/a11y_autocomplete_element`
  and sets `#attributes['data-a11y-autocomplete-element'] = TRUE` (the JS hook). Nothing else — value
  handling, `#options` validation and `#required` checks are 100% inherited from core `Select`.

Example:
```php
$form['color'] = [
  '#type' => 'a11y_autocomplete',
  '#title' => $this->t('Color'),
  '#options' => ['r' => 'Red', 'g' => 'Green'],
  '#multiple' => TRUE,
];
```

## Field widget (`id="a11y_autocomplete"`, label "Accessible autocomplete")
`src/Plugin/Field/FieldWidget/A11yAutocompleteWidget.php` — `extends OptionsSelectWidget`,
`multiple_values = TRUE`. Applicable field types: `entity_reference`, `list_integer`, `list_float`,
`list_string`. `formElement()` calls the parent then overrides `#type` to `a11y_autocomplete`.
Because it inherits `OptionsSelectWidget`, the option list (including entity-reference **access filtering
and allowed values**) is produced by core; the widget only swaps the element type. Enable it per field
under *Manage form display*. Config schema `field.widget.settings.a11y_autocomplete` simply extends
`field.widget.settings.options_select`, so it has no extra settings of its own.

## Libraries
- `a11y_autocomplete_element.libraries.yml` → library `a11y_autocomplete_element`: `js/a11y-autocomplete.js`
  + `css/a11y_autocomplete_element.css`, depending on the dynamically-built `a11y_autocomplete_library`.
- `hook_library_info_build()` (`.module`) builds `a11y_autocomplete_library` at runtime from the resolved
  library path (JS + sibling `a11y.autocomplete.css`); returns `[]` on failure.

## Client-side behaviour (`js/a11y-autocomplete.js`)
Runs via `once()` on elements matching the data attribute. For each hidden `<select>` it inserts a text
`<input>`, hides the select with `visually-hidden`, builds an in-memory `items` list from the element's
own `<option>`s (label/value), and filters that list as the user types. Multi-value selects get a
`.a11y-autocomplete__selected-items` pill container with removable tokens; `#required` is recomputed as
selections change. All data comes from the server-rendered options — there is **no fetch/XHR/AJAX**, so
the option set a user can see or pick is exactly what core already rendered for them.

## Notes for agents
- No routes, controllers, permissions, services or settings form exist — do not look for an autocomplete
  results endpoint; matching is client-side over pre-rendered options.
- To theme, target `.a11y-autocomplete__*` classes (see `css/a11y_autocomplete_element.css`).
