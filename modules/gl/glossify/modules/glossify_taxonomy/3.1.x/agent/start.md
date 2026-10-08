# Glossify Taxonomy — agent index

Provides the **`glossify_taxonomy`** text-format filter ("Glossify: Tooltips with taxonomy"), a
subclass of `GlossifyBase` that auto-links/tooltips **taxonomy term names** (tooltip = the term
description). Enable it on a text format. No settings form of its own. Base engine:
[../../../../3.1.x/agent/api/glossifybase.md](../../../../3.1.x/agent/api/glossifybase.md).

- **Enable & configure the filter: settings keys, defaults, source query, the vocabs alter, synonyms** →
  [configure/filter.md](configure/filter.md)

Key facts:
- Term source: published terms of the chosen **vocabularies** from `taxonomy_term_field_data`; tooltip
  text = `description__value`. Query tag `glossify_taxonomy_tooltip`; also fires
  `glossify_taxonomy_vocabs` alter.
- Settings at `filter.format.<format>` → `filters.glossify_taxonomy.settings`. Selecting a vocabulary is
  **required** when enabled. Defaults: `first_only = TRUE`, URL pattern `/taxonomy/term/[id]`.
