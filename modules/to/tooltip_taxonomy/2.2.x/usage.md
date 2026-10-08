Tooltip Taxonomy automatically wraps occurrences of taxonomy term names in rendered text fields with a hover/focus tooltip showing the term's description, driven by configurable "filter condition" rules that scope which vocabularies apply to which paths, content types, view modes, fields, and text formats.

---

The module defines a `filter_condition` config entity (list/add/edit/delete at `/admin/config/content/tooltip_taxonomy`) whose rules pick one or more vocabularies plus scoping: request path (via the core `request_path` condition), content types (`entity_bundle:node`), view modes, node text fields, and text formats, with a weight so higher-weighted conditions override lower ones for the same term (handling ambiguous terms). At display time `hook_entity_display_build_alter()` walks each content entity's text fields; for matching conditions the `TooltipManager` service builds a search/replace map: for every accessible term in the selected vocabularies it sanitizes the term description with `Xss::filter()` against an admin-configured allowed-tags list (default `<b><i><strong><span><br><a>`), renders the `tooltip_taxonomy` theme template (term name + description) in isolation, and replaces whole-word term-name matches in the field's `#text` — carefully skipping inside HTML tags and any configured "excluded tags" blocks. The term name is output through the Twig template (autoescaped) and the description is XSS-filtered before rendering, so injected markup is sanitized. A `tooltip_taxonomy` **field formatter** (for entity_reference→taxonomy_term fields) also renders a term as a tooltip using the same template (description passed through `strip_tags` with an allowed-tags setting). Cache tags (`tooltip_taxonomy:<cid>`) are added and invalidated on term presave and condition save. Configuration UI is gated by `administer site configuration` or `administer filters`. Styling comes from the `tooltip_taxonomy/simple_tooltip` CSS library (`.tx-tooltip` / `.tx-tooltip-text`). The README notes you must allow the `<span class="tx-tooltip tx-tooltip-text">` markup in the relevant text format for injected tooltips to survive text-format filtering.

---

- Show a glossary-style tooltip with the term's definition when a term name appears in body text.
- Automatically annotate acronyms/jargon across a whole site from a taxonomy vocabulary.
- Scope tooltips to specific paths (e.g. only under `/docs/*`).
- Scope tooltips to specific content types (e.g. only Articles).
- Scope tooltips to specific view modes (e.g. full view only, not teasers).
- Limit tooltips to specific text fields rather than all text fields.
- Apply tooltips only for chosen text formats.
- Handle ambiguous terms: give "CMS" a general definition site-wide and a narrower one on specific pages via condition weights.
- Override a general definition with a context-specific one using a higher-weight condition.
- Combine multiple vocabularies into one tooltip condition.
- Control which HTML tags are permitted inside tooltip descriptions per condition.
- Exclude replacement inside chosen tags (e.g. skip inside `<h1> <h2> <strong>`) to avoid tooltips in headings.
- Add an accessible, browser-agnostic tooltip (hover and keyboard focus) without writing JS.
- Use the `tooltip_taxonomy` field formatter to render an entity-reference taxonomy field as a tooltip.
- Provide definitions maintained by editors as taxonomy term descriptions.
- Keep tooltip content in sync automatically — cache invalidates when terms or conditions change.
- Localize tooltips: descriptions use the current-language term translation.
- Avoid duplicate tooltips when one term name is a substring of another matched term.
- Deliver on-page term explanations for educational or documentation sites.
- Restrict tooltip configuration to trusted admins (`administer filters` / `administer site configuration`).
