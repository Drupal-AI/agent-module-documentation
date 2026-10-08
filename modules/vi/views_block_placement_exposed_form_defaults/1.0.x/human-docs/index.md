# Views Block Placement Exposed Form Defaults — manual setup guide

**Views Block Placement Exposed Form Defaults**
(`views_block_placement_exposed_form_defaults`) lets you set **default values for
a Views block's exposed filters at the moment you place the block** — either
through Block layout or Layout Builder. That means one reusable view can be
dropped onto many pages, each placement pre-filtered differently, without cloning
the view or writing any code.

Normally a Views block's exposed filters only get values when a visitor submits
the exposed form. This module changes that: in the Views UI you mark which of a
block display's exposed filters should be "customizable", and then, each time the
block is placed, the placement form shows those filters so a site builder can
type in default values. At render time the block loads already filtered by those
defaults, so visitors immediately see the relevant results (a "latest articles"
block defaulting to one content type, a products block pre-filtered to a
category, and so on).

It works by swapping the core Views Block display plugin for its own version, and
stores the two new pieces of data — which filters are customizable, and the
per-placement default values — as ordinary configuration on the view and on the
placed block. It has no admin page, permissions, or settings of its own, and
requires core's **Views** and **Block** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no settings page. You use it in two existing places: the **Views UI**
(when editing a view's Block display) and the **block placement form** (in Block
layout at `/admin/structure/block`, or when adding a view block in Layout
Builder).

## How to use it

There are two steps — first say which filters editors may default, then set the
defaults when you place the block.

**1. Mark filters as customizable (Views UI).** Edit your view and select its
**Block** display. Make sure the filters you care about are **exposed** (in
*Filter criteria*, use *Expose*). Then, in the block display's **"Allow
settings"** section, a new **"Customizable filters"** checkbox list appears —
tick the exposed filters that site builders should be able to give defaults to
when placing this block. Save the view.

**2. Set default values on placement.** Place that block the usual way — via
**Block layout** (`/admin/structure/block`) or as a **Layout Builder** block. The
block's configuration form now shows the exposed-filter fields for exactly the
filters you marked customizable. Enter the default values you want for *this*
placement and save. The block will render pre-filtered by those values, without
the visitor needing to submit the exposed form.

Reuse the same view in several places, each with its own defaults, to build
multiple "curated list" blocks from a single view. Any filters you did not mark
customizable are hidden from the placement form, so editors only see the ones you
chose to expose to them.
