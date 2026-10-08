Paragraphs Summary adds a "Paragraphs enhanced summary" field formatter for Paragraphs (entity_reference_revisions) fields that renders only selected paragraph bundles, in a chosen view mode, up to a configurable item limit.

---

The module ships one field formatter plugin, `paragraphs_summary` (label "Paragraphs enhanced summary", class `ParagraphsSummaryFormatter` extending core `EntityReferenceFormatterBase`), applicable to `entity_reference_revisions` fields whose target entity implements `ParagraphInterface`. On an entity's *Manage display* tab you select it for a Paragraphs field and configure three settings: `allowed_bundles` (checkboxes of the field's eligible paragraph bundles — none selected means all allowed), `view_mode` (which paragraph view mode to render), and `limit` (max number of items to render; `0` = unlimited, default `1`). At render time (`viewElements()`) it walks the referenced paragraphs, skips any whose bundle isn't in the allowed set, renders the rest with the chosen view mode via the paragraph's own view builder, and stops once the limit is reached. It reuses core's recursive-render protection (`RECURSIVE_RENDER_LIMIT = 20`) to guard against paragraph loops. This is handy for showing a compact "summary" of a long Paragraphs field — e.g. only the first hero/text paragraph — in teaser/listing displays. No admin settings page, config schema, permissions, services, Drush, or plugin types beyond this formatter.

---

- Show only the first paragraph of a long Paragraphs field in a teaser/listing view mode.
- Render a Paragraphs field limited to N items (e.g. first 3) instead of all of them.
- Display only specific paragraph bundles (e.g. just "text" or "hero") from a mixed Paragraphs field.
- Pick a dedicated paragraph view mode (e.g. "summary") for the rendered items.
- Build a compact card/teaser preview of a page's Paragraphs content.
- Suppress heavy paragraph bundles (galleries, embeds) in summary displays by not allowing them.
- Show a single "lead" paragraph as an excerpt on a search or index page.
- Limit a homepage promo block to the first paragraph of a referenced node's body.
- Render all bundles but cap the count via the `limit` setting.
- Allow all bundles (leave `allowed_bundles` empty) but switch to a lighter view mode.
- Provide an "at a glance" rendering of structured Paragraphs content in Views listings.
- Differentiate full vs. teaser displays of the same Paragraphs field via two form/display modes.
- Avoid custom preprocess/Twig by configuring bundle + view mode + limit in the UI.
- Prevent recursive paragraph rendering blowups via the built-in render-depth guard.
- Render nested paragraphs' own display while restricting which top-level bundles appear.
- Create a "read more"-style summary that only shows the opening paragraph.
- Reuse an existing paragraph view mode for consistent summary styling across content types.
- Configure per-display which paragraph types are considered part of the summary.
