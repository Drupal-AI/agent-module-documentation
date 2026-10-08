# Extra Block Types (EBT): Video and Image Gallery — manual setup guide

**Extra Block Types (EBT): Video and Image Gallery** (`ebt_video_and_image_gallery`)
adds a gallery block that mixes **videos and images** in a grid, each opening
full‑size in a **GLightbox** lightbox (with media‑video support). It is the block to
reach for when a portfolio, product gallery, or event page needs both photos and
video clips together. Enable the module and the gallery block type is ready to place.

It is part of the **Extra Block Types (EBT)** family, sharing the **EBT Core**
(`ebt_core`) base for common design options — spacing, background, borders, and
container width. Beyond EBT Core it depends on core **Media**, the **GLightbox** and
**GLightbox Media Video** modules (for the lightbox and its video support), and
**Paragraphs**. It is a presentation block: it controls the grid and lightbox, while
the underlying media and their access are unchanged.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, Composer install, and
   enabling the module.

## Where it lives in the admin menu

This module adds no configuration page of its own. You use it by placing a **Video
and Image Gallery** block: in **Layout Builder**, at **Structure → Block layout**, or
as a reusable block under **Content → Blocks → Add content block**.

## How to use it

1. Add a Video and Image Gallery block through Layout Builder or Block layout.
2. Add your gallery items — images and videos (each is a Paragraph item, so add as
   many as you need).
3. Set spacing, background, and container width using the shared **EBT Core** design
   options, then save and place the block. On the rendered page, thumbnails open
   full‑size in the GLightbox viewer.
