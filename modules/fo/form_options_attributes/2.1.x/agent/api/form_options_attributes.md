<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `#options_attributes` render-array property

This module adds no services or PHP functions to call; its entire public API is a set of
**render-array properties** you add to a form element. Enable the module (`drush en
form_options_attributes -y`) and use them in any custom form's `buildForm()`, in a render
array, or from `hook_form_alter()`.

## `#options_attributes` — attributes per option

- Add it alongside `#options` on a `#type` of `select`, `radios`, or `checkboxes`.
- Its **keys must match the keys of `#options`**.
- Each **value is an attributes array**, formatted exactly like the element's `#attributes`
  (e.g. `['class' => ['foo'], 'data-x' => 'y']`). It becomes a `\Drupal\Core\Template\Attribute`.
- Any option key you omit simply gets no extra attributes.

### Select example

```php
$form['color'] = [
  '#type' => 'select',
  '#title' => $this->t('Color'),
  '#options' => ['r' => $this->t('Red'), 'g' => $this->t('Green')],
  '#options_attributes' => [
    'r' => ['class' => ['opt-red'], 'data-hex' => 'ff0000'],
    'g' => ['data-hex' => '00ff00'],
  ],
];
```

Renders (option-level attributes injected):

```html
<option value="r" class="opt-red" data-hex="ff0000">Red</option>
<option value="g" data-hex="00ff00">Green</option>
```

### Optgroups — keys nest one level deeper

When `#options` is grouped, mirror the nesting: `#options_attributes[group_label][option_key]`.

```php
'#options' => [
  'German'   => ['audi' => 'Audi', 'bmw' => 'BMW'],
  'Japanese' => ['honda' => 'Honda'],
],
'#options_attributes' => [
  'German' => ['bmw' => ['data-lux' => 'yes']],
],
```

### Radios / checkboxes example

```php
$form['plan'] = [
  '#type' => 'radios',            // or 'checkboxes'
  '#title' => $this->t('Plan'),
  '#options' => ['free' => $this->t('Free'), 'gold' => $this->t('Gold')],
  '#options_attributes' => [
    'gold' => ['class' => ['is-premium'], 'data-tier' => 'gold'],
  ],
];
```

For radios/checkboxes the attributes land on the individual `<input>` (its `#attributes`).

## Applying it to someone else's form

You do not need to own the form. In `hook_form_alter()` (or `hook_form_FORM_ID_alter()`):

```php
function mymodule_form_alter(&$form, $form_state, $form_id) {
  if (isset($form['field_country'])) {
    $form['field_country']['widget']['#options_attributes']['US'] = ['data-flag' => '🇺🇸'];
  }
}
```

## Notes / gotchas

- The property is read at render/process time; there is no validation that keys exist in
  `#options` — a stray key is silently ignored.
- No effect on submitted values; it is purely presentational markup on the options.
- `#options_wrapper_attributes` and `#options_label_attributes` (radios/checkboxes only) are
  covered in [../extend/form_options_attributes.md](../extend/form_options_attributes.md).
