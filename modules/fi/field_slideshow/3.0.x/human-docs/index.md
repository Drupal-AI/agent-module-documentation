# Field Slideshow — manual setup guide

**Field Slideshow** (`field_slideshow`) adds a **Slideshow** display format for
core Image fields. Point a multi‑value image field at it and, instead of stacking
the images down the page, Drupal renders them as an animated slideshow powered by
the jQuery Cycle2 library — with configurable transitions, timing, an optional
pager (thumbnails or a numeric counter), prev/next controls, and optional
Colorbox lightbox links.

You choose it per display, on an entity's **Manage display** tab, exactly like any
other field formatter. There's no global settings page and no permissions — all
the options live in the formatter's own settings, so a "hero rotator" on the front
page and a "product gallery" on a product type can use completely different timing
and effects from the same module.

One important setup detail: the Cycle2 JavaScript library is **not** bundled with
the module and is **not** pulled in by Composer. You have to download it yourself
and place it in your site's `libraries/` directory (see the installation guide).
Until you do, the field will simply render its images without the slideshow
behavior.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and add the required Cycle2 library.

## Where it lives in the admin menu

There is no dedicated settings page. You configure everything from **Structure →
Content types → *(your type)* → Manage display** (`admin/structure/…/display`):
set an Image field's format to **Slideshow**, then click the gear/cog icon to open
its settings.

## How to use it

1. Make sure the field is an **Image** field that can hold more than one value
   (its cardinality is a field‑storage setting).
2. On **Manage display**, change that field's **Format** to **Slideshow** and open
   the cog to reveal the options.
3. Under **Slideshow settings** you control the Cycle2 behavior — the transition
   effect (`fade`, `fadeout`, `scrollHorz`, `none`), the `speed` (how long a
   transition takes, in ms), the `timeout` (time between slides, in ms), plus
   options like `pauseOnHover`, `random`, `reverse`, `startingSlide`, and touch
   `swipe`.
4. Under **Pager** you decide whether a pager appears **before**, **after**, or
   both, pick the **pager type** (**Thumbnails** or **Counter**), and toggle the
   **Prev/Next controls**. The pager only shows when the field has more than one
   image.
5. If the optional **Colorbox** module is installed, an extra image‑link option
   turns each slide into a Colorbox gallery link, with its own image style.

Your choices are saved on the display configuration and take effect on the next
page render. Advanced users can add their own pager style (for example, dots) by
implementing a small `field_slideshow_pager` plugin — see the
[agent docs](../agent/plugins/pager.md) for the plugin interface.
