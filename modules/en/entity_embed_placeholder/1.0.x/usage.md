<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Embed Placeholder replaces the full rendered preview of an embedded entity inside the CKEditor 5 editor with a compact, lightweight placeholder box showing just the entity's label and bundle.

---

When you embed a node or media item with the Entity Embed module, CKEditor normally renders the entity's full output (via the `embed.preview` route) right inside the editing area, which can be heavy, slow, or visually noisy. This module swaps that in-editor preview for a small grey placeholder card. It works entirely through Drupal's theme layer: `hook_theme_suggestions_node_alter()` / `hook_theme_suggestions_media_alter()` add the suggestions `node__embed_preview` and `media__embed_preview` when the current route is `embed.preview`, and `hook_theme()` registers those two theme hooks with the templates `node--embed-preview.html.twig` and `media--embed-preview.html.twig`. The templates output a `<div class="embedded-entity-placeholder">` containing the entity label and its content-type / media-bundle label. A CSS file (`css/entity_embed_placeholder.css`, library `entity_embed_placeholder/common`) styles the grey box and is attached to Entity Embed's own library through `hook_library_info_alter()`. The module has no settings, permissions, routes, services, or config — customization is done purely by overriding the templates or CSS from your own theme or module (e.g. via `hook_theme_registry_alter()`, or a CKEditor `ckeditor5-stylesheets` entry).

---

- Speed up the CKEditor editing experience by not rendering full embedded entities inline.
- Show a clean, uniform placeholder card for every embedded node in the editor.
- Show a placeholder card for embedded media items with their bundle label.
- Avoid heavy or broken in-editor previews (e.g. entities with expensive render output).
- Give editors a clear, compact visual marker of where an entity is embedded.
- Prevent editor layout jumping caused by full-size entity previews.
- Display the embedded entity's title/label so editors know what they embedded.
- Display the content type or media bundle so editors can distinguish embeds at a glance.
- Standardise the look of all entity embeds across content types in CKEditor.
- Override `node--embed-preview.html.twig` in a custom theme to brand the placeholder.
- Override `media--embed-preview.html.twig` to add a thumbnail or extra metadata.
- Restyle the placeholder box (colour, height) by overriding `.embedded-entity-placeholder` CSS.
- Point the embed-preview theme hook at a different template via `hook_theme_registry_alter()`.
- Add a custom stylesheet to CKEditor via the theme's `ckeditor5-stylesheets` for the placeholder.
- Reduce server load from repeated preview rendering while authoring long articles.
- Keep the editor readable when many entities are embedded in one document.
- Provide a consistent placeholder for both node and media embeds in one module.
- Improve accessibility/scannability of the editing surface with predictable placeholder markup.
- Use as a drop-in enhancement for any site already using Entity Embed + CKEditor 5.
- Give a content team a low-distraction editing view of embedded references.
- Serve as a base you extend, rather than writing the theme-suggestion plumbing yourself.
