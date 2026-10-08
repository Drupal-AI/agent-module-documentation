# Flags Language (Core) — agent index

Flags for core's language system: flags on the language switcher block/links, plus a `language_flag`
formatter and (with Select Icons) a `language_select_menu` widget for core `language` fields.
Depends on `flags` + core `language`. No config page, no permissions, no custom plugin types.

No separate solution doc — everything is in this index; see the base module's
[api/mapping.md](../../../../2.0.x/agent/api/mapping.md) for the theme hook and mapping services.

Key facts (`flags_language.module`):
- `hook_language_switch_links_alter` — wraps each switcher link title with a `flags` element
  (`#source => 'language'`, code = `flags.mapping.language->map($langCode)`).
- `hook_block_view_language_block_alter` — attaches library `flags/flags` to the language block.
- Formatter `language_flag` (`LanguageFlagFormatter`, extends core `LanguageFormatter`) for
  `language` fields; setting `flag_display` ∈ {`flag-before`,`flag-after`,`flag-instead`}.
- Widget `language_select_menu` registered for `language` only when `select_icons` is enabled
  (`flags_language_field_widget_info_alter`).
