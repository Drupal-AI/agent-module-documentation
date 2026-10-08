<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Gutenberg Blocks (advanced_gutenberg_blocks) — agent index

Addon **blocks for the Gutenberg editor**. Registers ~20 extra client-side Gutenberg blocks (headings,
text, media, sliders/mosaics, CTA, link list, FAQ accordion, audio, spacer) so authors get a richer
block palette. Version dir `1.0.x` (installed 1.0.1). Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.

## Shape (what it does and does NOT provide)
- **No** `src/` PHP, **no** routing/permissions/services/config, **no** settings form, **no** Drush,
  **no** config schema, **no** Drupal plugin types. Nothing to configure — enabling it is the whole setup.
- Blocks are declared in **JavaScript** (`js/index.js`, source `js/index.es6.js`), registered via
  `registerBlockType('advanced_gutenberg_blocks/<name>', …)` and injected into the editor by Gutenberg.
- `advanced_gutenberg_blocks.module` provides two `template_preprocess_*` hooks for the demo `example`
  block namespace only (add a `data-*` attribute); no other server-side logic.

## Dependencies
- `gutenberg` (the editor these blocks extend), core `media`, core `media_library` (media-aware blocks).

## Key files
- `advanced_gutenberg_blocks.gutenberg.yml` — declares editor/view libraries and the `dynamic-blocks`
  list (example server-side-rendered block names).
- `advanced_gutenberg_blocks.libraries.yml` — `block-edit` (editor JS/CSS, depends `gutenberg/edit-node`)
  and `block-view` (front-end CSS/JS).
- `templates/gutenberg-block--example*.html.twig` — example server-side render templates.
- `advanced_gutenberg_blocks.module` — `template_preprocess_gutenberg_block__example[__dynamic_block]()`.

## Solution docs
- [agent/blocks/blocks.md](blocks/blocks.md) — the block set, how blocks are registered/rendered,
  libraries, dynamic-blocks, templates and the preprocess hooks; install/enable and how to operate it.
