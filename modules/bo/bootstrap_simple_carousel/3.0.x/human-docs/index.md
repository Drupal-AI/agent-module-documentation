# Bootstrap Simple Carousel — manual setup guide

**Bootstrap Simple Carousel** (`bootstrap_simple_carousel`) gives you a single
block — the **Bootstrap simple carousel block** — that renders a
[Bootstrap 5](https://getbootstrap.com/) image carousel (slideshow) from a small
set of images you manage in the admin UI. It is a lightweight way to add a homepage
hero slider or an image rotator to any region, without pulling in Views or a heavier
slideshow module.

Each slide is an image you upload, with its own alt and title text, an optional link
(to an internal path like `node/1` or an external URL), and an overlaid caption
title and caption text. You control the carousel's behavior globally — auto-advance
interval, wrap-around, pause-on-hover, indicator dots, and prev/next arrows — and
you can apply a Drupal image style so every slide is sized consistently.

One important choice: the module can either **load Bootstrap 5 for you** from a CDN
(handy if your theme doesn't already include Bootstrap) or stay out of the way and
let your theme provide Bootstrap. That is the **assets** toggle in the settings.

This guide is written for a **human** clicking through the admin UI. If you want a
terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There are three places you work with the carousel:

- **Global settings** — **Configuration → Media → Bootstrap Simple Carousel**
  (`/admin/config/media/bootstrap_simple_carousel`), gated by **Administer site
  configuration**.
- **Slides (carousel items)** — **Structure → Bootstrap Simple Carousel**
  (`/admin/structure/bootstrap_simple_carousel`), gated by the module's own
  **Access bootstrap simple carousel** permission.
- **Displaying it** — **Structure → Block layout** (`/admin/structure/block`), where
  you place the carousel block in a region.

## How to use it

### 1. Add your slides

Go to **Structure → Bootstrap Simple Carousel** to see the list of slides, then use
**Add** to create one. For each slide you set:

- **Image** — upload a GIF, PNG, JPG, or JPEG (up to about 25 MB); files are stored
  under `public://bootstrap_simple_carousel/`.
- **Image alt** and **Image title** — accessibility and hover text.
- **Image link** — a full URL, or an internal path like `node/1` or `about`.
- **Caption title** (up to 100 characters) and **Caption text** — overlaid on the
  slide.
- **Weight** — controls the slide order.
- **Status** — Active or Inactive; set a slide Inactive to hide it temporarily
  without deleting it.

Note: once a slide is created, its **image cannot be re-edited** — you can change the
other fields, but to swap the picture you delete (or deactivate) the slide and create
a new one.

### 2. Set the global carousel behavior

Go to **Configuration → Media → Bootstrap Simple Carousel** and adjust:

- **Interval** — milliseconds between slides (default **3000**). Set `0` to disable
  auto-cycling.
- **Wrap** — cycle continuously (default on) or stop hard at the last slide.
- **Pause** — pause cycling when the mouse hovers over the carousel (default on).
- **Indicators** — show the little indicator dots (default on).
- **Controls** — show the previous/next arrows (default on).
- **Assets** — when on, the module loads Bootstrap 5.3.3 CSS and JS from a CDN.
  Leave it **off** if your theme already provides Bootstrap 5, or **on** if it does
  not (default off).
- **Image type** — a Bootstrap image class for the slide images (none, `img-fluid`,
  or `img-circle`).
- **Image style** — a Drupal image style applied to every slide (or the original
  image).

### 3. Place the block

Go to **Structure → Block layout**, click **Place block** in your chosen region, and
add the **Bootstrap simple carousel block**. It shows your active slides (ordered by
weight) to anyone who can view content. You can place it in multiple regions and use
core block visibility rules to control where it appears.

### Theming

The block renders through the `bootstrap--simple--carousel--block.html.twig`
template. To change the markup, override that template
(`bootstrap_simple_carousel_block` theme hook) in your own theme.
