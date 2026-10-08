# PM Carousel Accessible Slider — manual setup guide

**PM Carousel Accessible Slider** (`pm_carousel`) integrates the **PM Carousel**
JavaScript library — an accessibility-focused slider/carousel — into Drupal. Its
job is to make the library available so your content can be presented as a
carousel that is keyboard- and screen-reader friendly.

The module is a presentation/content-display feature: the carousel content comes
from the page, and the module has no access-control role of its own. On its own it
provides the library integration; two companion modules build on it —
[PM Carousel Views](https://www.drupal.org/project/pm_carousel_views) renders View
results as a carousel, and
[PM Carousel + Tobii Lightbox](https://www.drupal.org/project/pm_carousel_tobii)
opens carousel images in a lightbox.

One important setup detail: PM Carousel depends on an external JavaScript library
that must be present on disk. When you install the module with Composer, the
library files are fetched automatically from the maintainers' mirror fork into
`web/libraries/pm-carousel`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its JavaScript
   library with Composer, then enable it.

There is **no configuration page** for this module — it has no settings form. Use
it together with **PM Carousel Views** or **PM Carousel + Tobii Lightbox** to
actually render carousels.

## Where it lives in the admin menu

PM Carousel adds no admin page. It simply registers the carousel library so other
modules (and your theme) can use it.
