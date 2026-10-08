# Select Icons — manual setup guide

**Select Icons** (`select_icons`) provides a Form API select element that renders
its options with icons, built on top of the jQuery UI Selectmenu widget. A
dropdown where each option carries a small icon is easier to scan than a plain
list of text, and this module gives developers a clean way to build one using
nothing but Drupal's Forms API and some CSS.

This is a **developer-only** module — it adds no user-facing feature or admin
screen on its own. Instead it exposes a new element type, `select_icons`, that you
use in your own form definitions. You supply the options as usual, attach a
`data-class` attribute to each option (via `#options_attributes`), and provide the
CSS that turns those classes into icons — sprite sheets are recommended for
performance. At render time the module hands the element to jQuery UI's Selectmenu
to build the styled dropdown. It has no security surface: it simply styles a
select.

Because it is an API building block rather than a configurable feature, there is
no settings page and nothing to turn on beyond enabling the module and its one
dependency.

This guide is written for a **human** (here, a developer) setting the module up.
If you want terse references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

In a form, define an element with `'#type' => 'select_icons'`, give it `#options`
as normal, and attach a `data-class` to each option through `#options_attributes`
— those CSS classes are what the JavaScript uses when building the jQuery UI
Selectmenu. Then attach a library with the CSS that draws the icons for those
classes. For example, a color picker would map option keys to classes like
`color red`, `color green`, `color blue`, with matching CSS providing the swatches.
Consult the module's own examples for the exact array shape.
