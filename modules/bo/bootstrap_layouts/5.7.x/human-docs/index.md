# Bootstrap Layouts — manual setup guide

**Bootstrap Layouts** (`bootstrap_layouts`) adds a set of ready-made Bootstrap
grid layouts — rows with one, two, three, or four responsive columns — to
Drupal's core Layout system. Once the module is enabled, those layouts show up
anywhere the Layout system is used: **Layout Builder**, **Display Suite**, and
**Panels / Page Manager**. Instead of writing your own grid markup, you pick a
Bootstrap layout and Drupal renders the correct `.row` / `.col-*` wrappers for
you.

The module ships eleven layout plugins covering the common column
arrangements, plus "stacked" variants that add full-width top and bottom regions
around the columns and "bricked" variants that interleave full-width bands
between rows. Every layout has a configuration form (exposed by whichever tool
you place it in) where you can set each region's column width, choose extra CSS
classes, change the wrapper element (for example from a `div` to a `section` or
`article`), and add custom HTML attributes. There is **no admin settings page of
its own** — the layouts simply become available, and their settings are stored
per display by the tool that renders them.

Bootstrap Layouts depends only on core's **Layout Discovery** module (Drupal
enables it automatically). It has no permissions and no submodules. One
important caveat: the module generates Bootstrap grid *classes* but does not ship
Bootstrap's CSS — you need a **Bootstrap-based theme** (or a theme that provides
the `.row` / `.col-*` grid classes) for the columns to actually lay out
side by side.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no separate configuration page for this module — see *How to use it*
below, since all settings live inside the layout tools themselves.

## Where it lives in the admin menu

Bootstrap Layouts has **no menu item and no settings form**. Enabling it simply
registers its layouts. You will encounter them inside whichever layout tool you
use:

- **Layout Builder** — under *Structure → Content types → (a type) → Manage
  display*, when you enable Layout Builder and click *Add section*, the Bootstrap
  layouts appear in the layout list.
- **Display Suite** — when choosing a layout for a view mode.
- **Panels / Page Manager** — when picking a layout for a variant.

## How to use it

1. Open one of the layout tools above and add a new section / choose a layout.
2. Pick a Bootstrap layout — for example a two‑column (`bs_2col`) or
   three‑column (`bs_3col`) row, or one of the *stacked* / *bricked* variants.
3. In the layout's settings form, set each region's **column width** by picking a
   class such as `col-md-8` / `col-md-4` from the classes select. Combine
   breakpoints (for example `col-sm-12` plus `col-md-6`) to make columns stack on
   small screens and sit side by side on larger ones.
4. Optionally use `hidden-xs` / `visible-lg` classes to show or hide a region at
   a breakpoint, change a region's wrapper element, add utility classes like
   `bg-primary` or `text-center`, or add a `clearfix`.
5. Add custom HTML attributes to the layout or a region if you need them (for
   example `id|hero,role|banner`). Token values are supported here when the
   Token module is installed.
6. Place your content blocks / fields into the regions and save.

Because the layouts build on core Layout Discovery, anything you configure is
stored by the tool you used it in (a Layout Builder section, a Display Suite view
mode, or a Panels variant). Developers can register extra class options with
`hook_bootstrap_layouts_class_options_alter()` or define their own Bootstrap
layout — see the [`agent/`](../agent/start.md) docs for those APIs.
