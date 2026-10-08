# Diba Carousel Slider — manual setup guide

**Diba Carousel Slider** (`diba_carousel`) gives you a ready-made Bootstrap
carousel as a single, placeable block. Where most Drupal slider solutions ask you
to assemble several pieces — a slide content type, a View, an ordering module, a
JavaScript library — this module ships the finished component. You enable it,
place the block, point it at some content, and you have a working slider.

Each carousel pulls its slides from any fieldable entity (nodes, users, comments,
media, and so on). In the block's settings you choose which content to show and in
what order, and map entity fields to slide parts — a title, a caption, an image,
and a link. Styling settings and carousel options round it out. All of this lives
in the block's own configuration, so a configured carousel exports and imports
with the rest of your site's configuration.

Its dependencies are all Drupal core (`block`, `user`, `node`, `image`,
`options`, `link`) — there's no contrib module to add and no external library to
download. It supports Drupal 9.5, 10, and 11.

> **Bootstrap required for the sliding behavior.** This module generates the
> Bootstrap carousel HTML structure but does **not** bundle Bootstrap's CSS/JS.
> You need a Bootstrap-based theme (it's tested with Drupal Bootstrap and Barrio)
> or your own Bootstrap CSS/JS for the carousel to actually slide. Without it the
> markup renders but the animation won't work.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no site-wide configuration page** — each carousel is configured in its
own block settings. Placement and use are described under "How to use it" below.

## Where it lives in the admin menu

Diba Carousel adds no dedicated admin settings page. You place and configure the
**Diba carousel** block under **Structure → Block layout**
(`/admin/structure/block`); placing blocks is gated by core's **administer
blocks** permission.

## How to use it

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place a **Diba carousel** block in the region you want.
3. In the block's settings, configure:
   - **Content selection and ordering** — which entities become slides, and in
     what order (it also respects custom publishing options for filtering).
   - **Slide field mapping** — which fields supply each slide's title, caption,
     image, and link.
   - **Styling and carousel options** — the presentation of the carousel.
4. Save the block. Repeat to place different carousels in different regions, and
   use each block's **Visibility** settings to control which pages it appears on.

> **Security caution — "Allow html description".** The block form includes an
> *Allow html description* checkbox, which is **off by default**. Leave it off
> unless the source content is authored only by people you would trust with Full
> HTML: when it is on, the description field's raw value is rendered directly,
> bypassing its text format. With it off, the output is stripped and safe.
