Field Formatter Filter adds an "Additional Text Filter/Format" option to text-field formatters on *Manage display*, letting a given view mode re-render a text field through a chosen text format instead of the one stored with the content.

---

The module is entirely hook-driven (no plugin classes). Via `hook_field_formatter_third_party_settings_form()` it injects a `format` select into the formatter settings of `text`, `text_long`, and `text_with_summary` fields, listing every available filter format plus `<none>`. The chosen format id is stored as a third-party setting (`third_party.field_formatter_filter.format`, schema `field.formatter.third_party.field_formatter_filter`) on the entity view display component. At render time `hook_preprocess_field()` reads that setting and overrides each rendered item's `#format` so core's `ProcessedText::preRenderText` applies the selected format *instead of* the field's own format for that view mode only. A settings-summary alter shows the chosen format on the Manage display overview, and a missing/deleted format is logged as a warning and falls back to default rendering. Crucially the module does **not** bypass security: it only swaps which admin-defined filter format runs during display; the stored value is still whatever an editor entered, and any format an admin selects here is an admin-configured text format. Typical use is building "safe teaser" markup — e.g. a stripped-down format for the Teaser view mode that removes headings/blocks — without forcing editors to manage multiple formats themselves. (The README mentions a "Remainder after trimming" formatter; that formatter plugin is not present in the 2.0.x source, which ships only the third-party-settings + preprocess behavior.)

---

- Render a body field's Teaser view mode through a stripped-down "safe teaser" text format.
- Remove headings, images, and block elements from teasers without editing content.
- Apply an enhancement filter (TOC, tabs, glossary) only in a specific view mode.
- Use a permissive format for full display but a restrictive one for listings/teasers.
- Keep editors on a single WYSIWYG format while display view modes vary the filtering.
- Force plain-ish output in a "compact" or "card" view mode of a rich-text field.
- Strip alignment/blockquote markup that breaks a grid layout in a teaser.
- Apply a chunker/summarizer filter in one display without touching stored content.
- Configure the additional filter per field, per view mode on *Manage display*.
- Show the currently selected additional format in the Manage display summary line.
- Fall back gracefully to default rendering when a referenced format was deleted (logged).
- Differentiate filtering between Default, Trimmed, and Summary-or-trimmed displays.
- Provide consistent teaser layouts across content types via a shared teaser format.
- Layer a lightweight extra filter on top of content that used Full HTML.
- Reduce the number of text formats editors must choose between.
- Apply a specialized display-only filter (e.g. tokenized shortcodes) in select view modes.
- Sanitize legacy imported markup at display time for specific view modes.
- Present a cleaner RSS/teaser rendering of long-form content.
- Restrict rich media in listing displays while keeping it on full pages.
- Tune per-view-mode output without cloning fields or content.
