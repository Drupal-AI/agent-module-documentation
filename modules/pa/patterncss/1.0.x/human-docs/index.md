# Pattern.css — manual setup guide

**Pattern.css** (`patterncss`) integrates the
[Pattern.css](https://bansal.io/pattern-css) library into Drupal — a tiny,
CSS‑only library (under 1KB minified and gzipped, no JavaScript) that fills empty
backgrounds with decorative patterns. Once the module is enabled, you can use any
of the library's patterns directly in your own modules and themes by applying its
CSS classes. Available patterns include checks, grids, dots, cross dots, diagonal
lines, vertical and horizontal lines, diagonal/vertical/horizontal stripes,
triangles, and zigzags, and the library gives you full colour control.

It's purely a theming/presentation helper. The patterns are plain CSS, so the
module has no content or access‑control role, and — unlike many library
integrations — you don't need to download anything: the Pattern.css library is
already bundled with the module.

This guide is written for a **human** working in a theme or module. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

The base module has **no settings form** — you use it by applying CSS classes in
your markup, so there's no configuration chapter. (Pattern.css also has a separate
*PatternCSS UI* companion project that offers a point‑and‑click "add pattern" form;
that is a distinct module, not part of this package.)

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Apply the Pattern.css classes to your markup in a theme template, block, or
   module output — for example a container element that should carry a dotted or
   striped background.
3. Use the library's colour controls to match the pattern to your design.

Refer to the [Pattern.css documentation](https://bansal.io/pattern-css) for the
full list of class names and options.
