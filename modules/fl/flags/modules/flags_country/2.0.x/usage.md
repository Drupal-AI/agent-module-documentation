Integrates the Flags module with the contrib Country module: adds a "Country with flag" field formatter and flag-decorated select/autocomplete widgets for `country` fields.

---

Flags Country provides the `country_flag` field formatter for `country` fields, rendering each value as the country name plus its flag (via the base module's `flags` theme hook, `source = country`). The formatter has an *Output format* setting — `flag-before`, `flag-after`, or `flag-instead` (flag replaces the name). It also supplies two widgets, `country_select_menu` and `country_flag_autocomplete`, but these are only registered for the `country` field type when the [Select Icons](https://www.drupal.org/project/select_icons) module is enabled (`hook_field_widget_info_alter`). The autocomplete widget is backed by `CountryFlagAutocompleteController` (extends Country's own autocomplete controller) at `/flags_country/autocomplete/{entity_type}/{bundle}/{field_name}`, returning selectable countries (from the field's allowed-countries config) filtered by the typed string, each rendered with its flag. Requires the base `flags` module and the `country` module.

---

- Display a country field value with its flag icon on entity pages.
- Choose whether the flag appears before, after, or instead of the country name.
- Provide a flag-decorated country dropdown for editors (with Select Icons).
- Provide a flag-previewing country autocomplete widget (with Select Icons).
- Show flags in a country list limited to the field's allowed countries.
- Keep flag rendering consistent with the base module's CSS sprite.
- Build address/location displays that show country flags.
- Offer a compact "flag only" country display via `flag-instead`.
- Reuse Country module's selectable-countries config for autocomplete suggestions.
- Add visual country cues to content without custom theming.
- Show country flags in a View that renders a country field with the `country_flag` formatter.
- Apply Flags UI mapping overrides so a country code renders a custom territory flag.
- Provide a flag-rich country picker for user profiles or org/location content types.
- Keep the country field's flag output consistent across list and full view modes.
- Combine with flags_language for a fully flag-decorated internationalized site.
- Avoid extra image HTTP requests by rendering country flags from the CSS sprite.
- Let editors search countries by name while previewing flags in the autocomplete.
