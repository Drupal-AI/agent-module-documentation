Glossify Taxonomy provides the "Glossify: Tooltips with taxonomy" text-format filter (`glossify_taxonomy`), which scans filtered text and turns occurrences of taxonomy term names into links to their term pages and/or hover tooltips sourced from the term description — an automatic on-site glossary.

---

This submodule subclasses `GlossifyBase` as the `TaxonomyTooltip` filter. Enable it on a text format, select the source **vocabularies**, and choose the render type: `tooltips` (an `<abbr>` whose title is the term's description), `links` (an `<a>` to `/taxonomy/term/[id]`), or `tooltips_links`. `process()` queries `taxonomy_term_field_data` for published terms of the selected vocabularies in the current language, using the term `description__value` as the tooltip text, and tags the query `glossify_taxonomy_tooltip`. It also fires a `glossify_taxonomy_vocabs` alter so other modules can adjust the vocabulary list at runtime. Per-filter settings mirror the base engine: case sensitivity, first-only (default TRUE here), ignore tags, tooltip truncation (300 chars), URL pattern (default `/taxonomy/term/[id]`), and a synonyms field. A `hook_help()` documents setup. Selecting a vocabulary is required when the filter is enabled. Settings live in the text-format config under `filters.glossify_taxonomy.settings`.

---

- Build a site glossary where defined taxonomy terms auto-link to their term pages.
- Show a term's description as a hover tooltip wherever the term appears in content.
- Auto-link the first occurrence of each term per field (the default here).
- Link medical/legal/technical jargon terms to their definition pages.
- Restrict glossification to specific vocabularies (e.g. only "Glossary").
- Match term names case-insensitively so any capitalization links.
- Use a custom URL pattern instead of `/taxonomy/term/[id]`.
- Match alternate spellings/acronyms via a synonyms field on terms.
- Skip glossification inside chosen tags (e.g. headings).
- Exclude a mention by wrapping it in `class="glossify-exclude"`.
- Truncate long term descriptions used as tooltips to 300 characters.
- Provide both a link and a tooltip with "tooltips and links" mode.
- Turn a controlled vocabulary into an interactive on-page glossary.
- Cross-link category/tag names across articles automatically.
- Localize term matching and tooltips per language.
- Exclude specific terms from matching via `hook_query_glossify_taxonomy_tooltip_alter()`.
- Add or remove source vocabularies at runtime via `hook_glossify_taxonomy_vocabs_alter()`.
- Apply term glossification only on selected text formats.
- Give readers instant definitions without leaving the page.
- Keep stored content untouched — links/tooltips are added at render time.
- Standardize terminology presentation across a large content site.
- Surface encyclopedia-style term descriptions inline.
- Avoid manually linking every term occurrence by hand.
- Highlight domain vocabulary consistently for accessibility (focusable `<abbr>`).
