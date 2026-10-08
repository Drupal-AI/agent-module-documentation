<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Embed Placeholder — agent index

Replaces the full in-CKEditor preview of an Entity Embed with a compact grey placeholder card
(entity label + bundle). Pure theme-layer module: **no config, permissions, routes, services,
Drush, or plugins**. Depends on `ckeditor5` + `entity_embed`. `configure: null`.

- **Theme hooks, suggestions, templates, the CSS library, and how to override the placeholder** →
  [theming/placeholder.md](theming/placeholder.md)

Key facts: on route `embed.preview` it adds theme suggestions `node__embed_preview` /
`media__embed_preview` (templates `node--embed-preview.html.twig` /
`media--embed-preview.html.twig`), rendering `<div class="embedded-entity-placeholder">`.
CSS library `entity_embed_placeholder/common` is auto-attached to Entity Embed's
`entity_embed/entity_embed` library via `hook_library_info_alter()`. Customize by overriding
those templates or the `.embedded-entity-placeholder` CSS from your theme/module.
