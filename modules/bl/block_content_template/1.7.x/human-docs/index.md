# Block content template — manual setup guide

**Block content template** (`block_content_template`) gives your custom (content)
block entities their own Twig template — the same way nodes and taxonomy terms
already have one. Out of the box, Drupal renders a custom block's fields without an
entity-level template wrapper, which makes a whole block type awkward to theme. This
module adds a `block-content.html.twig` template plus a cascade of theme suggestions
and some ready-made CSS classes, so you can style custom blocks per bundle, per view
mode, or even per individual block.

Enabling it is all it takes — there is **no configuration, no admin UI, no routes,
and no permissions**. Once on, every rendered custom block passes through the new
template, which wraps the block's fields in a predictable `<div>` with classes like
`block-content`, `block-content--type-<bundle>`, `block-content--<id>`, and
`block-content--view-mode-<view_mode>`. The template also exposes handy variables —
`id`, `bundle`, `view_mode`, `label`, and `content` — for use in your own overrides,
and it plays nicely with Layout Builder.

The theming itself happens in **your theme**: you create suggestion-named Twig files
(for example `block-content--promo.html.twig` for a "Promo" block type, or
`block-content--full.html.twig` for the Full view mode) and clear caches. The module
just makes those suggestions available; it does not ship opinionated markup beyond a
minimal wrapper. It requires core's **Block content** module.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — including the exact suggestion order
and preprocess variables — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is nothing to configure — you theme by adding Twig files to your active theme.

1. Enable the module (see [Installation](installation/index.md)). From then on,
   every custom block is rendered through `block-content.html.twig`.
2. Decide what you want to target and create the matching template file in your
   theme's `templates` directory:
   - A whole block type: `block-content--<bundle>.html.twig` (e.g.
     `block-content--promo.html.twig`).
   - A specific view mode: `block-content--<view-mode>.html.twig` (e.g.
     `block-content--full.html.twig`).
   - A bundle in a specific view mode:
     `block-content--<bundle>--<view-mode>.html.twig`.
   - A single block by its id: `block-content--<id>.html.twig`, optionally combined
     with a view mode as `block-content--<id>--<view-mode>.html.twig`.
   The most specific suggestion wins, so an id-plus-view-mode template overrides a
   plain bundle one.
3. In your template, use the variables the module provides — `content`, `label`,
   `bundle`, `view_mode`, and `id` — to build exactly the markup you want.
4. Clear caches (`drush cr`) so Drupal picks up the new template files.

If you would rather style with CSS than override markup, you can skip the Twig files
entirely and target the classes the default template already outputs
(`block-content--type-<bundle>`, `block-content--<id>`, and
`block-content--view-mode-<view_mode>`), with the fields wrapped in a
`block-content__content` container.
