Integrates the Flags module with the contrib Language Field module: adds a "Language with flag" formatter and widget for `language_field` fields.

---

Flags Language Field provides the `languagefield_flag` field formatter for the contrib [Language Field](https://www.drupal.org/project/languagefield) module's `language_field` field type, rendering the language name together with its flag (via the base module's `flags` theme hook, `source = language`) with the usual `flag-before`/`flag-after`/`flag-instead` output option. It also supplies a `languagefield_select_menu` widget, registered for the `language_field` field type only when the [Select Icons](https://www.drupal.org/project/select_icons) module is enabled (`hook_field_widget_info_alter`). Flag resolution goes through the base `flags.mapping.language` service, so Flags UI overrides apply. Depends on `flags` and `languagefield`.

---

- Display a Language Field value with its flag icon.
- Choose flag-before / flag-after / flag-instead output for the formatter.
- Provide a flag-decorated language select widget for Language Field (with Select Icons).
- Show flags for languages captured with the contrib Language Field module.
- Reuse language→flag mapping overrides from Flags UI.
- Keep Language Field flags consistent with the shared CSS sprite.
- Build compact "flag only" language displays via `flag-instead`.
- Add visual language cues to content using the Language Field type.
- Support sites that use Language Field instead of core language fields.
- Combine with flags_language/flags_country for a fully flagged multilingual site.
- Render Language Field flags in a View listing.
- Correct a locale whose code lacks a matching flag via Flags UI mapping.
- Provide a flag-decorated language picker on entity forms (with Select Icons).
- Show a spoken/known-language field with flags on user profiles.
- Keep Language Field and core-language flag output visually consistent.
- Avoid per-flag image requests by rendering from the CSS sprite.
- Display multiple language flags for a multi-value Language Field.
- Add visual language cues to catalog or media content tagged with languages.
