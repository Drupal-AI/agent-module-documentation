<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `telephone_international` field widget

## What it is

A single field widget for **core's Telephone field type** (`telephone`). It does **not** add a
field type or formatter — you keep a normal Telephone field and only swap its form widget.

Plugin: `Drupal\telephone_international_widget\Plugin\Field\FieldWidget\TelephoneInternationalWidget`

```php
/**
 * @FieldWidget(
 *   id = "telephone_international",
 *   label = @Translation("International telephone"),
 *   field_types = { "telephone" }
 * )
 */
class TelephoneInternationalWidget extends TelephoneDefaultWidget { ... }
```

It subclasses `Drupal\telephone\Plugin\Field\FieldWidget\TelephoneDefaultWidget` and overrides
only `formElement()`. It renders a plain `textfield`:

- `#default_value` = the stored `$items[$delta]->value`.
- `#placeholder` = the `placeholder` widget setting.
- `#field_suffix` = a **static** HTML string:
  `<span class="valid-msg iti__hide">Valid</span><span class="error-msg iti__hide">error</span>`.
- adds CSS class `telephone_international_widget` to the input.
- attaches library `telephone_international_widget/intl-tel-input-widget`.

## Settings

There is **no `settingsForm()` override** in this module. The only setting is `placeholder`,
inherited unchanged from `TelephoneDefaultWidget` (default `''`, editable per field on *Manage
form display*). Config schema:

```yaml
# config/schema/telephone_internaltional_widget.schema.yml
field.widget.settings.telephone_international:
  type: field.widget.settings.telephone_default
  label: 'International telephone format settings'
```

i.e. it simply reuses core's `field.widget.settings.telephone_default` schema.

## Client-side behavior (`js/telephone_international_widget.js`)

A `Drupal.behaviors.telephone_international_widget` (guarded by `core/drupal.once`) runs on each
`.telephone_international_widget` input:

- `const iti = window.intlTelInput(input);` — **no options object is passed**, so intl-tel-input
  runs with its defaults: a flag/country dropdown, as-you-type country detection from the dial
  code, and **no geolocation / geoIpLookup** and no separately-fetched `utilsScript`.
- On load, if the input has a value, it is rewritten with `iti.getNumber()` (international form).
- On `blur`: if valid (`iti.isValidNumber()`), the value is normalized via `iti.getNumber()` and
  the "Valid" span is shown; if invalid, an `error` class is added and the `.error-msg` span is
  filled from a fixed 5-entry `errorMap` indexed by `iti.getValidationError()`.
- `change` and `keyup` reset the messages.

**All formatting and validation here is client-side only.** The stored value is whatever the
browser submitted; nothing in this module validates it server-side. If your logic depends on the
number's shape, revalidate on the server (e.g. add the `telephone_validation` module).

## Required JS/CSS library

Declared in `telephone_international_widget.libraries.yml`:

- `telephone_international_widget/intl-tel-input` → expects the library at
  `/libraries/intl-tel-input/build/js/intlTelInputWithUtils.js` and
  `/libraries/intl-tel-input/build/css/intlTelInput.css`. Version is **unpinned** (`VERSION`).
  The `WithUtils` build bundles libphonenumber utils, so validation works with no extra fetch.
- `telephone_international_widget/intl-tel-input-widget` → the module's own JS/CSS, depending on
  the library above plus `core/drupal.once`.

Install the library via Composer as a `drupal-library` (`jackocnr/intl-tel-input`) so it lands
under `/libraries/intl-tel-input/` (see the module README for the custom-repository snippet).
Without it, the input renders as a plain textfield with no dropdown or validation.

## Selecting the widget

UI: *Structure → Content types → (type) → Manage form display*, set the Telephone field's widget
to **International telephone**.

In code:

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_phone', 'entity_type' => 'node', 'type' => 'telephone',
])->save();
FieldConfig::create([
  'field_name' => 'field_phone', 'entity_type' => 'node', 'bundle' => 'article', 'label' => 'Phone',
])->save();

\Drupal::entityTypeManager()->getStorage('entity_form_display')
  ->load('node.article.default')
  ->setComponent('field_phone', [
    'type' => 'telephone_international',
    'settings' => ['placeholder' => '+1 202 555 0100'],
  ])
  ->save();
```

Display of the stored value is unchanged — use any core Telephone/String formatter on *Manage
display*.
