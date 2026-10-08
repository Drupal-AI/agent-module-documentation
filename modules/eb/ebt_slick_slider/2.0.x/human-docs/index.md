# Extra Block Types (EBT): Slick Slider — manual setup guide

**Extra Block Types (EBT): Slick Slider** (`ebt_slick_slider`) adds a slider /
carousel block type built on the well‑known **Slick** JavaScript library. All the
Slick options — arrows, dots, autoplay, and responsive settings for mobile, tablet,
and desktop — are available in the block's settings. Because the slides are built on
Paragraphs and ordinary Drupal fields, you can adjust image sizes or add a lightbox
through the Fields UI.

It is part of the **Extra Block Types (EBT)** family, sharing the **EBT Core**
(`ebt_core`) base for common design options — spacing, background, borders, and
container width — and it also depends on **Paragraphs**. As a block type (not a
paragraph type) it can be placed in a region, dropped into a Layout Builder section,
or reused across pages.

A word on when to reach for this one: Slick is a long‑established **jQuery** library.
If your theme already loads Slick, this module reuses it and is the natural choice.
If your site has otherwise moved past jQuery, a sibling such as **EBT Slideshow**
(FlexSlider) avoids reintroducing that dependency. As with any carousel, verify the
accessibility basics — auto‑advance should be pausable, and the controls need
accessible names and keyboard operation.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, Composer install, and
   enabling the module.

## Where it lives in the admin menu

EBT Slick Slider adds no configuration page of its own. You use it by placing a
**Slick Slider** block: in **Layout Builder**, at **Structure → Block layout**, or
as a reusable block under **Content → Blocks → Add content block**.

## How to use it

1. Add a Slick Slider block through Layout Builder or Block layout.
2. Add your slides (each slide is a Paragraph, so add as many as you need).
3. Configure the Slick options — arrows, dots, autoplay, and the responsive settings
   — in the block form.
4. Set spacing, background, and container width using the shared **EBT Core** design
   options, then save and place the block.
