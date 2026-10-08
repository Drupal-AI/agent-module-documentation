# Native Lazy Load Animation — manual setup guide

**Native Lazy Load Animation** (`native_lazy_load_animation`) adds a gentle
fade-in effect to images and iframes as they lazy-load into view. Since Drupal
9.1, core adds the native HTML5 `loading="lazy"` attribute to images so the
browser only fetches them when the visitor scrolls near them. This module builds
on that: it attaches a small CSS/JS asset library that watches for elements with
`loading="lazy"` and, once each one finishes loading, applies classes that fade
or reveal it smoothly instead of having it pop in abruptly.

The problem it solves is purely cosmetic but noticeable — lazy-loaded images
normally appear the instant they arrive, which can feel jarring on a long page.
This module smooths that transition with no markup changes on your part.

Note the naming quirk: the project is `nlla` on drupal.org, but the actual
module **machine name is `native_lazy_load_animation`** (that is what you enable
with Drush), while the Composer package is `drupal/nlla`. It has **no
dependencies and no configuration** — it works the moment you enable it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form.
Enable it and it works. To customise the effect, override the module's CSS in
your theme.

## How to use it

There is nothing to click. Once enabled, any image or iframe that already
carries `loading="lazy"` gets the extra classes needed for the fade-in effect
automatically, site-wide. If you want a different animation, copy the module's
CSS into your theme and adjust it there.
