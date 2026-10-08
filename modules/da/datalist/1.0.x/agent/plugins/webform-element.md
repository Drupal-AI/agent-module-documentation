# Webform element `webform_datalist`

Class `Drupal\datalist\Plugin\WebformElement\Datalist` (`src/Plugin/WebformElement/Datalist.php`),
declared `@WebformElement(id = "webform_datalist", label = "Datalist", category = "Options elements")`,
extends `Drupal\webform\Plugin\WebformElementBase`. It exposes the `datalist` render element as a Webform
element so it can be added through the Webform build UI.

**Requires the Webform module** (`drupal/webform`). Webform is a `require-dev` dependency in
`composer.json` (not a hard `dependencies:` entry in `datalist.info.yml`), so this plugin is only
discovered/usable when Webform is installed. Without Webform, the module still provides the `datalist`
render element (see `../api/render-element.md`); this plugin is simply inactive.

## What it does

- `prepare()` sets `$element['#type'] = 'datalist'`, delegating rendering to the render element.
- `defineDefaultProperties()` sets the Webform-configurable defaults: `multiple`, `size`, `minlength`,
  `maxlength`, `placeholder`, `options` (`[]`), `use_keys` (`FALSE`), `clear_button` (`✖`),
  `down_button` (`▼`), `clear_button_description` (`Clear field`), `autocomplete_route_name` (`''`),
  `autocomplete_route_parameters` (`''`) — plus the inherited `WebformElementBase` defaults.
- `form()` adds a **"Datalist options"** fieldset to the element's configuration form with these fields:

| Config field | Type | Notes |
|---|---|---|
| `options` | `webform_element_options` | Required. The `key => label` suggestion list. |
| `down_button` | textfield | Default `▼`. |
| `clear_button` | textfield | Default `✖`. |
| `clear_button_description` | textfield | Default `Clear field` (accessible label). |
| `use_keys` | checkbox | When on, the key (not the label) is shown to the user. |
| `autocomplete_route_name` | textfield | Route for the mobile-browser fallback autocomplete. |
| `autocomplete_route_parameters` | textfield | Entered as `key:value`, comma-separated. |

These map directly onto the render element's `#`-properties documented in `../api/render-element.md`.

## Add it in code

```php
// In a webform's elements YAML / via the Webform API:
my_field:
  '#type': webform_datalist
  '#title': 'Fruit'
  '#options':
    ap: Apple
    ba: Banana
  '#use_keys': false
```

Note the category is **"Options elements"**, so it appears alongside select/checkboxes in the Webform
add-element dialog.
