<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Gutenberg Blocks — the block set & rendering

## Install / enable
```bash
composer require drupal/advanced_gutenberg_blocks
drush en advanced_gutenberg_blocks -y
```
Requires the contrib `gutenberg` module plus core `media` and `media_library` (all listed in
`advanced_gutenberg_blocks.info.yml`). No configuration: enabling the module makes the blocks appear in
the Gutenberg inserter. Gutenberg must be enabled as the editor for the content type being edited.

## How blocks are registered
All blocks are defined in `js/index.js` (built) / `js/index.es6.js` (source, ~1850 lines). At the bottom
(`index.es6.js:1770-1853`) the module defines a Gutenberg block category `{ slug: 'example', title: 'Advanced Gutenberg Blocks' }`,
prepends it via `dispatch('core/blocks').setCategories(...)`, then calls `registerBlockType('example/<name>-block', {...})`
for each block. So every block's Gutenberg name is `example/<name>-block`.

Registered blocks (`registerBlockType` calls, `index.es6.js:1830-1853`):
`sectionbreak-block`, `customheading-block`, `highlightedtext-block`, `imagegrid-block`,
`customtext-block`, `textimageslide-block`, `textimageslider-block`, `customfeaturedmedia-block`,
`customimagemosaic-block`, `linkmosaic-block`, `featuredtext-block`, `textimage-block`, `cta-block`,
`linklistitem-block`, `linklist-block`, `textmosaic-block`, `fullwidthslider-block`, `spacer-block`,
`faqitem-block`, `faq-block`, `audio-block`. Three (`teammember-block`, `media-block`,
`mediarepeater-block`) are present but **commented out** at registration, though still listed in the
`.gutenberg.yml` `dynamic-blocks` map.

Each block object supplies Gutenberg `attributes`, an `edit()` React component (uses `RichText`,
`InspectorControls`, `MediaUpload`/`MediaUploadCheck`, `InnerBlocks`, color/select controls) and a
`save()` component that emits the block's static markup. Media-aware blocks (featured media, image
grid/mosaic, sliders, audio) use core `MediaUpload`, so media is chosen through the Media Library.

## Libraries (`advanced_gutenberg_blocks.libraries.yml`)
- **`block-edit`** — editor assets: `js/index.js` + `css/style.css`, `css/edit.css`; depends on
  `gutenberg/edit-node`. Injected on node edit.
- **`block-view`** — front-end assets: `css/style.css`, `css/advanced_gutenberg_blocks.css`,
  `js/advanced_gutenberg_blocks.js`. Injected on node view.

## Editor / view wiring (`advanced_gutenberg_blocks.gutenberg.yml`)
This file is read by the Gutenberg module:
- `libraries-edit: [advanced_gutenberg_blocks/block-edit]` — load in the editor.
- `libraries-view: [advanced_gutenberg_blocks/block-view]` — load on the rendered page.
- `dynamic-blocks:` — a map of `example/*-block` names Gutenberg may render **server-side** (all 24
  block names, each with an empty `{}` config).

## Server-side rendering (Twig templates + preprocess)
For a `dynamic-block`, the Gutenberg module renders it server-side using a Twig template
`gutenberg-block--<namespace>--<block>.html.twig`, falling back to `gutenberg-block--<namespace>.html.twig`.
This module ships two example templates under `templates/`:
- `gutenberg-block--example--dynamic-block.html.twig` — demo template that prints
  `{{ block_attributes.title }}` in an `<h2>` and `{{ block_content }}` in a wrapper `<div>`.
- `gutenberg-block--example.html.twig` — namespace fallback for any `example/*` block; prints
  `{{ block_content }}`.
Both use plain Twig `{{ }}` output (auto-escaped); neither applies a `raw`/`Markup` filter.

`advanced_gutenberg_blocks.module` provides two matching preprocess hooks:
- `template_preprocess_gutenberg_block__example__dynamic_block(&$variables)` — sets
  `$variables['attributes']['data-example-dynamic-attribute'] = $variables['block_name']`.
- `template_preprocess_gutenberg_block__example(&$variables)` — sets
  `$variables['attributes']['data-example-namespace-dynamic-attribute'] = 'true'`.
These only add HTML `data-*` attributes; there is no other server-side logic in the module.

## Operating notes
- There is **no settings form, route, permission, service, config object or Drush command** — grep of
  the project finds no `*.routing.yml`, `*.permissions.yml`, `*.services.yml`, `config/`, or `src/`.
- To use: enable Gutenberg for a content type, edit a Gutenberg document, open the inserter (`+`), pick
  a block from the "Advanced Gutenberg Blocks" category, and configure it like any core block.
- Because block markup is authored in Gutenberg and stored in the content field, it is rendered through
  the content field's text format like all other Gutenberg content.
