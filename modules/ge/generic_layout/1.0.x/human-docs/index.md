# Generic Layout — manual setup guide

**Generic Layout** (`generic_layout`) provides a single, highly customizable and
responsive **Layout plugin** with arbitrary regions. Where a normal layout
plugin gives you a fixed set of regions (two columns, three columns, and so on),
Generic Layout lets you define the regions — and how they respond across
breakpoints — per layout instance, using the CSS Grid model. In practice that
means one flexible layout can stand in for a whole collection of fixed ones.

The layout's settings form surfaces CSS Grid features in an assisted, more
user‑friendly way, and the CSS itself is generated dynamically for each layout
instance and attached as a cacheable library. Spacing controls like margin,
padding, and gap don't come from Generic Layout directly — they come from
**UI Styles** (part of the UI Suite), which Generic Layout builds on. Generic
Layout concentrates on the grid, its modulation across breakpoints, and a clean
interface to Drupal's Layout API and backend.

It's a site‑building tool with no content or access‑control role of its own. It
depends on core's **Layout Discovery** (`layout_discovery`) and the **UI Styles**
(`ui_styles`) module, and it works with **Layout Builder**.

One quirk worth knowing up front: because each layout generates its own CSS
library, a new layout instance only becomes fully discoverable after you **save
the entity once**. If a layout's styling doesn't appear immediately, save and
reload.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

There is **no standalone configuration page** for this module. You configure each
layout where you use it — in Layout Builder's layout settings — as described
below.

## Where it lives in the admin menu

Generic Layout adds no central settings page. It appears as a layout **option**
wherever Drupal lets you choose a layout — most commonly in **Layout Builder**
(on a content type's *Manage display*, or when laying out an individual entity).
Its per‑layout settings form is shown when you add or configure a Generic Layout
section there.

## How to use it

1. Enable Layout Builder for the entity or view mode you want to lay out
   (**Structure → Content types → *(type)* → Manage display**, then turn on
   *Use Layout Builder*).
2. Add a section and choose **Generic Layout** as its layout.
3. In the layout's settings, define the regions and configure the CSS Grid
   behaviour — including how it responds across breakpoints. Use **UI Styles**
   options for margin, padding, gap, and other styling.
4. Place your blocks/fields into the regions you defined, then **save**.
   Remember that a brand‑new layout instance becomes fully discoverable only
   after that first save.
