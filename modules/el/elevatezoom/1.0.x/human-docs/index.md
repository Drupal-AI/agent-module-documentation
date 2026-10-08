# Elevate Image Zoom (elevatezoom) — manual setup guide

**Elevate Image Zoom** (`elevatezoom`) adds a magnify‑on‑hover zoom effect to
images on your site, powered by the jQuery ElevateZoom Plus plugin. It provides a
**field formatter** you apply to an image field so that visitors can zoom into a
picture to see its detail — perfect for product images, where a closer look often
makes the difference.

This is a distinct project from the similarly named
[`elevate_image_zoom`](https://www.drupal.org/project/elevate_image_zoom) module;
both add the same kind of zoom feature. The convenient difference here is that
**this version loads its library from a CDN**, so — unlike the other project —
you do *not* have to download and place a library file yourself.

ElevateZoom Plus is fully customisable and offers a range of effects: coloured
tints, window zoom, lens zoom, inner zoom, variable zoom on mouse scroll,
external controls, fade in/out, easing, and gallery/lightbox support (Fancybox
Plus and Colorbox). It is a front‑end presentation feature only — it changes how
images display and does not affect media handling or access control.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (no library download needed).

This module has **no configuration page** of its own. You configure it on a
field's display settings, described in "How to use it" below.

## Where it lives in the admin menu

Elevate Image Zoom (elevatezoom) adds no admin settings page. You use it from
**Structure → Content types → *(your type)* → Manage display**, where you set an
image field's format to the ElevateZoom formatter.

## How to use it

1. Go to **Structure → Content types → *(your content type)* → Manage display**.
2. Find the image field you want to enhance and, in the **Format** column,
   choose the ElevateZoom formatter.
3. Click the settings cog to choose the zoom effect and options, then save.
4. View a piece of content that uses the field and hover over the image to see
   the zoom in action.
