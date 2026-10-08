# Extra Block Types (EBT): Carousel — manual setup guide

**Extra Block Types (EBT): Carousel** (`ebt_carousel`) adds a **Carousel** block
type built on the lightweight **Tiny Slider** JavaScript library. Editors can
create a sliding, swipeable set of slides — images and content — and place it in a
page without touching code. It's a good fit for hero sliders, image showcases, or
any rotating banner.

It is part of the **Extra Block Types (EBT)** family, whose components are
provided as **block types** placeable in any region and in **Layout Builder** in a
few clicks. The shared design widget comes from the **EBT Core** (`ebt_core`) base
module. Because the carousel works with media slides, it also requires the
**Paragraphs** module and core **Media**, **Media Library**, and **Link**. It runs
on Drupal 10.1+, 11, and 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and its EBT Core, Paragraphs, and Media dependencies).

## Configuration

There is **no separate settings page** for this module. Like all EBT block types,
the Carousel is configured **per block instance** when you place it: you add the
slides (each with its media and optional link) and pick the Tiny Slider behaviour
on the block form, alongside the shared **Design** options (CSS box margins/
paddings/borders; background colour, image — including parallax and cover — or
YouTube video; edge-to-edge vs. container width) from the **EBT Core** widget. See
the [EBT Core project page](https://www.drupal.org/project/ebt_core) for more.

## How to use it

1. Edit a page with **Layout Builder**, or go to **Structure → Block layout**.
2. Click **Add block** and choose the **Carousel** block type.
3. Add your slides (choose media from the Media Library, add captions/links as
   needed), set the slider options, and adjust the shared Design options.
4. Save. The Tiny Slider carousel renders on the page.
