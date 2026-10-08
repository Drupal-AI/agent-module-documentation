# Foundation Layouts — manual setup guide

**Foundation Layouts** (`foundation_layouts`) supplies a set of layouts built on the
**ZURB Foundation** grid system, ready to use anywhere Drupal's layout API is
available — Layout Builder, Display Suite, Panels, or any tool that consumes layout
plugins. If your site is themed with Foundation, these layouts let editors build
multi‑column arrangements whose markup uses Foundation's own grid classes, so the
output matches your framework instead of fighting it.

Layout Builder and the layout plugin system need layouts to place content into, and
the choice of available layouts shapes what editors can construct. Out of the box
Drupal ships a handful of generic layouts; Foundation Layouts adds Foundation‑grid
versions so that a page assembled in the UI produces Foundation‑correct responsive
markup with no custom code.

The one adoption note worth stating plainly: this module *assumes Foundation*. The
grid classes it emits are Foundation's, so on a theme that is not Foundation‑based
the layouts will render structurally but without their intended responsive grid
behaviour until those classes are given meaning. It's a theming‑layer building
block and has no security surface of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside core's Layout Discovery.

This module has **no settings page**. Once enabled, its layouts simply appear in the
layout picker wherever you use Drupal layouts — see "How to use it" below.

## Where it lives in the admin menu

There is no configuration form. The layouts show up automatically in any UI that
uses the layout API — most commonly **Layout Builder** (on a content type's *Manage
display*, or per‑entity), and in **Display Suite** or **Panels** if you use those.

## How to use it

1. Confirm your active theme is a **ZURB Foundation** theme, or otherwise applies the
   Foundation grid classes, so the layouts render with their intended responsive
   behaviour.
2. Enable a layout tool if you haven't already — for example turn on **Layout
   Builder** for a content type under **Structure → Content types → *(type)* →
   Manage display**.
3. When you add a section, the Foundation grid layouts now appear in the list of
   available layouts alongside Drupal's defaults. Pick one and place your blocks or
   fields into its regions.

> **Tip:** The module pairs especially well with Display Suite and Panels, which
> also consume the layout plugin system, so the same Foundation grids are available
> across all of them.
