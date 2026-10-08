# Easy Carousel — manual setup guide

**Easy Carousel** (`easy_carousel`) is the lightweight way to add a **carousel /
slider** to a Drupal site — a rotating strip of images or content — without adopting
a full component framework. You build carousels and their slides as content, then
drop a block into a region to display one. It ships several ready‑made styles:
a **Simple** carousel (media on top, content below), a **Bootstrap**‑styled
carousel, a **Brands** carousel (an infinite scroll strip, the kind used for logos),
and a **Gallery** carousel. You can tune many properties per block — show or hide
controls and indicators, height, transition speed, colours, and more. There's even
an export/import feature to back carousels up to a zip file.

It helps to know there are two broad ways to add a carousel in Drupal, and this is
the lighter one. The heavier "framework" route (paragraph types, Layout Builder
components, the EPT/EBT families) gives editors a placeable component with rich
settings, at the cost of a dependency tree and a new way of building pages. Easy
Carousel instead uses **content entities plus a block**: less to learn, quicker to
stand up, and correspondingly less fine‑grained control over exactly where and how
it appears. It depends on core's **Field** and **Media** modules and requires
**Drupal 11**.

A candid word on carousels in general, so you use it where it pays off: engagement
past the first slide is consistently very low, auto‑advancing content moves while
people are trying to read it (an accessibility problem), and on mobile a carousel
tends to push real content below the fold. Easy Carousel is a great fit for a
visitor‑driven **gallery of photographs**, where flipping through the images *is* the
point. It's a poor fit as a way to give several teams equal billing on a homepage —
the slides after the first are largely unseen.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no central settings form** — you build carousels as content and configure
each one where you place its block, as described below.

## How to use it

1. **Create carousel items.** Go to **Content → Carousels Items** and create the
   individual slides, customising each one.
2. **Create a carousel.** Go to **Content → Carousels**, create a new carousel
   entity, and add the items that should appear in it.
3. **Place the block.** Add a new **Easy Carousel** block to the region where you
   want the carousel to appear, choose the carousel you created, and configure its
   display properties (style, controls, indicators, height, transition speed,
   colours, and so on).

That's the whole flow — no paragraph types or component model to set up.

## Backing up: export / import

Easy Carousel can export your carousels and their items to a **zip file** as a
backup, which you can import later. **Be careful:** importing a zip **deletes all
existing carousels and items** first, replacing them with the file's contents — so
only import into an environment where you intend to overwrite what's there.
