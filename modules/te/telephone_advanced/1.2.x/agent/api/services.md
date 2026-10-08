# Services & helper classes

Three stateless services wrap `giggsey/libphonenumber-for-php` (`PhoneNumberUtil`). Reusable
from any module — no external HTTP; all lookups are local to the bundled metadata.

| Service id | Class / interface | Purpose |
|---|---|---|
| `telephone_advanced.telephone_parser` | `TelephoneParser` : `TelephoneParserInterface` | Parse a string to a `\libphonenumber\PhoneNumber`; detect region & line type. Results cached per `country|number` key in-request. |
| `telephone_advanced.telephone_validator` | `TelephoneValidator` : `TelephoneValidatorInterface` | Validity, country and type checks. Depends on the parser. |
| `telephone_advanced.telephone_formatter` | `TelephoneFormatter` : `TelephoneFormatterInterface` | Format a number to a target format. Depends on the parser. |

## Method signatures

```php
// TelephoneParserInterface
parse(string $number, ?string $default_country = NULL): \libphonenumber\PhoneNumber; // throws NumberParseException
getCountry(PhoneNumber|string $number, ?string $default_country = NULL): ?string;     // ISO region, NULL on parse failure
getType(PhoneNumber|string $number, ?string $default_country = NULL): ?int;           // line-type id, NULL if UNKNOWN/parse failure

// TelephoneValidatorInterface
isValid(string $number, ?string $default_country = NULL): bool;                        // TRUE unless parse throws
isFromCountry(PhoneNumber|string $number, array|string $country, ?string $default_country = NULL): bool;
isOfType(PhoneNumber|string $number, PhoneNumberType|int|array $type, bool $strict = FALSE, ?string $default_country = NULL): bool;

// TelephoneFormatterInterface
format(PhoneNumber|string $number, PhoneNumberFormat|int $format, ?string $default_country = NULL): string;
```

`isValid()` only checks that the number *parses* (libphonenumber `parse()`), not that it is
"possible/valid" per libphonenumber's stricter `isValidNumber()`. `isOfType()` with
`$strict = FALSE` additionally matches `FIXED_LINE_OR_MOBILE` when `FIXED_LINE` or `MOBILE`
is requested.

### Example

```php
$validator = \Drupal::service('telephone_advanced.telephone_validator');
$formatter = \Drupal::service('telephone_advanced.telephone_formatter');

if ($validator->isValid('0470123456', 'BE')) {
  $e164 = $formatter->format('0470123456', \libphonenumber\PhoneNumberFormat::E164, 'BE'); // "+32470123456"
}
```

## Format helper — `TelephoneFormats`

Static: `getLabels()`, `getId($format)`, `getLabel($format)`. `getId()` returns the
libphonenumber `PhoneNumberFormat` enum's int value (used as config/setting keys):

| Format | Id |
|---|---|
| E164 | 0 |
| International | 1 |
| National | 2 |
| RFC 3966 | 3 |

## Line-type helper — `TelephoneTypes`

Static: `getLabels()`, `getId($type)`, `getLabel($type)`. `getId()` returns the
`\libphonenumber\PhoneNumberType` enum int value (what `allowed_types` stores). Labelled
types offered by the module: Fixed line, Mobile, Pager, VOIP, Personal number, UAN,
Toll free, Standard rate, Shared cost, Premium rate, Voicemail, Short code, Emergency.
(`UNKNOWN` maps to NULL. In non-strict checks `FIXED_LINE_OR_MOBILE` is treated as a match
for fixed-line and mobile.)

Use the enum case rather than a hardcoded number: `PhoneNumberType::MOBILE->value` on 9.x,
or the `PhoneNumberType::MOBILE` int constant on 8.12.x.
