# Bynder Select2 element & widget

## Form element — `bynder_select2_simple_element`

`src/Element/BynderSelect2SimpleElement.php`, `@FormElement`, extends core `Select`. Its `#process`
(`processBynderSelect2`) runs the normal select processing then:

- Generates a unique class `bynder-select2-<md5>` and adds it to `#attributes[class]`.
- Emits `drupalSettings.bynder_select2[<class>]` with `selector`, `placeholder_text`, `multiple`
  (from `#multiple`), and `base_url`.
- If `#loadRemoteData` is set, adds `loadRemoteData.url = base_url . #loadRemoteData` so the select is
  populated via AJAX from that endpoint.
- Attaches library `bynder_select2/bynder_select2.widget`.

Use in a custom form:

```php
$form['tags'] = [
  '#type' => 'bynder_select2_simple_element',
  '#title' => $this->t('Tags'),
  '#multiple' => TRUE,
  '#placeholder_text' => $this->t('Choose tags'),
  '#options' => $options,
  // Optional: populate from an endpoint (relative path appended to base URL).
  '#loadRemoteData' => '/bynder/tags/search',
];
```

## Field widget — `bynder_select2_simple_widget`

`src/Plugin/Field/FieldWidget/BynderSelect2SimpleWidget.php`, `@FieldWidget`, extends
`OptionsSelectWidget`, `field_types = {list_string, list_integer}`, `multiple_values = TRUE`. In
`formElement()` it builds the base options select, switches `#type` to `bynder_select2_simple_element`,
strips the `_none` option, computes the unique class, and attaches per-instance `drupalSettings`
(`selector`, `field_name`, `settings`, `placeholder_text`) plus the widget library. Select it on *Manage
form display* for a list field.

## Library / JS

`bynder_select2.libraries.yml`:
- `bynder_select2` → Select2 4.0.3 from `/libraries/select2/dist/js/select2.min.js` + CSS (self-hosted;
  the library files must exist under the site `libraries/` directory).
- `bynder_select2.widget` → `js/bynder_select2.js` + `css/bynder_select2.css`, depends on `bynder_select2`.

`js/bynder_select2.js` reads each `drupalSettings.bynder_select2` entry and initialises Select2 on the
element matching `selector`, wiring remote data when `loadRemoteData` is present.
