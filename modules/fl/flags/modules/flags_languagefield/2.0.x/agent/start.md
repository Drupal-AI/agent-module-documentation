# Flags Language Field — agent index

Flags integration for the contrib **Language Field** (`languagefield`) module: a `languagefield_flag`
formatter and (with Select Icons) a `languagefield_select_menu` widget for `language_field` fields.
Depends on `flags` + `languagefield`. No config page, no permissions, no custom plugin types.

No separate solution doc — see the base module's
[api/mapping.md](../../../../2.0.x/agent/api/mapping.md) for the theme hook and mapping services.

Key facts:
- Formatter `languagefield_flag` (`LanguagefieldFlagFormatter`) for `language_field` fields; output
  setting `flag_display` ∈ {`flag-before`,`flag-after`,`flag-instead`}; renders via
  `#theme => 'flags', '#source' => 'language'`.
- Widget `languagefield_select_menu` registered for `language_field` only when `select_icons` is
  enabled (`flags_languagefield_field_widget_info_alter`).
