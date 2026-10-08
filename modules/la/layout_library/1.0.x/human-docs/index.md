# Layout library — manual setup guide

**Layout library** (`layout_library`) lets site builders save reusable Layout
Builder layouts as named "layouts" that content authors can then pick from a simple
dropdown when editing a page. Instead of giving every author a blank Layout Builder
canvas, you build a set of approved page templates once, and authors choose the
right one per item — a much safer, more consistent way to let non‑technical editors
do page building. It is an extension of core's Layout Builder.

Site builders manage the library at **Structure → Layout library**. You add a
layout, choose which entity type and bundle it applies to, then arrange its sections
and blocks in the normal Layout Builder interface. Each saved layout is scoped to a
specific type/bundle, so authors only ever see the templates that match what they
are editing.

To expose the library to authors on a given content type, you tick a checkbox
(**"Allow content editors to use stored layouts"**) on that bundle's *Manage
display* for a Layout‑Builder‑enabled view mode. Doing so automatically adds a
**"Layout"** select field to the content form. When an author picks a layout, its
sections are copied onto their page as a starting point, which they can then
customise further with Layout Builder overrides.

> **Note:** Layout library is a **beta** release with an open to‑do list. It works,
> but treat it as not yet production‑hardened, and test it against your workflow
> before relying on it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   (Layout Builder is required).
2. [Configuration](configuration/index.md) — create reusable layouts, enable the
   library on a bundle, and let authors pick one.

## Where it lives in the admin menu

- The layout library itself is at **Structure → Layout library**
  (`/admin/structure/layouts`).
- The "Allow content editors to use stored layouts" checkbox lives on each bundle's
  **Manage display** for a Layout‑Builder‑enabled view mode.
