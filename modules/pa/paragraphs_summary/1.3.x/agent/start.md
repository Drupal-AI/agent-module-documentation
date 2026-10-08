# Paragraphs Summary Formatter — agent index

One field formatter, `paragraphs_summary` ("Paragraphs enhanced summary"), for Paragraphs
(`entity_reference_revisions`) fields: render only selected bundles, in a chosen view mode, up to
a limit. No global config, permissions, Drush, services or plugin types. Depends on `paragraphs`.

- **Select & configure the formatter (settings: `allowed_bundles`, `view_mode`, `limit`)** →
  [configure/formatter.md](configure/formatter.md)

Key facts:
- Plugin id `paragraphs_summary`, class `ParagraphsSummaryFormatter` (extends core
  `EntityReferenceFormatterBase`); applies to `entity_reference_revisions` fields targeting a
  `ParagraphInterface` entity.
- Defaults: `allowed_bundles: []` (= all), `view_mode: default`, `limit: 1` (`0` = unlimited).
- Set on *Manage display*; stored in the `entity_view_display` config entity.
