# USWDS Ckeditor Integration Embed — agent index

Config-only glue submodule of `uswds_ckeditor_integration`. No PHP — it ships a ready-made
`uswds_paragraphs` text format + CKEditor editor + paragraph-embed buttons as `config/optional`.
Depends on `uswds_ckeditor_integration`, `uswds_paragraph_components`, and
`paragraphs_entity_embed`. No permissions, config schema, plugin types, or Drush.

Parent module docs: [../../../../4.0.x/agent/start.md](../../../../4.0.x/agent/start.md)

What it installs (`config/optional/`):
- `filter.format.uswds_paragraphs` — the **USWDS (Paragraphs)** text format; `filter_html`
  allow-list covers headings, `<drupal-media>`/`<drupal-entity>`/`<drupal-paragraph>` embeds,
  USWDS `<div>`/`<button>` accordion markup, and tables; includes the parent's
  `filter_table_attributes` filter.
- `editor.editor.uswds_paragraphs` — CKEditor config; toolbar with USWDS grid, accordion, table
  items, and `paragraphs` / `paragraph_layout` embed buttons.
- `embed.button.paragraphs` — `paragraphs_entity_embed` button filtered to `uswds_accordion`,
  `uswds_alert`, `uswds_cards_flag`, `uswds_card_group_flag`, `uswds_process_list`,
  `uswds_step_indicator_list`, `uswds_summary_box`.
- `embed.button.paragraph_layout` — button filtered to `uswds_2_columns`, `uswds_3_columns`.
- `embed.settings`, `entity_embed.settings`, `core.entity_view_mode.paragraph.embed` — supporting
  defaults + a `paragraph.embed` view mode.

Notes:
- `config/optional` means these install only when their module dependencies are present.
- Not enabled on this documentation site (missing `uswds_paragraph_components` +
  `paragraphs_entity_embed`); documented from source config.
- No solution docs beyond this index — there is no code or invokable API to summarize.
