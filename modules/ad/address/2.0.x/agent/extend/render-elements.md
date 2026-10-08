# Address render elements

The module registers standalone form render elements (in `src/Element/`) usable in
any custom form — they give you the dynamic, country-aware address widget without a
field.

## `#type => 'address'` (`Drupal\address\Element\Address`)
```php
$form['address'] = [
  '#type' => 'address',
  '#default_value' => [
    'given_name' => 'John', 'family_name' => 'Smith',
    'organization' => 'Google Inc.', 'address_line1' => '1098 Alta Ave',
    'postal_code' => '94043', 'locality' => 'Mountain View',
    'administrative_area' => 'CA', 'country_code' => 'US', 'langcode' => 'en',
  ],
  // Force properties hidden / optional / required, overriding the country format:
  '#field_overrides' => [
    // \CommerceGuys\Addressing\AddressFormat\AddressField::ORGANIZATION => 'required',
  ],
  '#available_countries' => ['US', 'CA'], // optional restriction
];
```
The element rebuilds its subfields (labels, required flags, subdivision dropdowns)
via AJAX when the country changes.

## Other elements
- `#type => 'address_country'` — a single country select.
- `#type => 'address_zone'` (`Zone`) and `address_zone_territory` (`ZoneTerritory`)
  — build/edit a geographic zone made of territory rules.

These elements are the building blocks reused by the `address_default` /
`address_zone_default` field widgets.
