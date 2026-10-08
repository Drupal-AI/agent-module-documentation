# Taxonomy Formatter — agent index

One field formatter, `taxonomy_term_reference_formatter` ("Taxonomy Formatter"), for
`entity_reference` (taxonomy term) fields: renders referenced terms inline with a configurable
separator, optional per-term element + class, optional wrapper element + class, and optional links.
No config page (`configure` null), no permissions, no Drush, no config schema. Depends on `taxonomy`.

- **The formatter settings keys, defaults, output/escaping behavior, and how to set them (UI + code)**
  → [configure/formatter.md](configure/formatter.md)

Key facts:
- Formatter id `taxonomy_term_reference_formatter`, field types `entity_reference`.
- Settings: `links_option` (bool), `separator_option` (string, default `", "`), `element_option`,
  `element_class`, `wrapper_option`, `wrapper_class`.
- Labels escaped with `Html::escape`; classes via `Html::cleanCssIdentifier`; output is one `#markup`.
