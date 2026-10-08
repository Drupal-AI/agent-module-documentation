# Glide.js — manual setup guide

**Glide.js** (`glidejs`) adds a **Views style plugin** that renders the results of
any View as a responsive, touch‑friendly **Glide.js carousel or slider**. Instead
of a table or an unformatted list, your view's rows become slides you can swipe
through. It's the quickest way to turn a list of content — featured articles,
products, testimonials — into a slideshow, entirely through the Views UI.

The plugin exposes Glide.js's main options right in the view's format settings:
choose between **slider** and **carousel** types, set how many **slides per view**,
turn on **autoplay** (with optional pause on hover), enable **keyboard
navigation** and **touch/swipe** with configurable thresholds, tune the
**animation duration and easing**, control **rewind and bound** behaviour, and
define **responsive breakpoints** so the carousel adapts across screen sizes.

Full details of every Glide.js option are in the
[Glide.js documentation](https://glidejs.com/docs/).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central settings form** for this module — all its options live on
each View's format settings, described in "How to use it" below.

## Where it lives in the admin menu

Glide.js adds no admin settings page of its own. You use it entirely from the
**Views** UI at **Structure → Views** (`/admin/structure/views`), where it appears
as a display format you can choose for a view.

## How to use it

1. Go to **Structure → Views** and add or edit a view.
2. In the view's **Format** section, change the display format to **Glide
   Carousel**.
3. Open the format **Settings** and configure the carousel:
   - **Type** — slider or carousel.
   - **Slides per view**.
   - **Autoplay** speed and **pause on hover**.
   - **Swipe / drag** options and thresholds.
   - **Animation duration** and **easing**.
   - **Rewind** and bound settings.
   - **Responsive breakpoints**.
4. Save the view and view the page — your results now display as a Glide.js
   carousel.
