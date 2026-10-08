# Smart Imaging Styles — manual setup guide

**Smart Imaging Styles** (`sis`) serves *layout-aware* responsive images. Core's
responsive images pick a variant based on the browser view-port, but on a modern
Drupal site the same image can be placed by Layout Builder into a narrow sidebar
one day and a full-width hero the next — and the view-port never tells the browser
which one it is. Smart Imaging Styles closes that gap: it loads a small low-res
image first, then uses JavaScript to measure the actual size of the element the
image sits in and requests the best-fitting variant for that real, on-page size.

The result is that visitors download an image sized for where it genuinely
appears — the right crop and the right number of kilobytes for a thumbnail, a grid
cell, or a banner — instead of one fixed size for every context. Think of it as
Drupal's responsive-image formatter "on steroids." It builds directly on core's
Responsive Image module and depends only on core Responsive Image and System.

The module pairs especially well with on-the-fly imaging services such as Thumbor
or Cloudinary, which can generate the needed derivative (including smart, face-aware
cropping) on demand — but it is not required to use one. There are no submodules,
and it plays no content or access-control role: it only governs which image variant
is shown.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form and how you apply
   layout-aware styles to your image displays.

## Where it lives in the admin menu

The module adds a settings form (the `sis.settings` config route) reachable from
Drupal's **Configuration** area once the module is enabled. Day to day, though, you
work with Smart Imaging Styles the same way you work with core responsive images:
you choose it as the **field formatter** for an image or media field on a content
type's *Manage display* screen, so the layout-aware behavior kicks in wherever that
image renders.
