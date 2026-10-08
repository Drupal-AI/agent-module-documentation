# MO.JS — manual setup guide

**MO.JS** (`mojs`) integrates the [mo.js](https://mojs.github.io/) motion-graphics
JavaScript library into Drupal. mo.js is a fast, retina-ready, modular animation
library with a declarative API for building shapes, bursts, swirls and staggered
effects. This module makes the library available to your site so that themes and
custom modules can attach it and create rich, performant front-end animations
without bundling the library themselves.

It is purely a **library integration** — it adds no content, no blocks, and no
admin pages of its own. There is nothing to configure: once the module is enabled,
the mo.js library is available to be attached where you need it. The actual
animations are written in your theme's or module's JavaScript against the mo.js
API.

MO.JS works on Drupal 8.8 through 11 and has no other module dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form.

## How to use it

MO.JS registers the mo.js library so it can be attached to a page. In your own
theme or module, attach the library the usual Drupal way — for example from a
`*.libraries.yml` dependency or with `#attached['library']` on a render array —
and then write your animation code against the mo.js API. Because it is a
developer/themer tool, there is nothing to click through in the admin UI beyond
enabling the module.

> **Note:** at the time of writing this is a beta release (`1.0.0-beta2`).
