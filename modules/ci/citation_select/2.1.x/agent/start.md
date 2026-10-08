# Citation Select — agent index

A block that generates a copyable, style-selectable bibliographic citation for the current node: node fields
→ CSL-JSON → rendered by citeproc-php against installed CSL styles. Depends on `token` + external libs
(`seboettg/citeproc-php`, `professional-wiki/edtf`, `adci/full-name-parser`). Config UI at
`/admin/config/citation-select` (`configure: citation_select.settings`); all admin routes require
`administer site configuration`. No own permissions, no Drush.

- **Settings form, CSL Mapping form, CSL style entities (paste/upload), placing the block** →
  [configure/settings.md](configure/settings.md)
- **The `CitationFieldFormatter` plugin type, the 4 built-in plugins, how to add one** →
  [plugins/citation-field-formatter.md](plugins/citation-field-formatter.md)
- **Services: `citation_select.citation_processor`, `citation_select.citation_styler`, human name parser** →
  [api/services.md](api/services.md)

Key facts:
- Block `citation_select_block` → `SelectCitationForm` (style select + AJAX bibliography + clipboard copy).
- Node resolved from URL token `[current-page:url:unaliased:args:value:1]`; output `Xss::filter`ed.
- CSL styles are `citation_select_csl_style` config entities (ships APA, MLA×2, Chicago author-date, AMA);
  add via paste (`CslStyleForm`) or file upload (`CslStyleFileForm`).
- Config `citation_select.settings`: `default_style`, `show_on_load`, `csl_map`,
  `reference_type_field_map`, `typed_relation_map`.
- Defines plugin type `citation_field_formatter` (manager `plugin.manager.citation.field.formatter`).
