<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides field formatters that render a referenced entity and then convert the resulting HTML into Markdown.

---

The module ships two entity-reference field formatters — "Render entity to Markdown" (`markdownifier_render_entity_to_markdown`, extends the core `EntityReferenceEntityFormatter`) and "Render entity revision to Markdown" (`markdownifier_render_entity_revisions_to_markdown`, for `entity_reference_revisions`). Both use `RenderToMarkdownFormatterTrait`, which attaches a `#post_render` callback (`MarkdownifierHelper::postRender`) to the rendered output. After Drupal renders the referenced entity to HTML, the callback feeds that markup through the `pixel418/markdownify` Converter and returns Markdown, so the field displays as Markdown text instead of HTML.

This is an output-side transformation configured by site builders on a display mode; there is no UI, route, permission or stored configuration of its own, and it depends on the `pixel418/markdownify` PHP library being installed via Composer. Because it converts already-rendered (and already-sanitised) core output down to Markdown rather than injecting new markup, it does not add HTML to the page. Use it where you need a Markdown representation of rendered entities — for example feeding content to an LLM, an export pipeline or a Markdown-consuming API.

---
- Display a referenced entity as Markdown instead of HTML
- Display a referenced entity revision as Markdown
- Produce Markdown output for LLM/agent consumption
- Convert rendered node content to Markdown for export
- Feed a Markdown API or static-site pipeline
- Choose the Markdown formatter on an entity reference field's display
- Apply Markdown conversion within a Views field rendering context
- Convert paragraphs (entity_reference_revisions) output to Markdown
- Generate Markdown snapshots of rendered entities
- Avoid hand-authoring Markdown for structured content
- Reuse a referenced entity's full render array as Markdown
- Keep conversion server-side via a trusted post-render callback
- Emit Markdown for a documentation generation pipeline
- Provide Markdown context to a retrieval/embedding step
- Convert a related-content reference into Markdown text
- Render a media or teaser reference as Markdown
- Build plain-text digests from rendered entities
