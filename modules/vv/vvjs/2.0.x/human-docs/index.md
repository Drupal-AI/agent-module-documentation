# Views Vanilla JavaScript Slideshow (VVJS) — manual setup guide

**VVJS** (`vvjs`) is an accessible, dependency-free slideshow **display format
for Views**. Set a view's format to *Views Vanilla JavaScript Slideshow* and each
result row becomes a slide — an image carousel, a testimonial rotator, a product
gallery, or a full-width hero slideshow with overlay text and calls to action.
The player is written in vanilla JavaScript (no jQuery, no external libraries) and
puts accessibility first: proper ARIA roles, a live-region announcer, full
keyboard navigation, touch/swipe support, and automatic pausing for
motion-sensitive users.

Because it's a Views format, you configure it entirely through the view's format
settings — there's no separate admin page. The options cover timing and autoplay,
navigation (arrows, dots, or numbers), entrance animations and crossfade
transitions, a hero mode with a positioned, tinted overlay, responsive behavior
across five breakpoints, deep-linking to a specific slide via the URL hash, and
niceties like a play/pause button, a progress bar, and an "X of Y" counter. A
small JavaScript API (`Drupal.vvjs.*`) lets custom code drive any slideshow on the
page.

The module builds on the `vvj_core` foundation module (installed alongside it) and
targets modern Drupal. It ships an optional example view you can learn from. If
you're upgrading from VVJS 1.x, version 2 is a drop-in replacement — the plugin
id, options, libraries, and CSS class names are unchanged.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set up the slideshow format on a
   view and tune every option.

## Where it lives in the admin menu

There is no dedicated settings page. You work entirely in the **Views UI**
(*Structure → Views*): set a view's **Format** to *Views Vanilla JavaScript
Slideshow* and configure its options there. Module help is at
**Help → Views Vanilla JavaScript Slideshow** (`/admin/help/vvjs`).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)); the
   `vvj_core` foundation module comes with it.
2. Create or edit a view, set **Format → Views Vanilla JavaScript Slideshow**, and
   set **Show → Fields** so each row becomes a slide.
3. Open the format settings and configure timing, navigation, transitions, hero
   mode, and responsive options — see [Configuration](configuration/index.md).
4. Save and place the view (as a page, block, etc.) wherever you want the
   slideshow.
