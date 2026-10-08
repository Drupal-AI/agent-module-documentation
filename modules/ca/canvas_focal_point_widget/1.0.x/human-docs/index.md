# Canvas Focal Point Widget — manual setup guide

**Canvas Focal Point Widget** (`canvas_focal_point_widget`) adds a visual
focal‑point picker for images inside **Canvas**, Drupal's Experience Builder
page‑building UI. Instead of leaving responsive image crops to chance, an editor
clicks the point on an image that matters most — a face, a logo, the horizon —
and crops keep that point in view as the image is resized for different screens.

The focal point is editor metadata attached to the image; the module has no
content type of its own and no access‑control role. It depends on the **Canvas**
module and targets Drupal 11.

This guide is written for a **human** clicking through the site. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (Canvas is required).

## Where it lives in the admin menu

The widget adds no top‑level admin menu items and no separate settings form. It
surfaces where you edit images within the Canvas page builder — as the
focal‑point picker on an image.

## How to use it

While building a page in Canvas, edit an image component and use the focal‑point
picker: click the spot on the image you want kept in view. Canvas then uses that
focal point when it crops the image for responsive display, so the important part
of the picture stays visible across screen sizes.
