# Breakpoint Javascript Settings — manual setup guide

**Breakpoint Javascript Settings** (`breakpoint_js_settings`) exposes your
theme's breakpoints to client-side JavaScript. It takes the breakpoint
definitions your theme registers — their min-width values and device mappings —
and writes them into `drupalSettings`, the object Drupal makes available to
front-end scripts on every page. Your JavaScript can then branch on the same
breakpoint definitions the theme and CSS use, instead of duplicating media-query
widths in JS.

The typical case: a script needs to know the current responsive breakpoint — to
load different behaviour on mobile versus desktop, drive a carousel's config,
toggle lazy-loading by viewport, or react to window resize — and you want a
single source of truth rather than pixel values scattered across the codebase.
This module makes the theme's `*.breakpoints.yml` that source of truth.

It depends on core's Breakpoint module and supports Drupal 8, 9, and 10. Which
values get exposed is not automatic guesswork — you define the min-width and
device mappings on an admin form, and the module serializes those into
`drupalSettings`.

This guide is written for a **human** setting the module up through the admin UI.
If you want a terse, token-cheap reference for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements (core Breakpoint),
   installing with Composer, and enabling the module.
2. [Configuration](configuration/index.md) — the settings form where you define
   the min-width and device mappings exposed to JavaScript.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Breakpoint JS**
(`/admin/config/system/breakpoint_js`), gated by the core **Administer site
configuration** permission.

## How to use it

Enable the module, open its settings form, and define the breakpoint min-widths
and device categories you want available to scripts. Once saved, the values appear
under `drupalSettings` on the page. In your JavaScript, read them from there (for
example to decide whether the current viewport is mobile, tablet, or desktop)
rather than hard-coding widths — keeping your JS breakpoints in sync with the
theme's CSS from one place.
