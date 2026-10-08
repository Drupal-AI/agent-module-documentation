<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Phone Number — the `phone_number.util` service

Service id **`phone_number.util`**, interface `Drupal\phone_number\PhoneNumberUtilInterface`
(class `PhoneNumberUtil`). Wraps `giggsey/libphonenumber-for-php`. Constructor args:
`@config.factory`, `@entity_field.manager`, `@module_handler`, `@country_manager`.

```php
/** @var \Drupal\phone_number\PhoneNumberUtilInterface $util */
$util = \Drupal::service('phone_number.util');
```

## Methods

- `libUtil()` — the underlying `\libphonenumber\PhoneNumberUtil` instance.
- `getPhoneNumber($number, $country = NULL, $extension = NULL)` → `\libphonenumber\PhoneNumber|null`.
- `testPhoneNumber($number, $country = NULL, $extension = NULL, $types = NULL)` — validate;
  throws `CountryException` / `ParseException` / `TypeException` (in
  `Drupal\phone_number\Exception`) on invalid input; returns the parsed PhoneNumber.
- `getCountry(PhoneNumber $n)` / `getCountryName($country)` / `getCountryCode($country)` —
  country helpers (e.g. `getCountryCode('IL')` → `972`).
- `getCallableNumber(PhoneNumber $n, $strip_non_digits = FALSE)` — E.164 international number.
- `getRfc3966Uri(PhoneNumber $n, $strip_extension = FALSE)` — RFC3966 `tel:` URI.
- `getNationalNumber(...)` / `getLocalNumber(...)` / `getNationalDialingPrefix(...)` — national
  / local formatting.
- `getCountryOptions(?array $filter = NULL, $show_country_names = FALSE)` — options array keyed
  by ISO code (e.g. `['IL' => 'IL (+972)']`); handy for building custom selects.
- `getTypeOptions()` — supported phone-number types keyed by `\libphonenumber\PhoneNumberType`
  constants.

## Constants

`PhoneNumberUtilInterface::PHONE_NUMBER_UNIQUE_NO` (0) / `PHONE_NUMBER_UNIQUE_YES` (1) — the
storage `unique` setting values.

## Typical use

```php
try {
  $n = $util->testPhoneNumber('+14155550123');   // validate
  $e164 = $util->getCallableNumber($n);           // +14155550123
  $tel  = $util->getRfc3966Uri($n);               // tel:+1-415-555-0123
}
catch (\Drupal\phone_number\Exception\PhoneNumberException $e) {
  // invalid
}
```
