# Theming address output

The `address_default` formatter renders country-formatted HTML directly. The
`address_plain` formatter renders through a Twig template you can override.

## Theme hook: `address_plain`
Template: `templates/address-plain.html.twig`. Variables (from `hook_theme()` in
`address.module`): `given_name`, `additional_name`, `family_name`, `organization`,
`address_line1`, `address_line2`, `address_line3`, `postal_code`, `sorting_code`,
`dependent_locality`, `locality`, `administrative_area`, `country`, plus `address`
(the `AddressInterface` item) and `view_mode`.

## Template suggestions
`address_theme_suggestions_address_plain()` adds, in order of specificity:
```
address_plain__ENTITYTYPE__VIEWMODE
address_plain__ENTITYTYPE__BUNDLE
address_plain__ENTITYTYPE__BUNDLE__VIEWMODE
address_plain__FIELDNAME
address_plain__ENTITYTYPE__FIELDNAME
address_plain__ENTITYTYPE__FIELDNAME__BUNDLE
```
So copy `address-plain.html.twig` to e.g.
`address-plain--node--field-venue.html.twig` in your theme to customise a specific
field.

## Libraries (`address.libraries.yml`)
- `address/form` — CSS for the address widget layout.
- `address/field-icon` — Field UI icon (attached via
  `hook_field_type_category_info_alter`).
