# SlidesJS — manual setup guide

**SlidesJS** (Composer package `drupal/slidesjs`, **module machine name
`slidesjs_slider`** — note the two names differ) is a mobile-responsive image
slider you place as a block. It gives content editors a friendly interface for
building image carousels: upload images, add a title, description, and optional
link to each slide, reorder them, and drop the result into any region of your
site as a block.

The problem it solves is letting editors create good-looking, responsive image
carousels without touching code. Each slider is its own block instance, so you
can place several sliders in different regions and configure each one
independently — its own images, its own autoplay and navigation settings. The
carousel is responsive, touch-enabled (swipe on mobile), and built with
accessibility in mind (ARIA attributes, keyboard navigation, pause on
hover/focus, and reduced-motion support). It uses pure JavaScript for the
carousel behaviour, so there is **no external library to install**.

It depends on core's **Block**, **Image**, and **Media Library** modules, works
on Drupal 9, 10, and 11, and is a display feature only — slide images are chosen
by editors and the module has no access-control role. Note it is **not covered
by Drupal's security advisory policy**.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

SlidesJS works through the **Block layout** interface rather than a central
settings page:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. **Place** a SlidesJS slider block in the region where you want the carousel.
3. In the block's configuration form, **upload images** and, for each slide, set
   a title, description, and optional link. Add, remove, and reorder slides with
   the on-screen controls.
4. Adjust the display options — the single size control (which resizes the
   slider while keeping its aspect ratio), autoplay and its timing, and whether
   to show previous/next buttons and pagination dots.
5. Save the block. The carousel appears in that region, responsive and
   swipe-enabled on mobile.

Because each slider is a separate block, repeat these steps to add more sliders
elsewhere, each with its own images and settings.
