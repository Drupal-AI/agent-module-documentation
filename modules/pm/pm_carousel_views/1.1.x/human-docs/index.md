# PM Carousel Views — manual setup guide

**PM Carousel Views** (`pm_carousel_views`) adds a **Views display style** that
renders the results of a View as a **PM Carousel** — the accessibility-focused
carousel/slider. Instead of a plain list or grid, a listing you build in Views can
be presented as an accessible carousel.

It is a content-display / Views feature and has no access-control role of its own:
the results always respect the View's own access settings. It depends on the **PM
Carousel Accessible Slider** module (`pm_carousel`) — which provides the carousel
library — and on core **Views**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside PM Carousel and Views.

There is **no dedicated configuration page** for this module. You configure it
entirely inside the Views UI, described in "How to use it" below.

## Where it lives in the admin menu

PM Carousel Views adds no settings page of its own. You use it from the **Views UI**
(**Structure → Views**), where "PM Carousel" becomes an available display **Format
/ style**.

## How to use it

1. Make sure **PM Carousel Accessible Slider** is installed (its JavaScript library
   must be present at `web/libraries/pm-carousel` — Composer installs it
   automatically).
2. Edit or create a View at **Structure → Views**.
3. In the View's **Format** section, change the display style to **PM Carousel**.
4. Configure the style's options, add your fields or rendered entities as the
   carousel items, and save. The View's results now render as an accessible
   carousel that respects the View's access rules.
