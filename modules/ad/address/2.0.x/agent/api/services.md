# Address services & helpers

Programmatic access to the commerceguys/addressing data. Services from
`address.services.yml`:

```php
// Address format (field layout, required fields, labels) for a country.
$fmt = \Drupal::service('address.address_format_repository')->get('US');
// AddressFormatRepositoryInterface: get($countryCode), getAll(), getList()

// Countries: names, codes, list keyed by code (locale-aware, cached).
$countries = \Drupal::service('address.country_repository')->getList(); // ['US' => 'United States', ...]
$country   = \Drupal::service('address.country_repository')->get('FR');  // Country object

// Subdivisions (states/provinces/cities) for a parent path.
$subs = \Drupal::service('address.subdivision_repository')->getList(['US']); // states of US

// Build a postal label string (uppercased, country name appended, etc.).
$label = \Drupal::service('address.postal_label_formatter')->format($address);
```

The repositories dispatch events so definitions can be altered — see
[../hooks/events.md](../hooks/events.md).

## Static helpers
- `Drupal\address\LabelHelper` — translated labels:
  `getFieldLabels(AddressFormat $f)`, `getGenericFieldLabels()`,
  `getAdministrativeAreaLabel($type)` / `getLocalityLabel()` /
  `getDependentLocalityLabel()` / `getPostalCodeLabel()` (each with a plural
  `...Labels()` map). Use these to render country-correct field labels
  (State vs Province, ZIP vs Postcode…).
- `Drupal\address\FieldHelper` — `getPropertyName($addressField)` maps a
  `CommerceGuys\Addressing\AddressFormat\AddressField` constant to the Drupal
  property name; `getAutocompleteAttribute($field)` returns the HTML autocomplete token.

The `AddressInterface` (implemented by the `address` field item) exposes getters
for every stored property (`getCountryCode()`, `getLocality()`, `getGivenName()`, …).
