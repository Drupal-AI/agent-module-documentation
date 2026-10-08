<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap Toggle — boolean widget & formatter

Both plugins share id `bootstrap_toggle_switch` and `field_types = { "boolean" }`.

## Widget: `Drupal\bootstrap_toggle\Plugin\Field\FieldWidget\BootstrapToggle`

`formElement()` returns `['value' => $element]` where `$element` is:

```php
$element += [
  '#type' => 'checkbox',
  '#default_value' => $items[$delta]->value ?? FALSE,
  '#attributes' => ['data-toggle' => ['toggle']],
];
```

Then, from settings, it adds attributes: `data-on`, `data-off`, `data-size`
(large/normal/small/mini/''), `data-onstyle`, `data-offstyle`
(primary/success/info/warning/danger/default/''), and — only when the value `is_numeric` —
`data-height`, `data-width`. `display_label` 0 sets `#title` to the field label; 1 sets `#title = ''`.
Finally it flags the form: `$form_state->set('attached_toggle', TRUE)`, which is what makes
`hook_form_alter` attach the JS/CSS library. No custom validation or massaging — the stored value is
the plain checkbox 0/1.

### Enabling
Manage form display of a bundle with a boolean field → choose **Bootstrap Toggle** as the widget →
gear icon exposes the settings form (`settingsForm()`), summarised by `settingsSummary()`.

## Formatter: `Drupal\bootstrap_toggle\Plugin\Field\FieldFormatter\BootstrapToggleFormatter`

Extends core `BooleanFormatter`. In its constructor it instantiates the widget
(`new BootstrapToggle(...)`) and delegates `defaultSettings()`, `settingsForm()`,
`settingsSummary()` to it. `viewElements()` calls the widget's `formElement()` per item, unwraps
`['value']`, then forces read-only presentation by setting `#attributes['disabled'] = ['disabled']`
and `#attributes['checked'] = [$item->value ? 'checked' : '']`. Comment in source notes that on a
non-form (display) checkbox `#disabled`/`#default_value` are ignored, hence the direct `#attributes`
workaround. Library attachment on display relies on `$form['#attached']` being populated — note the
formatter passes an empty local `$form`, so on pure display contexts the library is attached via the
same `bootstrap_toggle/bootstrap_toggle` route only when a form on the page also triggers it; on a
plain view page ensure the library is present (this is a known rough edge of the display path).

## Attribute → library mapping
The `data-*` attributes are read by the Bootstrap Toggle library at init (`.bootstrapToggle()` in
`js/bootstrap_toggle_reattach.js`, a `Drupal.behaviors` attach). `data-on`/`data-off` become the
visible On/Off button text; `data-onstyle`/`data-offstyle` map to Bootstrap contextual button
classes; `data-size` maps to `btn-lg`/(normal)/`btn-sm`/`btn-xs`.
