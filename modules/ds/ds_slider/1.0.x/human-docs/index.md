# Responsive Slider (DS Slider) — manual setup guide

**Responsive Slider (DS Slider)** (`ds_slider`) adds a configurable, responsive
image/content **slider (carousel)** to your site. Once configured, you can show
it in two ways: drop the **DS Slider** block into any theme region, or send
visitors to its dedicated page at `/ds-slider`. It is built on a slider
JavaScript library that ships with the module, with Twig templates for rendering
each slide.

The module works from a single admin settings form where you set up the slider,
plus block placement for where it appears. It is a good fit for homepage hero
carousels, promotional banners, and featured‑content rotators. You can place the
block in multiple regions and combine it with Drupal's block visibility
conditions to scope it to particular pages.

A couple of things to keep in mind. The `/ds-slider` page is gated only by the
core **access content** permission, so it is readable by anonymous visitors —
that is appropriate for a public display page, but do not use the slider to show
access‑restricted content. And, as with any vendored front‑end asset, the
bundled slider library should be kept updated and its accessibility (keyboard and
screen‑reader support) verified before production use. Note the module's
development status is *No further development*.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set up the slider on its settings
   form, then place the block or use the page.

## Where it lives in the admin menu

After enabling, the slider's settings form is available at the **DS Slider
settings** page (route `ds_slider.settings`), reachable from the module's
**Configure** link on the **Extend** page (`/admin/modules`) or from the admin
configuration menu. The slider itself appears where you place its block, or at
the page route `/ds-slider`.

## How to use it

1. Configure the slider on its settings form — see
   [Configuration](configuration/index.md).
2. Show it by either placing the **DS Slider** block
   (**Structure → Block layout**, `/admin/structure/block`) in a region, or
   linking visitors to `/ds-slider`.
3. Optionally add block visibility conditions so the slider only shows on the
   pages you want.
