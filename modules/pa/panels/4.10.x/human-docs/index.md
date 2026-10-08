# Panels — manual setup guide

**Panels** (`panels`) is a region-based page layout engine. It lets you pick a
layout — one column, two columns, three columns, and so on — and then drop blocks
(Panels calls them "panes") into the named regions of that layout, reordering
them, styling them, and controlling when each one shows. It is the classic
alternative (and complement) to core's Layout Builder for building pages out of
reusable pieces.

The important thing to understand up front is that Panels is really an **API and
display engine, not a finished feature you click on**. On its own it provides no
end-user interface — it exposes a `panels_variant` display variant and the
plumbing behind it, and expects another module to drive it. In practice you pair
it with **Page Manager** (to route a page or override a system page through a
Panels display) or you enable the bundled **Panels IPE** submodule
(`panels_ipe`) to get an in-place, drag-and-drop editor on the front end. Because
of that, the module's own description warns that "at least one other Panels
module should be enabled."

Panels depends on **Chaos Tools (CTools)** and core's **Layout Discovery**
module, both of which Drupal pulls in automatically. It ships one submodule,
**Panels IPE**, which adds the JavaScript in-place editor.

A note on lifecycle: Panels is now **minimally maintained** and marked "no
further development." For brand-new Drupal 10/11 sites the community generally
recommends core **Layout Builder** instead. Panels remains valuable when you need
Page Manager routing or you are maintaining an existing Panels-based site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install Panels with Composer, enable
   it, and add Page Manager or the IPE submodule so you can actually build pages.

Panels itself exposes **no settings form**, so there is no separate configuration
page in this guide — everything happens while you build a display. See "How to
use it" below.

## Where it lives in the admin menu

Once enabled, Panels adds a **Panels Dashboard** at **Structure → Panels**
(`/admin/structure/panels`, route `panels.admin`). This is an overview/entry
point, not a settings form — the real page-building work happens through Page
Manager or the in-place editor.

## How to use it

Panels only comes to life through an implementing module:

- **With Page Manager** (from the CTools family) — create or override a page at
  **Structure → Pages**, add a variant, and choose **Panels** as the variant
  type. You then pick a layout for that variant and place blocks into its
  regions, with per-block visibility conditions, CSS classes, and caching.
- **With Panels IPE** — enable the `panels_ipe` submodule to edit a display
  directly on the rendered page: drag blocks between regions, add new block
  content inline, and switch layouts, all in the browser.

Either way, the building blocks are the same: a **layout** (from Layout
Discovery), the **regions** that layout defines, and the **blocks** you assign to
each region. Panels' permissions let you control who may configure pane access,
advanced settings, styles, caching, and locks.
