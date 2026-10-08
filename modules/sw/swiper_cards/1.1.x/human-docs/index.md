# Swiper Cards — manual setup guide

**Swiper Cards** (`swiper_cards`) lets you build responsive, touch‑friendly card
sliders straight from Drupal's block configuration area, using the popular Swiper
library. Instead of writing markup or wiring up a JavaScript carousel, you place a
**Swiper Cards block**, enter your cards, and pick one of the module's predefined
card layouts (it currently offers four).

Each card can carry a photo, a title, a subtitle, a short blurb, and other
related information, and you can control the order of the cards with a weight
select so they sort exactly how you want. The block also offers a few simple
presentation options: a slider container background colour, and header text for
the slider entered through a formatted‑text editor. It is well suited to hero and
feature sliders.

You configure everything in the block itself — there is no separate site‑wide
settings form. The module depends on core's **Block** module and has no submodules.
It supports Drupal 9, 10, and 11. For developers, the card markup, CSS, and
JavaScript are all overridable: copy `templates/swiper-cards.html.twig` into your
theme and customise the HTML with the variables the template exposes
(`swiper_cards_data` — an array of cards, each with `card_image`, `card_title`,
`card_subtitle`, `card_description`, `weight`, `image_url` — plus
`swiper_card_layout` and the container background colour), and add your own CSS or
JS.

A note on trust and content: the card content is authored by administrators or
editors and rendered as markup, so keep authoring of these blocks to trusted
users. The module has no access‑control role of its own. Note also that this
project is **not covered by Drupal's security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — place the Swiper Cards block and set
   up its cards, layout, and appearance.

## How to use it

The feature surfaces as a **block**. Once the module is enabled, add a Swiper
Cards block to a region on the **Block layout** page, then fill in its cards and
options. See [Configuration](configuration/index.md).
