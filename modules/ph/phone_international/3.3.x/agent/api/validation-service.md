# International Phone — validation service & form element

## Service `phone_international.validate`

Class `Drupal\phone_international\Helpers\ValidatingService` (interface `IsValidInterface`),
a thin wrapper over libphonenumber's `PhoneNumberUtil`.

| Method | Returns | Behavior |
|---|---|---|
| `isValidNumber(string $number)` | bool | Parses `$number`; TRUE only if libphonenumber says it is a valid number. Parse failures return FALSE (logged at debug). |
| `formatNumber(string $number)` | string | Parses and reformats to **E.164** (`PhoneNumberFormat::E164`). On parse failure logs an error and returns the input unchanged. |

Usage:

```php
$svc = \Drupal::service('phone_international.validate');
$ok  = $svc->isValidNumber('+351912345678');   // true
$e164 = $svc->formatNumber('00351 912 345 678'); // '+351912345678'
```

The field type's `preSave()` calls `formatNumber()`; the form element's validate handler
calls `isValidNumber()` and sets a form error on invalid input.

## Form/render element `phone_international`

`Drupal\phone_international\Element\PhoneInternationalElement` (`@FormElement("phone_international")`)
— the intl-tel-input control, reusable outside fields:

```php
$form['phone'] = [
  '#type' => 'phone_international',
  '#title' => $this->t('International Phone'),
  '#attributes' => [
    'data-country' => 'PT',   // initial country
    'data-geo' => 0,          // 0 disable / 1 enable geolocation
    'data-exclude' => [],
    'data-only' => [],        // include-only list
    'data-preferred' => ['PT'],
  ],
];
```

Its value callback reads the hidden `full_number` produced by the JS; validation runs the
value through `phone_international.validate`.

## Feeds

Ships a Feeds target (`Drupal\phone_international\Feeds\Target\PhoneInternational`) so phone
values can be mapped during Feeds imports.
