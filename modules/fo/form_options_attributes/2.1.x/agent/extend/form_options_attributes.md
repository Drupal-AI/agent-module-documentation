<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works under the hood + label/wrapper attributes + theming

Everything lives in `form_options_attributes.module` (no classes/services). Two different
mechanisms handle select vs. radios/checkboxes.

## select — theme suggestion + custom template

- `hook_theme()` registers `select__form_options_attributes` with `base hook => select`.
- `hook_theme_suggestions_select_alter()` adds that suggestion **only when the element has a
  non-empty `#options_attributes`**, so untouched selects use core's template.
- `form_options_attributes_preprocess_select__form_options_attributes()` builds an
  `options_attributes` variable (a `\Drupal\Core\Template\Attribute` per option, including
  nested optgroup options) that the template prints inside each `<option>`.
- Template: `templates/select--form-options-attributes.html.twig` — a copy of core's select
  template that appends `{{ options_attributes[option.value] }}` (and the optgroup-nested
  form) to each `<option>`.

To customize the markup, override `select--form-options-attributes.html.twig` in your theme
(the suggestion is already registered; just provide the Twig file).

## radios / checkboxes — a `#process` callback

- `hook_element_info_alter()` appends `form_options_attributes_form_process_option_attributes`
  to the `#process` chain of the `checkboxes` and `radios` element types.
- After core expands the group into child `radio`/`checkbox` elements, this callback maps three
  custom properties onto each child's real render-API attribute arrays:

  | custom property (keyed by option) | copied onto child element |
  |---|---|
  | `#options_attributes` | `#attributes` (the `<input>`) |
  | `#options_wrapper_attributes` | `#wrapper_attributes` (the option's wrapper `<div>`) |
  | `#options_label_attributes` | `#label_attributes` (the option's `<label>`) |

  If the child already has attributes of that type, the two arrays are `array_merge`d.

### Wrapper / label example (radios or checkboxes only)

```php
$form['plan'] = [
  '#type' => 'radios',
  '#options' => ['free' => $this->t('Free'), 'gold' => $this->t('Gold')],
  '#options_attributes'        => ['gold' => ['data-tier' => 'gold']],   // the <input>
  '#options_wrapper_attributes'=> ['gold' => ['class' => ['row-gold']]], // the wrapper <div>
  '#options_label_attributes'  => ['gold' => ['class' => ['label-gold']]], // the <label>
];
```

`#options_wrapper_attributes` and `#options_label_attributes` have **no meaning for select**
(a select has no per-option wrapper or label — only the `<option>` itself), so only
`#options_attributes` applies there.

## Rendering it yourself (useful for tests)

A `select` element renders fully in isolation, which is how the eval verifies the property:

```php
$html = (string) \Drupal::service('renderer')->renderInIsolation($build);
```

`radios`/`checkboxes` need full form processing (their `#process` chain and child expansion
run during form building), so they do not render cleanly via `renderInIsolation` on a bare
element — exercise them through an actual form build.
