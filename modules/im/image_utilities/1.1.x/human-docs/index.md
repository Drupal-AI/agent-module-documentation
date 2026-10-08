# Image Utilities — manual setup guide

**Image Utilities** (`image_utilities`) is a small **developer‑oriented** module
that adds a few conveniences to Drupal's core Image system. It doesn't change
anything you see in the admin UI; instead, it gives themers and module developers
easier ways to generate image URLs and reach an image field's underlying file and
metadata from code and Twig.

It provides three things:

- An **`image_style` Twig filter** that takes field items, or a media or file
  entity, and returns an image URL for the image style ID you pass as an argument.
- An **ImageManager service** you can inject to generate image URLs from custom
  code.
- Extra helper methods — **`getFile()`, `getAlt()`, and `getTitle()`** — added to
  the image field item class, for use in custom code or Twig templates.

Because it's a developer aid, there is no settings page and no permissions. It
depends only on core's Image module and works with images that already follow
Drupal's normal file/image access — it has no access‑control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — it exposes a Twig filter, a
service, and field‑item helpers, described in "How to use it" below.

## Where it lives in the admin menu

Image Utilities adds no admin page. It's used entirely from Twig templates and
custom PHP code.

## How to use it

- **In a Twig template**, generate a styled image URL with the `image_style`
  filter, passing the image style ID:

  ```twig
  {# From a field's items #}
  <img src="{{ content.field_image|image_style('large') }}" />
  ```

  The filter accepts field items, a media entity, or a file entity.

- **In custom PHP**, inject the **ImageManager** service to build image URLs
  programmatically instead of assembling them by hand.

- **On an image field item**, use the added helpers — `getFile()` to reach the
  underlying file entity, and `getAlt()` / `getTitle()` to read the alt and title
  text — in your code or templates.

> **Tip:** These helpers are conveniences over the core Image API; nothing else in
> your site changes when the module is enabled, so it's safe to add whenever you
> need them.
