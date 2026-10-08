Glossify is an API/base module that provides the shared machinery for text-format filters which scan rendered text and automatically turn matching entity labels into glossary links or hover tooltips. On its own it does nothing user-facing — you enable one of its submodules (Glossify Node, Glossify Taxonomy, or Glossify Commerce).

---

Glossify ships the abstract `GlossifyBase` filter plugin (extending core `FilterBase`) plus two theme hooks and templates; the submodules subclass it to source their term list from nodes, taxonomy terms, or commerce products. `GlossifyBase::parseTooltipMatch()` loads the text into a DOM, builds a normalized regex per term (respecting case-sensitivity and word boundaries), skips text inside `<a>`/`<abbr>` and any element with the `glossify-exclude` class (and optionally configured "ignore tags"), removes nested/overlapping matches, and replaces each match with either an `<abbr class="glossify-tooltip-tip">` tooltip (the `glossify_tooltip` theme) or an `<a class="glossify-tooltip-link">` link (the `glossify_link` theme). It supports first-occurrence-only linking, tooltip text sourced from a related field (truncated to 300 chars), a configurable URL pattern with an `[id]` token, and optional **synonyms** loaded from a chosen plain-text field so alternate spellings also match. Each submodule filter adds a `glossify_<type>_tooltip` query tag so other modules can alter the term query via `hook_query_TAG_alter()`, and the taxonomy filter also fires a `glossify_taxonomy_vocabs` alter. Configure it by enabling a Glossify filter on a text format at `/admin/config/content/formats`. No permissions, plugins types of its own, or Drush.

---

- Provide the shared base for auto-linking glossary terms in body text (via a submodule).
- Turn defined terms into hover tooltips showing their definition (`<abbr title>`).
- Auto-link the first occurrence of each term per field and leave the rest as plain text.
- Link terms to their canonical page using a custom URL pattern with an `[id]` token.
- Exclude specific text from glossification by wrapping it in `class="glossify-exclude"`.
- Skip glossification inside chosen HTML tags (e.g. `h1,h2,strong`).
- Match terms case-sensitively or case-insensitively per filter.
- Show both a tooltip and a link for a matched term ("tooltips and links" mode).
- Truncate long tooltip definitions to 300 characters automatically.
- Match alternate spellings via a synonyms field (e.g. "US" for "United States").
- Avoid double-wrapping terms already inside links or `<abbr>` elements.
- Prevent a shorter term inside a longer matched term from being linked separately.
- Alter the term source query with `hook_query_glossify_node_tooltip_alter()` to exclude items.
- Restrict the taxonomy term source via the `glossify_taxonomy_vocabs` alter hook.
- Override the link/tooltip markup by overriding the `glossify_link` / `glossify_tooltip` templates.
- Build a domain glossary where jargon links to definition pages.
- Cross-link product names, article titles, or taxonomy terms across a site's content.
- Add accessible keyboard-focusable term tooltips (`tabindex="0"` on the `<abbr>`).
- Set per-language tooltips by keying off the filter's langcode.
- Reuse one filtering engine across node, taxonomy, and commerce sources.
- Apply glossification only on selected text formats (e.g. Full HTML but not Basic).
- Provide editors an automatic, zero-markup way to interlink content.
- Extend Glossify to a new entity type by subclassing `GlossifyBase`.
- Keep stored content untouched — matching happens at render/filter time only.
