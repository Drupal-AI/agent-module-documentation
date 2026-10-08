<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Address Country Unknown (address_country_unknown) — agent index

Overrides the **Address** field so an address can be entered, saved and displayed with an
**empty/unknown country**. Package `Field types`. Depends on **`address`**. Core `^11`.
License GPL-2.0-or-later. Version 0.0.1-alpha1 (alpha; the project says it may never go stable).

- **The field-type override, widget, formatters and form element — how to enable and how it
  behaves with/without a country** → [fields/address.md](fields/address.md)

## What it actually is

A behavioural patch on Address, not a new field type. It ships:

- **`hook_field_info_alter()`** (`address_country_unknown.module`) — swaps the `address` field
  type's class to `AddressCountryUnknownItem` for **every** address field on the site once enabled.
- Field type **`AddressCountryUnknownItem`** (`src/Plugin/Field/FieldType/`) extends core
  `AddressItem`; overrides `isEmpty()` (non-empty if any non-country part is filled) and
  `getConstraints()` (drops `AddressFormatConstraint`/`CountryConstraint` when country is empty).
- Form element **`address_country_unknown`** (`@FormElement`, `src/Element/AddressCountryUnknown.php`)
  extends Address's `Address` element; renders a synthetic `NONE`-country fallback format when
  `country_code` is empty; `clearValues()` is overridden to **never clear** values.
- Widget **`address_country_unknown_default`** (`AddressCountryUnknownWidget`) extends
  `AddressDefaultWidget`; just switches the element `#type` to `address_country_unknown`.
- Formatters **`address_country_unknown_default`** (`AddressCountryUnknownFormatter`,
  extends `AddressDefaultFormatter`) and **`address_country_unknown_plain`**
  (`AddressCountryUnknownPlainFormatter`, extends `AddressPlainFormatter`).

## Key facts

- **No routes, no permissions, no config, no config schema, no Drush, no external calls.**
- Widget and formatters **must be used together**; mixing with stock Address widget/formatter
  breaks. Do **not** use with Drupal Commerce (needs complete addresses).
- When a country code **is** present, everything defers to core Address unchanged.
- Configure per entity form/view display (Manage form display / Manage display).
