Smart Trim provides a "Smart trimmed" field formatter for text and string fields that truncates content to a configurable length (by characters or words) while keeping HTML valid, and can append a customizable "Read more" link.

---

Smart Trim is a drop-in replacement for core's "Summary or trimmed" text formatter that gives site builders far more control over how long text is shortened for teasers, cards, and search results. You attach it as the display formatter on `text`, `text_long`, `text_with_summary`, `string`, or `string_long` fields in a view mode, then configure a trim length measured in characters or words. Its HTML-aware truncation (via the module's `TruncateHTML` service) closes any tags it cuts through so the markup stays valid, and it can optionally strip HTML entirely, honor a zero-length trim, or run token replacement before trimming. A configurable suffix (e.g. an ellipsis) and an optional "More" link — with its own text, class, aria-label, target, and "only when trimmed" behavior — round out the output. For `text_with_summary` fields you choose whether an existing summary is used verbatim, trimmed, or ignored. Output is rendered through the themeable `smart-trim.html.twig` template with granular per-entity/bundle/field theme suggestions, and a `hook_smart_trim_link_modify` hook lets modules rewrite the read-more link. The module also exposes a Twig extension and smart-trim tokens for use elsewhere. All settings are stored in the field-formatter config (schema `field.formatter.settings.smart_trim`), so they export and deploy like any display configuration.

---

- Build teaser/card view modes that show the first N characters of body text.
- Trim summaries by word count instead of character count for cleaner cuts.
- Truncate long text without breaking HTML tags in the middle.
- Append an ellipsis (…) or custom suffix to trimmed text.
- Add a "Read more" link that points to the entity's canonical page.
- Show the "More" link only when the text was actually trimmed.
- Open the "Read more" link in a new browser tab/window.
- Give the "More" link a custom CSS class for styling.
- Add an accessible aria-label to the read-more link for screen readers.
- Use tokens (e.g. `[node:title]`) in the more-link text or aria-label.
- Strip all HTML to produce a plain-text excerpt (good for meta descriptions).
- Replace tokens inside field content before trimming it.
- Honor a zero-length trim to suppress body output while keeping a summary.
- Choose whether a text_with_summary field uses, trims, or ignores its summary.
- Standardize teaser length across many content types and view modes.
- Generate consistent excerpts for listing pages and Views rows.
- Wrap trimmed output in a div with a custom class (legacy option).
- Override `smart-trim.html.twig` to fully control trimmed markup.
- Target specific fields/bundles with per-entity theme suggestions.
- Rewrite or redirect the read-more link in code via `hook_smart_trim_link_modify`.
- Produce search-result snippets of a fixed length.
- Create social-share preview text from body fields.
- Show short blurbs in mega-menus or promoted content blocks.
- Trim user-generated string fields (names, bios) to a safe length.
- Provide predictable excerpt lengths for a decoupled/headless front end.
