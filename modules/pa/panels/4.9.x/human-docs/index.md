# Panels — manual setup guide

**Panels** (`panels`) is a display engine that lays content out into the regions of
a chosen layout and places blocks (called *panes*) into those regions. It provides
the `panels_variant` display variant but **no page-building UI of its own** — you
pair it with **Page Manager** to route pages through it, or the bundled **Panels
IPE** submodule to edit layouts directly on the front end.

A Panels display holds three things: a **layout** (from core Layout Discovery — one
column, two column, and so on), the **regions** that layout defines, and the
**blocks** assigned to each region, each with its own visibility conditions, CSS
classes, and caching. It renders through a pluggable display builder, so the Panels
IPE submodule can swap in an in-place editor. Where a display's configuration is
stored is itself abstracted, and the bundled storage plugin keeps displays inside
Page Manager page variants.

Panels is a mature, flexible alternative (or complement) to core Layout Builder,
especially when you need Page Manager's route-level control. It depends on the
**CTools** and core **Layout Discovery** modules, ships block add/edit/delete forms
under `/admin/structure/panels`, and provides permissions that control who can
manage pane access, styles, caching, and locks. Because it is a toolkit rather than
a one-click feature, expect to enable Page Manager (or the IPE) and build your
displays there.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install Panels with Composer, enable it
   with a builder (Page Manager and/or Panels IPE).
2. [Configuration](configuration/index.md) — how a Panels display is built:
   choosing a layout, placing blocks into regions, and the in-place editor.

## Where it lives in the admin menu

Panels itself has no standalone settings screen. You build displays through:

- **Page Manager** — at **Structure → Pages** (`/admin/structure/page_manager`),
  where you add a **Panels** variant to a page.
- **Panels block forms** — under `/admin/structure/panels/…`, reached while editing
  a display.
- **Panels IPE** — an on-page editor on the rendered front end (once the submodule
  is enabled).

## How to use it

1. Install Panels and enable it together with **Page Manager** (and optionally the
   **Panels IPE** submodule) — see [Installation](installation/index.md).
2. Create a Page Manager page and add a variant of type **Panels**.
3. Choose a **layout** for the variant, then **place blocks** into its regions.
4. Save. The page now renders through Panels. For on-page editing, use the IPE. See
   [Configuration](configuration/index.md) for the full build flow.
