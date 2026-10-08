# Layout Builder + — manual setup guide

**Layout Builder +** (`lb_plus`) is a drop-in replacement for Drupal's core
Layout Builder interface, built around drag-and-drop, a block-placement sidebar,
and — the substantive addition — **nested sections**. Core Layout Builder is
capable; the part people complain about is its UI, where every operation is a
modal, sections cannot contain sections, and moving a block means a dialog rather
than a drag. Layout Builder + swaps that interface out for photoshop-like tools
to place, change, move, delete, and duplicate blocks directly on the canvas.

Nested sections are the reason most sites adopt it. Real page designs are columns
inside rows inside a full-width band, and expressing that in flat core sections
means either a custom layout plugin per arrangement or giving up — Layout Builder
+ makes nesting a first-class feature. It is part of the **+ Suite** page-building
family and is the "Edit Mode native" version of Layout Builder for that suite.

The dependency footprint is the thing to weigh before adopting. Layout Builder +
requires **`navigation_plus`** and **`tempstore_plus`** and shares
`navigation_plus`'s settings page, so bringing it in means adopting a small
family of modules that jointly replace parts of the editing experience — it is an
adoption decision, not a single module. It is also **Drupal 11 only** (no Drupal
10 path).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it and
   its `navigation_plus` / `tempstore_plus` dependencies, and pick the optional
   submodules.
2. [Configuration](configuration/index.md) — the permissions it adds and the
   shared + Suite settings page.

## Where it lives in the admin menu

Layout Builder + replaces the Layout Builder editing experience itself, so most
of your time is spent **on the layout canvas** of any Layout Builder–enabled
entity, not on a settings page. Its `configure` link points to the shared
**+ Suite** settings form (route `navigation_plus.settings`), which belongs to
the `navigation_plus` module it depends on. See
[Configuration](configuration/index.md) for details.

## How to use it

1. Enable the module and its dependencies (and any submodules you need).
2. Grant the relevant permissions (see Configuration) to the roles that build
   pages.
3. Open a Layout Builder–enabled entity and edit its layout — you now get the
   Layout Builder + canvas with drag-and-drop, the block sidebar, and nested
   sections.
4. Place, move, duplicate, and edit blocks in place; add nested sections to build
   columns-inside-rows arrangements without a custom layout plugin.
