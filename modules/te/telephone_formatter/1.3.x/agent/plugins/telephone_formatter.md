<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The telephone_formatter plugin + formatter service

## Field formatter plugin

`Drupal\telephone_formatter\Plugin\Field\FieldFormatter\TelephoneFormatter`

```php
@FieldFormatter(
  id = "telephone_formatter",
  label = @Translation("Formatted telephone"),
  field_types = { "telephone" }
)
```

- Extends core `FormatterBase`, implements `ContainerFactoryPluginInterface`.
- Injected: `telephone_formatter.formatter` (the service below) and core `country_manager`
  (to populate the Default country select).
- `defaultSettings()`: `format = 1` (International), `link = TRUE`, `default_country = NULL`.
- `viewElements()` renders each item: if `link` is on → a `tel:` link (title = formatted
  number, url = `Url::fromUri($service->format($value, RFC3966, $default_country))`); else the
  formatted number as inline text. Any `\Exception` while formatting falls back to the raw
  value.
- `availableFormats()`: `0 => E164`, `1 => International`, `2 => National`, `3 => RFC3966`
  (the libphonenumber `PhoneNumberFormat` constants).

The module defines **no** plugin *type* of its own — it only provides this one formatter
plugin for core's `telephone` field type.

## Reusable service `telephone_formatter.formatter`

`Drupal\telephone_formatter\Formatter` (interface `FormatterInterface`), declared in
`telephone_formatter.services.yml` with the `@language_manager` argument. Call it from custom
code to reformat any phone string:

```php
$formatter = \Drupal::service('telephone_formatter.formatter');
// format($input, $format, $region = NULL)
$intl = $formatter->format('+12025550136', \libphonenumber\PhoneNumberFormat::INTERNATIONAL);
// "+1 202-555-0136"
$uri  = $formatter->format('+12025550136', \libphonenumber\PhoneNumberFormat::RFC3966);
// "tel:+1-202-555-0136"  — ready for Url::fromUri()
```

- `$format` is a libphonenumber `PhoneNumberFormat` constant (int 0–3).
- `$region` is an ISO country code used when `$input` is a national/local number.
- Internally uses `PhoneNumberUtil::getInstance()`; **throws
  `\InvalidArgumentException`** if the parsed number is invalid — callers should catch it
  (the formatter plugin does, falling back to the raw value).
