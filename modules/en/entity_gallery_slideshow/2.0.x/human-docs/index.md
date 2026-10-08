# Entities Gallery To Slideshow — manual setup guide

**Entities Gallery To Slideshow** (`entity_gallery_slideshow`) provides a **field
formatter** for entity reference fields that displays the referenced entities as a
**gallery**, and lets a visitor open them in a **modal slideshow** synced to the
item they clicked. Because it renders each referenced entity through a view mode,
you can mix bundles freely — for instance images and documents (as media) in the
same gallery — and use one view mode for the grid and another (say, a detail view)
for the slideshow.

The problem it solves is presenting a collection of entities — a portfolio, a set
of product images, a media library — as an interactive gallery-plus-slideshow
without hand-building the markup. You point the formatter at an entity reference
field, and it takes care of the grid and the click-to-open slideshow that stays in
sync with the chosen item.

It works as soon as you enable it — there's no global settings page. You turn it on
per field, in **Manage display**, described under "How to use it" below. A few
things are deliberately left to you: the module ships **only minimal styles**
(because the slideshow lives in a Drupal modal and the items are your own view
modes, styling them is out of scope), so expect to add CSS to match your theme. It
uses the **Swiper** library for the slideshow (it moved to Swiper to stay
compatible with jQuery 4, shipped in Drupal 11). It only controls display —
entities and their access are unchanged. It supports Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no settings form** — the formatter is configured per field on Manage
display. See "How to use it" below.

## How to use it

1. Make sure you have an **entity reference** field (to media, nodes, terms, etc.)
   on the entity you want to show a gallery on, and that the referenced entities
   have suitable view modes — one for the gallery thumbnail and one for the
   slideshow detail.
2. Go to that entity's **Manage display** (**Structure → … → Manage display**),
   find the reference field, and set its **Format** to the Entities Gallery To
   Slideshow formatter.
3. In the formatter's settings, choose the view mode used for the gallery grid and
   the view mode used for the slideshow.
4. Save, then view the entity — the referenced items appear as a gallery, and
   clicking one opens the modal slideshow synced to that item.
5. Add your own CSS to style the gallery and slideshow to match your theme, since
   the module provides only minimal styling.
