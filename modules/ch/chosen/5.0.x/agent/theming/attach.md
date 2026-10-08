# How Chosen attaches

Chosen is applied by render/form alter hooks in `chosen.module`, not by manual per-field markup:

- `hook_element_info_alter()` adds a `#chosen` property / pre-render to `select` elements.
- `hook_field_widget_single_element_form_alter()` opts field select widgets in.
- `chosen_attach_library()` attaches the JS library and the setting values (via
  `drupalSettings`) to a given render element; `chosen_element_apply_property_recursive()`
  walks nested elements.

Force Chosen on or off for a specific element in code by setting `$element['#chosen'] = TRUE`
(or `FALSE`).

## Libraries (`chosen.libraries.yml`)
| Library | Use |
|---|---|
| `chosen/drupal.chosen` | Core Chosen JS + `chosen-drupal.css`; depends on `chosen_lib/chosen`. |
| `chosen/drupal.chosen.all` | Chosen plus base CSS from `chosen_lib`. |
| `chosen/chosen.claro`, `chosen/chosen.gin` | Theme-matching CSS for Claro / Gin. |
| `chosen/chosen.bef` | Integration JS for Better Exposed Filters selects. |

The Chosen library assets themselves are provided by the **chosen_lib** submodule (definition
`chosen_lib/chosen`, version 3.1.3 = `noli42/chosen`).
