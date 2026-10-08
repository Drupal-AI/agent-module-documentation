# Image slider — manual setup guide

**Image slider** (`image_slider`) lets you build image sliders and galleries in
Drupal and place each one as a block. You create a slider by uploading a set of
images and picking a layout; the module then exposes that saved slider as its own
placeable block, which renders in the browser using the bundled jssor JavaScript
library. No JavaScript work is needed on your part — jssor is included and starts
the slideshow automatically.

Each slider is a small content entity with a name, an optional rich-text
description, an unlimited number of images (each with its own alt text), and a
**slide type** chosen from eleven preset layouts — a full-width hero, a carousel,
a gallery with vertical thumbnails, a scrolling logo strip, a banner rotator, and
so on. Every slider you save becomes a separate block, so you can place different
sliders in different regions or on different pages, and switch a slider's look
later just by changing its slide type without re-uploading the images.

The module ships two image styles for consistent thumbnail sizing. Note that the
slider layouts' dimensions are largely hardcoded in the module's Twig template; if
you need different sizing or markup, override `image_slider.html.twig` in your
theme.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Sliders are managed at **Structure → Image slider**
(`/admin/structure/image_slider/list`), where you add, edit, and delete sliders.
The blocks they produce are placed from **Structure → Block layout**.

## How to use it

1. Go to **Structure → Image slider** and choose **Add** to create a slider.
2. Give it a **name**, an optional **description**, upload your **images** (with
   alt text for accessibility and any overlay captions), and pick a **slide
   type** (one of the eleven layouts).
3. Save. The slider now exists as its own block.
4. Go to **Structure → Block layout**, place the block matching your slider's name
   in a region, and (optionally) set visibility conditions so it appears only on
   the pages you want.

Placed slider blocks are visible to anyone who can view content. Four permissions
control who can manage sliders in the admin UI — **View**, **Add**, **Edit**, and
**Delete slider entity** — which you can assign under **People → Permissions** to
give editors slider management without full site admin.
