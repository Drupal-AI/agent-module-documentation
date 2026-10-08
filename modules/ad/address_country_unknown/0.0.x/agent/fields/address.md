<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Address with empty/unknown country — field type override, widget, formatters, element

## Install & enable

```bash
composer require drupal/address_country_unknown
drush en address_country_unknown -y
drush cr
```

Requires the `address` module (`dependencies: address:address`). No config, no permissions, no
sub-modules. **Enabling alone already changes behaviour site-wide** (see the field-type swap below);
to actually get the empty-country UI you must also select the module's widget + formatter on a field.

## Enable it on a field

1. *Structure → (entity/bundle) → Manage form display* → set the Address field's widget to
   **"Address (with empty / unknown country)"** (`address_country_unknown_default`).
2. *Manage display* → set the same field's format to **"Default (with empty / unknown country)"**
   (`address_country_unknown_default`) or **"Plain (with empty / unknown country)"**
   (`address_country_unknown_plain`).

The widget and the formatter are a matched pair — using one without the other, or mixing with the
stock Address widget/formatter, produces errors/odd behaviour. The module warns against use with
Drupal Commerce.

## What each class does (from source)

### `hook_field_info_alter()` — `address_country_unknown.module`
Replaces `$info['address']['class']` with
`\Drupal\address_country_unknown\Plugin\Field\FieldType\AddressCountryUnknownItem`. This applies to
**all** address fields on the site, not just those using the module's widget. The maintainers note
the change is deliberately minimal for normal (country-set) addresses.

### `AddressCountryUnknownItem` (field type) — extends `address`'s `AddressItem`
- `isEmpty()`: parent returns empty when `country_code` is empty. Override: if parent says empty,
  it checks `administrative_area, locality, dependent_locality, postal_code, sorting_code,
  address_line1..3, organization, given_name, additional_name, family_name` — if any is non-empty
  the item is **not** empty (so partial/migrated data is kept, not wiped).
- `getConstraints()`: when `getCountryCode()` is empty, removes any `AddressFormatConstraint` and
  `CountryConstraint` so an empty-country value validates.

### `AddressCountryUnknown` (form element, `@FormElement("address_country_unknown")`) — extends Address `Address`
- Constant `FAKE_COUNTRY_CODE = 'NONE'` and `FAKE_ADDRESS_FORMAT_VALUES` — a generic
  `AddressFormat` (format string covering name/organization/address lines/postal code/locality/
  dependent locality/administrative area/sorting code; STATE / CITY / DISTRICT / POSTAL types).
  A non-empty code is required because `AddressFormat` rejects an empty country.
- `processAddress()`: calls parent, then if `country_code` is empty calls `addressElements()`
  itself (parent skips it for empty country).
- `addressElements()`: with a country → parent; without → builds textfields from the fake format
  (required fields, labels, grouped inline rows, subdivision options via
  `processSubdivisionElements()`), sizing/labelling like the parent.
- `clearValues()`: **returns the element unchanged — never clears values under any circumstance.**

### Widget `AddressCountryUnknownWidget` (`@FieldWidget id = "address_country_unknown_default"`)
Extends `AddressDefaultWidget`; `formElement()` calls parent then sets
`$element['address']['#type'] = 'address_country_unknown'`.

### Formatter `AddressCountryUnknownFormatter` (`id = "address_country_unknown_default"`)
Extends `AddressDefaultFormatter`. `viewElement()`: with a country → parent. Without → builds a
render array from `FAKE_ADDRESS_FORMAT_VALUES`, an empty `country` span, and one `span` per used
field with `#value` escaped via `Html::escape($values[$field])` (so field values are output-encoded).

### Formatter `AddressCountryUnknownPlainFormatter` (`id = "address_country_unknown_plain"`)
Extends `AddressPlainFormatter`. `viewElement()`: with a country → parent. Without → a
`#theme => 'address_plain'` render array with the individual name/address/locality values and an
empty `#country` (`code` and `name` blank), plus interface/content language cache contexts.

## Operating notes

- `field_types` for both formatters and the widget is `{ "address" }` — they only attach to
  Address fields.
- Because the field-type class swap is global, uninstalling/disabling restores the stock class;
  while enabled, even fields using the default widget get the `isEmpty()`/constraint behaviour.
- No config object or schema is shipped; there is nothing to export beyond the per-display
  widget/formatter selection in `core.entity_form_display.*` / `core.entity_view_display.*`.
