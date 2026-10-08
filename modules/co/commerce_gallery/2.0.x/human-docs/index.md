# Commerce Gallery — manual setup guide

**Commerce Gallery** (`commerce_gallery`) provides a feature-rich block that
renders your Drupal Commerce product-variation images in a responsive **masonry,
grid, or metro** layout, complete with a built-in lightbox and a dynamic filter
bar. It is designed for modern storefronts that want an engaging, gallery-style
product-image display without wiring up a JavaScript library by hand.

The gallery is implemented as a **block**, so you place it on any product-related
page or landing region and configure its look and data source right there in the
block form. It can pull images from specific product variation types or from your
whole catalog, show or hide price / SKU / a "View product" link, and group images
into titled sections by bundle. A shared lightbox singleton keeps performance high
when several galleries sit on one page, and the markup includes swipe support,
keyboard navigation and ARIA attributes for accessibility.

There is no global settings page — everything is configured per block when you
place it. It depends on core **File** and **Image** plus Drupal Commerce
(Commerce and Product), and runs on Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no global settings
form. You configure each gallery in the block placement form, described in "How to
use it" below.

## Where it lives in the admin menu

Commerce Gallery adds no admin settings page. You work with it entirely from
**Structure → Block Layout** (`/admin/structure/block`), where you place and
configure the gallery block.

## How to use it

1. Go to **Structure → Block Layout** and click **Place block** in the region
   where you want the gallery.
2. Search for **Commerce Gallery (Advanced Masonry)** and place it.
3. In the block configuration form, set up:
   - **Data source** — choose which product **variation types** to include, or
     leave all unchecked for a global gallery across the catalog. Set the **sort
     order** and a result **limit**.
   - **Layout mode** — **Masonry** (Pinterest-style), **Uniform Grid**, or
     **Metro** (alternating sizes).
   - **Responsive columns** — column counts for Desktop, Tablet Large, Tablet
     Small and Mobile.
   - **Card display** — toggle the visibility of **Price**, **SKU**, and an
     optional **"View Product"** link that resolves to the parent product's URL.
   - **Appearance** — grid gap, card border radius, per-block accent color, and a
     hover effect (Lift, Zoom, or Glow).
   - **Images** — separate Drupal **image styles** for grid thumbnails and for the
     high-resolution lightbox view.
   - **Lightbox** — options such as autoplay and an image counter (e.g. "3 / 12"),
     plus a **Group by bundle** setting that splits images into distinct titled
     sections.
4. **Save** the block. Visit the page to see the gallery; images open in the
   shared lightbox, which supports arrow-key and swipe navigation and closes with
   Esc.
