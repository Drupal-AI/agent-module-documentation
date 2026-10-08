# Basic Slider — manual setup guide

**Basic Slider** (`basic_slider`) is a lightweight image slideshow you place on
the page as a block. It is meant for the simple cases — a rotating hero banner or
a small image carousel — where a full media/slideshow framework would be
overkill.

It depends only on core's **Block** module. It ships its own small JavaScript
library to drive the transitions and a Twig template for the markup, and it
brings no third‑party slideshow library along with it. You add its block to a
region, configure the images in the block's settings, and the CSS/JS load only
where the block actually renders. There are no fields or media types to set up
first.

The module is intentionally minimal — it is a good, readable starting point when
you just need rotating images, and a fine companion to heavier slider modules
when you only need the basics.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

Basic Slider has no settings page of its own. Everything is configured on the
block itself, through **Structure → Block layout** (`/admin/structure/block`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Block layout**.
3. Choose **Place block** in the region where you want the slider, and pick the
   **Basic Slider** block.
4. In the block configuration form, add the images/slides you want to rotate,
   then save.
5. The slider renders in that region, animating its transitions client‑side; its
   CSS and JavaScript are attached only on the pages where the block appears.
