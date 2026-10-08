# Gutenberg Bootstrap Blocks — manual setup guide

**Gutenberg Bootstrap Blocks** (`gutenberg_bs_blocks`) adds three layout blocks —
**container**, **row**, and **column** — to the Gutenberg editor, so content
editors can build responsive Bootstrap grids directly inside a page instead of
writing markup or CSS classes by hand.

Drupal's Gutenberg editor gives you a block-based writing experience, but its
default blocks cover text and media well and layout barely. On a Bootstrap-based
theme that gap shows up the moment an editor wants to put two paragraphs side by
side. This module fills it: the container/row/column blocks emit Bootstrap's own
grid markup, so a layout composed in the editor inherits the theme's existing
responsive behavior automatically. A two-column row stacks on mobile because
Bootstrap says so — which is usually exactly what you want.

Two things are worth deciding up front. First, handing raw grid blocks to
editors is a design decision: it is powerful, but it is also how a site ends up
with three different ways to make two columns. If your theme already ships
component-style layout blocks, decide which editors should reach for. Second,
because the responsive behavior is Bootstrap's rather than the editor's, it is
worth showing editors what their layout does at mobile width — the editor canvas
is a desktop, and stacking only reveals itself on a narrow screen. This release
is **1.0.0-rc3**, a release candidate.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm Gutenberg is providing the editor.

There is **no configuration page** for this module. The blocks appear inside the
Gutenberg editor on any content type where the Gutenberg editing experience is
enabled; there are no site-wide settings to fill in.

## Requirements at a glance

- The [Gutenberg](https://www.drupal.org/project/gutenberg) editor module,
  version 2.x or newer, providing the editing experience.
- A front-end theme built on **Bootstrap 4.5 or newer**, so the grid markup the
  blocks produce actually renders as a grid.

## How to use it

1. Make sure the Gutenberg editing experience is enabled on the content type you
   want to edit (this is configured in the Gutenberg module — see its
   documentation for turning on "Gutenberg experience" per content type).
2. Edit or create a piece of content on that type. In the Gutenberg editor,
   insert a **Container** block, then add a **Row** inside it, and one or more
   **Column** blocks inside the row.
3. Drop your content (paragraphs, images, other blocks) into each column.
4. Preview the page at a narrow (mobile) width to confirm the columns stack the
   way you expect.
