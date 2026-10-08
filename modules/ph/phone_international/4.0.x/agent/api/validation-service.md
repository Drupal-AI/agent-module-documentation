# International Phone — validation service & form element

## Service `phone_international.validate`

Class `Drupal\phone_international\Helpers\PhoneNumberValidatingService` (interface
`PhoneNumberInterface`), a thin wrapper over libphonenumber's `PhoneNumberUtil`. Autowired
(injects the logger channel factory).

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

The field type's `preSave()` calls `formatNumber()`; the form element's validate handler and
the `phone_international_formatter` both call `isValidNumber()`.

## Form/render element `phone_international`

`Drupal\phone_international\Element\PhoneInternationalElement` (`@FormElement("phone_international")`),
extends core `Tel` — the intl-tel-input control, reusable outside fields. Properties (with
defaults): `#country` (`''`), `#geolocation` (`0`), `#exclude_countries` (`[]`), `#countries`
(`'exclude'`), `#preferred_countries` (`[]`), `#dial_code` (`0`), `#auto_placeholder`
(`'aggressive'`), `#national_number` (`1`).

```php
$form['phone'] = [
  '#type' => 'phone_international',
  '#title' => $this->t('International Phone'),
  '#country' => 'PT',              // initial country
  '#geolocation' => 0,             // 0 disable / 1 enable geolocation
  '#countries' => 'include',       // all | exclude | include
  '#exclude_countries' => ['PT', 'GB'],  // include-only or exclude list
  '#preferred_countries' => ['PT'],
  '#dial_code' => 0,
  '#national_number' => 1,
  '#auto_placeholder' => 'aggressive',
];
```

The `preRenderPhoneInternational` callback attaches the `phone_international/phone_international`
library and emits `data-country`, `data-geo`, `data-preferred`, `data-dial-code`,
`data-auto-placeholder`, `data-national-number`, and `data-only`/`data-exclude` attributes read
by `js/phone_international.js`. The JS binds `intlTelInput`, geolocates via `ipinfo.io` when
enabled, and writes the full E.164 number back into the input on keyup. `validateNumber()` runs
the value through `phone_international.validate` and sets a form error on invalid input.

## Feeds

Ships a Feeds target (`Drupal\phone_international\Feeds\Target\PhoneInternational`, id
`phone_international`) exposing the `value` property so phone values can be mapped during Feeds
imports. Requires the `feeds` module (dev/optional dependency).
