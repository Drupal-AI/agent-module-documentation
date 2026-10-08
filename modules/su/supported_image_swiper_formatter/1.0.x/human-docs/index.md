# Supported Image Swiper Formatter — manual setup guide

**Supported Image Swiper Formatter** (`supported_image_swiper_formatter`) is a
display formatter that renders a multi-value **Supported Image** field as a
[Swiper](https://www.drupal.org/project/swiper_formatter) carousel — a swipeable,
navigable slider — so a set of images becomes an interactive gallery.

It builds on the **Swiper formatter** project, applying the same Swiper.js
carousel presentation to Supported Image fields specifically. Where a plain display
would stack the images, this formatter turns them into a slideshow visitors can
swipe or click through, which is a natural fit for image galleries and featured-image
strips.

This is a pure display formatter — there is no global settings page. You choose it
and configure it on a field's display settings. It depends on the **Swiper
formatter** module and the **Supported Image** module, and it targets Drupal 10 and
11.

This guide is written for a **human** setting the formatter up through the admin UI.
If you are an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

1. Go to the **Manage display** page of the entity whose Supported Image field you
   want to show as a carousel.
2. Change that field's format to **Swiper images**.
3. Click the gear icon next to the formatter to configure the image output and the
   Swiper settings.
4. Save the display settings.
