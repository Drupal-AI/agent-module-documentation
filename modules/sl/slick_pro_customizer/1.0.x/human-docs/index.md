# Slick Pro Customizer — manual setup guide

**Slick Pro Customizer** (`slick_pro_customizer`) lets you configure
[Slick](https://kenwheeler.github.io/slick/) carousels directly from a Drupal
block, without editing templates by hand. You add a **Slick Pro Customizer**
block, and inside that single block you can define and manage several carousels at
once, each with its own options for desktop and mobile.

The idea is to make carousel theming and integration approachable for site
builders. You point each carousel element at the CSS selector of the markup you
want to turn into a slider, set how it should behave, and the block takes care of
attaching the JavaScript library and passing your settings through to the
front-end (via `drupalSettings.slickProCustomizer`) so the targeted carousels pick
them up. It is a front-end/theming feature: it configures a JavaScript carousel
and has no content or access-control role. It is fully compatible with the core
Slick module and runs on Drupal 10 and 11.

Because everything is configured on the block, there is no separate admin settings
page. It works once you place the block and configure at least one carousel
element.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Place and configure the block:

1. Go to **Structure → Block layout** (`/admin/structure/block`) and place the
   **Slick Pro Customizer** block in the region where your carousel markup lives.
2. In the block configuration you get a table of carousel elements. You can **add
   or remove** elements right there — the form rebuilds itself dynamically as you
   add more — so one block can drive several carousels.

For each carousel element you set:

**Primary options**

- **CSS selector** — targets the markup you want turned into a carousel.
- **Slides to show** — how many slides are visible on **desktop** and on
  **mobile** (set separately).
- **Autoplay** — a toggle, plus the autoplay **speed**.
- **Transition speed** — how fast slides animate.

**Secondary options**

- **Dots** and **arrows** — enable or disable the navigation dots and prev/next
  arrows.
- **Infinite looping** — whether the carousel loops back to the start.
- **Custom arrow HTML** — supply your own previous/next arrow markup.
- **Center mode** — enable centred slides, with configurable padding for desktop
  and mobile.

Save the block. The module attaches the carousel JavaScript and hands your
settings to it, so the targeted elements become working Slick carousels — no
template edits required.
