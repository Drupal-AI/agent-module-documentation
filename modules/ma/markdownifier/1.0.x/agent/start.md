<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Markdownifier (markdownifier) — agent index
**Field formatters that convert an entity's rendered HTML into Markdown.**

- **Version:** 1.0.x
- **Core:** ^8 || ^9 || ^10
- **Library:** `pixel418/markdownify` (Composer)
- **Formatters:** `markdownifier_render_entity_to_markdown` (entity_reference), `markdownifier_render_entity_revisions_to_markdown` (entity_reference_revisions)
- **Mechanism:** `RenderToMarkdownFormatterTrait::view()` attaches `#post_render` → `MarkdownifierHelper::postRender()` (a `TrustedCallbackInterface` callback) which runs the rendered markup through Markdownify's Converter

**Security:** no routes, permissions or config; output-side only. Converts already-rendered/sanitised HTML into Markdown (reduces markup rather than injecting it), so it introduces no new XSS surface. Requires the Markdownify library.
