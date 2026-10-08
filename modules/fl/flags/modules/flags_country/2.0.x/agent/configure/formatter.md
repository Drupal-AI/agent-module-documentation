# Country flag formatter & widgets

## Formatter `country_flag`
`flags_country/src/Plugin/Field/FieldFormatter/CountryFlagFormatter.php` (extends
`CountryDefaultFormatter`). For `country` fields. Select it on *Manage display*.
- Setting `flag_display` (default `flag-before`):
  - `flag-before` — flag then country name.
  - `flag-after` — country name then flag.
  - `flag-instead` — flag only (name suppressed).
- Each item is wrapped in `<div class="field__flags__item">` and rendered with
  `#theme => 'flags', '#code' => <iso2 lowercased>, '#source' => 'country'`. Only values within
  the field's selectable countries are decorated.

## Widgets (require Select Icons)
Registered for the `country` field type only when `select_icons` is enabled
(`flags_country_field_widget_info_alter`):
- `country_select_menu` — select with flag-decorated options.
- `country_flag_autocomplete` — autocomplete text field previewing flags.

## Autocomplete route
`flags_country.country_autocomplete` →
`/flags_country/autocomplete/{entity_type}/{bundle}/{field_name}`, controller
`CountryFlagAutocompleteController::autocomplete` (extends Country's autocomplete controller).
Reads `?q=`, loads the field's `getSelectableCountries()`, returns JSON `{value,label}` matches with
a rendered flag. Route requirement is `_access: 'TRUE'` (open); it only echoes public country names
already constrained by the field config.
