<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reuse `TextFieldCounterWidgetTrait`

`Drupal\textfield_counter\Plugin\Field\FieldWidget\TextFieldCounterWidgetTrait` holds the
shared logic behind the five bundled widgets. `use` it in your own `WidgetBase` subclass to add
a counter to a field type the module doesn't cover (or a contrib field type).

## Settings-form builders (call from your `settingsForm()`)
- `addMaxlengthSettingsFormElement(&$form, $includeDefaultSettings = FALSE)` — the `maxlength`
  number element; pass TRUE to also add the `use_field_maxlength` checkbox (textfield-style).
- `addCounterPositionSettingsFormElement(&$form, $storageSettingMaxlengthField = FALSE)` —
  `before`/`after` select.
- `addCountOnlyModeSettingsFormElement(&$form)` — the "count only mode" checkbox.
- `addJsPreventSubmitSettingsFormElement(&$form, $storageSettingMaxlengthField = FALSE)`.
- `addCountHtmlSettingsFormElement(&$form, $storageSettingMaxlengthField = FALSE)`.
- `addTextCountStatusMessageSettingsFormElement(&$form, $storageSettingMaxlengthField = FALSE)`.

## Summary builders (call from your `settingsSummary()`)
`addMaxlengthSummary(&$summary)`, `addPositionSummary(&$summary)`,
`addJsSubmitPreventSummary(&$summary)`, `addCountOnlyModeSummary(&$summary)`,
`addCountHtmlSummary(&$summary)`, `addTextCountStatusMessageSummary(&$summary)`.

## Wiring the counter onto the element (call from `formElement()`)
```php
$this->fieldFormElement($element, $entity, $fieldDefinition, $delta, $summary = FALSE);
```
This attaches the `textfield_counter/counter` library and the per-element
`drupalSettings['textfieldCounter'][$key]` payload (`maxlength`, `counterPosition`,
`textCountStatusMessage`, `countHTMLCharacters`, and `preventSubmit` when applicable). It also
adds the `textfield-counter-element` class and a unique per-delta key class the JS binds to.

## Server-side validation
```php
// register as an #element_validate callback, then:
public static function validateFieldFormElement(array $element, FormStateInterface $form_state, $maxlength)
```
Sets a form error when the value length exceeds `$element['#textfield-maxlength']`. It reads
`$element['#textfield-count-html']` to decide whether tags/`&nbsp;` are stripped before counting
(via the protected `getLengthOfSubmittedValue()`).

## Defaults helper
`TextFieldCounterWidgetTrait::getDefaultTextCountStatusMessage()` returns the default span-wrapped
message string — merge it into your widget's `defaultSettings()` alongside `maxlength`,
`counter_position`, `js_prevent_submit`, `count_only_mode`, `count_html_characters`.

The module exposes **no `*.api.php` and no services** — this trait is the only intended
extension surface.
