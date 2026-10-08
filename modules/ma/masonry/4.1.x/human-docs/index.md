# Masonry API — manual setup guide

**Masonry API** (`masonry`) is a bridge between Drupal and David DeSandro's
**Masonry** and **imagesLoaded** JavaScript libraries — the ones that produce a
Pinterest-style "cascading grid" where tiles of different heights pack neatly
together without leaving big gaps. It gives your site the plumbing to attach a
configured Masonry layout to any grid of items and re-layout it on resize or as
images load.

The important thing to understand up front: **Masonry API has no user interface of
its own.** It is a *developer/integration API*. It ships no settings form, no
permissions, no blocks, and no Views style. On its own it does nothing visible —
it exists so that *other* modules and custom code can add Masonry layouts. Most
site builders never use it directly; instead they install a companion module such
as **Masonry Views** (a separate download), which gives Views a "Masonry" display
style and uses this module under the hood.

So there are really two audiences:

- **Site builders** who installed this because something else depends on it. Your
  only job is the one setup step below: put the two JavaScript libraries on disk.
  Then configure your Masonry grids in whatever module actually provides the UI
  (e.g. Masonry Views).
- **Developers** who want to attach a Masonry grid from their own code. You call
  the `masonry.service` service's `applyMasonryDisplay()` method on a render
  array, or embed its ready-made settings form fragment in your own plugin. The
  sibling [`agent/`](../agent/start.md) docs describe that service, its fifteen
  options, and the three alter hooks in full.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and,
   crucially, put the Masonry and imagesLoaded JavaScript libraries on disk.

## Where it lives in the admin menu

Nowhere. Masonry API adds no admin pages, permissions, or menu items. The only
setup it needs is the two JavaScript libraries described in
[Installation](installation/index.md); everything else is done by the module or
code that consumes it.

## How to use it

Masonry API does not create grids by itself. In practice you use it one of two
ways:

- **Through another module.** Install and configure something like *Masonry
  Views*, which adds a Masonry option to a Views display. That module's settings
  form is actually Masonry API's own settings fragment (column width, gutter,
  animation, "wait for images", RTL, stamped items, and so on), so the options you
  see there come straight from this module.
- **From your own code.** Fetch the service and apply it to a render array:

  ```php
  \Drupal::service('masonry.service')->applyMasonryDisplay(
    $build,
    '.my-grid',        // container selector
    '.my-grid > li',   // item selector
    ['layoutColumnWidth' => '250px', 'gutterWidth' => '10px', 'isLayoutFitsWidth' => TRUE],
  );
  ```

  See the [`agent/`](../agent/start.md) docs for the full option list and hooks.

Either way, the layout only appears once the two JavaScript libraries are present
on disk — that is the one thing you must not skip.
