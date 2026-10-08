# Programmatic API — the Validator service

Service id `telephone_validation.validator` → `Drupal\telephone_validation\Validator`
(also autowirable by class name; constructor takes `@country_manager`). It wraps
libphonenumber's `PhoneNumberUtil`.

## Validate a number

```php
use libphonenumber\PhoneNumberFormat;

/** @var \Drupal\telephone_validation\Validator $validator */
$validator = \Drupal::service('telephone_validation.validator');

// E164 — country auto-detected from the +code; $country is an allow-list (empty = any).
$ok = $validator->isValid('+14155552671', PhoneNumberFormat::E164, []);         // true
$ok = $validator->isValid('+14155552671', PhoneNumberFormat::E164, ['US']);     // true
$ok = $validator->isValid('+14155552671', PhoneNumberFormat::E164, ['GB']);     // false

// National — first country in the array supplies the default region (required).
$ok = $validator->isValid('(415) 555-2671', PhoneNumberFormat::NATIONAL, ['US']); // true
```

`isValid(string $value, int $format, array $country = []): bool`:
1. Parses `$value` with `PhoneNumberUtil::parse()` — for National format the default region is
   `reset($country)`, for E164 it is `NULL`. A parse exception ⇒ `false`.
2. Returns `false` unless `isValidNumber()` passes.
3. If `$country` is non-empty, returns `false` unless the number's
   `getRegionCodeForNumber()` is in `$country` (always enforced for National).

`PhoneNumberFormat` constants (from the library): `E164 = 0`, `NATIONAL = 2`. The module's UI
only offers these two.

## Country list for select widgets

```php
$options = $validator->getCountryList();   // ['US' => 'United States - +1', 'GB' => 'United Kingdom - +44', ...]
```

Returns countries (from core `country_manager`) that have libphonenumber metadata, each
labeled `"<name> - +<calling code>"`, ready for a `#type => select` `#options`.

## Validate a bespoke `tel` element

Attach the module's element validator instead of calling the service directly:

```php
use libphonenumber\PhoneNumberFormat;

$form['phone'] = [
  '#type' => 'tel',
  '#title' => t('Phone'),
  '#element_validate' => [['Drupal\telephone_validation\Render\Element\TelephoneValidation', 'validateTel']],
  '#element_validate_settings' => [
    'format' => PhoneNumberFormat::E164,   // omit to inherit telephone_validation.settings
    'country' => [],
  ],
];
```

`TelephoneValidation::validateTel()` (in `src/Render/Element/`, extends core `Tel`) skips
empty values and calls `isValid()`, setting a form error on failure. Public properties
`$validator->phoneUtils` (the `PhoneNumberUtil` instance) and `$validator->countryManager` are
exposed if you need lower-level libphonenumber access.
