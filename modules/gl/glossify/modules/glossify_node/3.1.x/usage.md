Glossify Node provides the "Glossify: Tooltips with nodes" text-format filter (`glossify_node`), which scans filtered text and turns occurrences of published node titles into links to those nodes and/or hover tooltips sourced from the node body.

---

This submodule subclasses `GlossifyBase` as the `NodeTooltip` filter plugin. Enable it on a text format at `/admin/config/content/formats`, choose the source **content types** whose titles become the term list, and pick how matches render: `tooltips` (an `<abbr>` showing the node body as its definition), `links` (an `<a>` to the node), or `tooltips_links`. Its `process()` queries `node_field_data` (joined to `node__body` for the tooltip text) for published nodes of the selected types in the current language, tagging the query `glossify_node_tooltip` so it can be altered. Per-filter settings include case sensitivity, first-occurrence-only matching, tags to ignore, tooltip truncation (300 chars), a URL pattern with an `[id]` token (default `/node/[id]`), and an optional synonyms field (a plain-text field on the node whose values also match). Selecting a content type is required when the filter is enabled. Because it extends the base engine, it honors the `glossify-exclude` class and avoids double-wrapping existing links. Config for the filter is stored inside the text format entity under `filters.glossify_node.settings`.

---

- Auto-link mentions of article titles to their article pages in body text.
- Show a tooltip with a node's body summary when hovering its title elsewhere on the site.
- Cross-link a knowledge base where every page's title auto-links when mentioned.
- Turn glossary node titles into definition tooltips throughout content.
- Link only the first occurrence of each node title per field to reduce clutter.
- Restrict auto-linking to specific content types (e.g. only "Glossary term" nodes).
- Match node titles case-insensitively so any capitalization links.
- Use a custom URL pattern (e.g. `/wiki/[id]`) instead of `/node/[id]`.
- Match alternate spellings via a synonyms field on the node.
- Skip auto-linking inside headings by listing tags to ignore (`h1,h2`).
- Exclude a specific mention by wrapping it in `class="glossify-exclude"`.
- Truncate long node-body tooltips to 300 characters automatically.
- Provide both a link and a hover definition with the "tooltips and links" mode.
- Build an internal encyclopedia that self-links related entries.
- Interlink product-description nodes referenced across marketing pages.
- Exclude certain nodes from the source list via `hook_query_glossify_node_tooltip_alter()`.
- Apply node glossification only on the "Full HTML" format, not comments.
- Keep stored content untouched — links are added at render time.
- Give editors automatic cross-linking without manually inserting links.
- Surface definitions from a "Definitions" content type as tooltips everywhere.
- Link acronyms defined as nodes to their explanatory pages.
- Reduce broken internal links by generating them from live node titles.
- Localize matching per language (the filter runs per langcode).
