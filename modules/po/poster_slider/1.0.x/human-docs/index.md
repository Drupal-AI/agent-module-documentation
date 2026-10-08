# Poster Slider — manual setup guide

**Poster Slider** (`poster_slider`) lets you build image/poster **sliders** — configurable
slideshows and carousels such as hero banners and promotional strips — to showcase featured
content on a page. Each slider is a "Slider" entity you create in the admin UI, choosing a
slider type and adding a name and image, and it is then placed on the page as a block.

The module depends only on Drupal core's **Options** and **User** modules and supports
Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

Poster Slider has no central settings form — you create slider entities and then place them
as blocks. See "How to use it" below.

## How to use it

1. From the administration menu, open **Poster Slider** and click **Add new poster**.
2. Fill in the **name**, choose the **slider type**, add the **image**, and **save**.
3. **Clear the Drupal cache** so the new slider's block becomes available.
4. Go to **Structure → Block layout** (`/admin/structure/block`), find your slider block, and
   **place it in the region** where you want the slider to appear.

Repeat to create as many sliders as you need, placing each one in the region that suits your
layout.
