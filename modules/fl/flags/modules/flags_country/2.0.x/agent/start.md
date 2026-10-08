# Flags Country — agent index

Flags integration for the contrib **Country** module: a "Country with flag" formatter and (with
Select Icons) flag-decorated country widgets. Depends on `flags` + `country`. No config page, no
permissions.

- **The `country_flag` formatter, its output-format setting, the two widgets, and the autocomplete route** → [configure/formatter.md](configure/formatter.md)

Key facts:
- Formatter `country_flag` (`CountryFlagFormatter`, extends Country's `CountryDefaultFormatter`) for
  `country` fields; setting `flag_display` ∈ {`flag-before`,`flag-after`,`flag-instead`}.
- Widgets `country_select_menu`, `country_flag_autocomplete` registered for `country` only when
  `select_icons` is enabled (`flags_country_field_widget_info_alter`).
- Autocomplete route `flags_country.country_autocomplete`
  `/flags_country/autocomplete/{entity_type}/{bundle}/{field_name}` → `CountryFlagAutocompleteController`
  (`_access: 'TRUE'`; returns allowed country names for the field filtered by `?q=`, each with a flag).
- Renders via base `#theme => 'flags', '#source' => 'country'`.
