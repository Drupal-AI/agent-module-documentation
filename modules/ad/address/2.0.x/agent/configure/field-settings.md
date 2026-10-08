# Configure address fields

Address has no dedicated settings page; you configure it per field through the
standard **Field UI** (Structure → Content type → Manage fields → add an *Address*
field). The `configure` route in info.yml is `entity.address_format.collection`.

## Field types (choose when adding the field)
- `address` — full compound postal address (all properties below).
- `address_country` — country code only.
- `address_zone` — a geographic zone made of territory rules.

## Address field storage properties
`country_code`, `administrative_area`, `locality`, `dependent_locality`,
`postal_code`, `sorting_code`, `address_line1`, `address_line2`, `address_line3`,
`organization`, `given_name`, `additional_name`, `family_name`, `langcode`.
(Config schema key: `field.value.address`.)

## Field settings (`field.field_settings.address`)
- `available_countries` — sequence of allowed country codes (empty = all).
- `langcode_override` — pin the address language regardless of UI language.
- `field_overrides` — per-property `override` = `HIDDEN` | `OPTIONAL` | `REQUIRED`
  (overrides the country's default address format). Replaces the deprecated `fields`.

## Widget settings
- `address_default` widget: `wrapper_type` (`details` or `fieldset`).
- `address_zone_default` widget: `show_label_field` (bool).

## Formatters
- `address_default` — country-formatted HTML output.
- `address_plain` — plain, template-overridable output (see theming doc).
- `country_default`, `zone_default` for the country/zone field types.

Everything is exportable config; there is no separate admin form beyond Field UI.
