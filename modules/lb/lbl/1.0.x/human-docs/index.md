# Layouts (lbl) — manual setup guide

**Layouts** (`lbl`) adds a set of configurable, responsive default layouts to
Drupal's Layout Builder. It registers a group of layout plugins, declares
breakpoints, and ships a CSS generator that emits a per-layout CSS grid driven by
your theme's breakpoints — so a section can present different column arrangements
at different viewport sizes. The generated CSS is injected inline into the page
head.

The distinctive part is the **per-layout variants**: for a given layout you can
define several display maps (for example a "big left side," a "big right side,"
and a stacked "below" arrangement) and assign a different variant per breakpoint.
That lets you compose responsive pages from provided layouts without writing
bespoke CSS for each arrangement. It is a pure site-building/presentation helper —
layouts, templates, and generated CSS only, with no routes or entities — so block
placement is governed entirely by core Layout Builder access. It supports Drupal
9 and 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has **no configuration page** in the admin UI. Its "configuration" is
done in code and CSS — defining layout variants and setting breakpoints in your
front-end theme, described below.

## Where it lives in the admin menu

There is no dedicated settings page (`configure` is null). The module's layouts
appear as layout choices inside **Layout Builder**, alongside core's layouts.

## How to configure it (in your theme and layout definitions)

Because there is no settings form, you tune Layouts through your theme and layout
definitions:

- **Breakpoints** — define the breakpoints in your front-end theme. The module
  ships its own breakpoints (copied from the Bootstrap module) that are used only
  as a fallback, so defining your own in the theme is what makes the responsive
  behaviour match your design.
- **Layout variants** — to define your own variants, add a layout definition with
  an `icon_map` and a `variants` list, where each variant supplies a display
  `map`. For example, a two-column layout can offer `default`, `left` (big left
  side), `right` (big right side), and `below` (stacked) variants, each mapping
  regions differently.
- **Grid gap** — override the default gap between grid cells with a CSS custom
  property in your theme:

  ```css
  :root {
    --lbl-gap: 30px;
  }
  ```

## How to use it

1. Enable the module.
2. Edit a Layout Builder layout, add a section, and choose one of the layouts this
   module provides.
3. Pick the variant(s) you want per breakpoint, and place blocks into the
   regions. The generated grid CSS handles the responsive arrangement.
