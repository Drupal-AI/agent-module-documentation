# matchmedia — manual setup guide

**matchmedia** (`matchmedia`) is a small compatibility shim. Drupal core once
shipped a `core/matchmedia` (and `core/matchmedia.addListener`) JavaScript asset
library — a polyfill for the browser `window.matchMedia()` / `MediaQueryList` API
used to test CSS media queries from JavaScript. Because every browser in Drupal's
support policy now supports `matchMedia` natively, core **deprecated** that library
in 8.8 and **removed** it in Drupal 9. This module **re‑provides** it, so a theme
or contrib module that still depends on `core/matchmedia` keeps working after you
upgrade core past 8.x, and so older browsers that lack native support still get the
polyfill.

The clever part is that it fixes the problem transparently. On top of shipping its
own `matchmedia/matchmedia` (and `.addListener`) library, it uses a core hook to
(a) drop the now‑absent `core/matchmedia*` libraries from the `core` extension, and
(b) rewrite any other library that still declares a dependency on `core/matchmedia*`
so it points at the module's replacement instead — without you editing that other
module.

There is **nothing to configure**: it has no settings page, no route, no
permission, and no service. Installing the module *is* the whole feature. When your
themes and modules no longer depend on `core/matchmedia`, you can simply uninstall
it again.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it. That is all there is to do.

## Where it lives in the admin menu

Nowhere — matchmedia adds no admin pages or settings. Its entire job runs
automatically once the module is enabled.

## How to use it

There is no ongoing usage. Enable it if you are upgrading a site whose themes or
modules still reference `core/matchmedia`, or if you need to support browsers
without a native `matchMedia`. If you hit a "matchmedia library not found" render
error after a core upgrade, enabling this module resolves it. Once every dependent
has been updated to stop using the old library, uninstall matchmedia.
