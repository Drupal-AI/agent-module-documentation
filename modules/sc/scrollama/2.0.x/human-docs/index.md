# Scrollama — manual setup guide

**Scrollama** (`scrollama`) loads the lightweight
[scrollama.js](https://github.com/russellgoldenberg/scrollama) library and gives you a
simple `data-*`-attribute API for scroll-triggered animations ("scrollytelling"). As an
element scrolls to a fixed point in the viewport, the module toggles CSS classes on it — so
you can fade, slide, or otherwise animate content into view as the reader progresses down
the page, without writing any JavaScript.

The module ships two asset libraries: the behavior itself (which also pulls in scrollama
2.2.1 and an IntersectionObserver polyfill from a CDN), and a small stock stylesheet with
ready-made `fade-in`, `fade-out`, `slide-in`, and `slide-out` transitions. Both are **off
by default** — you either enable them globally on the settings page or, better for
production, attach them only where you need them from your own code.

This is a thin front-end helper. It provides no field, formatter, block, or entity — you
drive it from markup (`data-scroll-*` attributes) and CSS. A settings form lets you tune
when triggers fire and how they behave.

This guide is written for a **human** working through the setup. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — the settings form field by field, and the two
   ways to switch the library on.

## How to use it

Add the library where you want it (see [Configuration](configuration/index.md)), then mark
up the elements you want animated with `data-scroll-*` attributes:

- **`data-scroll-init="fade-in"`** — the class(es) to add when the element enters the
  trigger point. You can list several, e.g. `data-scroll-init="fade-in highlight"`.
- **`data-scroll-exit="fade-out"`** — optional class(es) to add when the element scrolls
  back out.
- **`data-scroll-delay="2"`** — optional delay, in seconds, before the enter classes are
  applied.

At runtime the behavior finds every element carrying `data-scroll-init`, sets up a single
scrollama scroller at the configured offset, and applies the classes on enter/exit. The
shipped stylesheet provides matching CSS for `fade-in`/`fade-out`/`slide-in`/`slide-out`, or
you can write your own classes and transitions. Turn on **debug** mode (see Configuration)
to draw the scroll line and log element data to the browser console while you tune things.
