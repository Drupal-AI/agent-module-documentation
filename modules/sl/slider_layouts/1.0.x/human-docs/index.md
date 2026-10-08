# Slick Layouts — manual setup guide

**Slick Layouts** (`slider_layouts`) lets content editors build carousel
sections right inside Layout Builder. Instead of every block on a page stacking
vertically, it adds a new **Slider Section** layout: the blocks you place into
that section become the individual slides of a rotating carousel. It uses the
popular **Slick** JavaScript library to power the sliding behaviour.

The problem it solves is a common one — you want a rotating banner, a set of
featured cards, or a testimonial carousel, and you want editors to manage it
visually through Layout Builder rather than hand-coding markup. With this module
they simply add a Slider Section and drop blocks into it; each block is a slide.

It is a content-display and layout feature only. The content shown inside the
slides comes from the blocks and fields you place there (and those keep their
own access rules), so the module itself has no access-control role. It depends
on core's **Layout Discovery** module, works on Drupal 9, 10, and 11, and is
covered by Drupal's security advisory policy. Note that the Slick JavaScript
library is a third-party dependency you need to make available (see
Installation).

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   provide the Slick library, and enable it.
2. [Configuration](configuration/index.md) — the slider settings form and how to
   place a Slider Section in Layout Builder.

## Where it lives in the admin menu

The module exposes a slider settings form at the route
`slider_layouts.slider_settings`. Beyond that, the real work happens in **Layout
Builder** — wherever you manage a layout (for example on a content type's
**Manage display** screen or on an individual node's layout), you add a **Slider
Section** and place blocks inside it to create the carousel.
