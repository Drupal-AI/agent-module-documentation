# Testimonials Block — manual setup guide

**Testimonials Block** (`testimonials_block`) provides a configurable block for
displaying testimonials — customer or client quotes, reviews, and feedback — on
your Drupal site. You enter the testimonials directly in the block's
configuration, place the block where you want it, and it renders them as a
responsive carousel. It is a simple, free way to add social proof to a site and
help win new customers.

Each testimonial can carry a quote, the author's name, an optional photo, a
designation (job title), and other author information. There is an order‑weight
option so you can control the sequence in which testimonials appear. The display
is responsive: you can set how many items show on different screen sizes and
whether the navigation arrows and dots appear at each size.

The block is themeable. The module ships a Twig template
(`templates/testimonials-block.html.twig`) that you can copy into your own theme
and customise — implementing your own HTML, CSS, or even a different carousel
library — using the variables it exposes (the array of testimonials, and the
responsive settings). So you can start with the built‑in look and later take full
control of the markup.

Testimonials Block does nothing until you place and configure the block — the
content lives in the block configuration and is entered by an administrator or
editor. It depends on core **Block** (`block`), supports **Drupal 9, 10, and 11**,
and ships no submodules. It has no access‑control role of its own. (This project is
not yet covered by Drupal's security advisory policy.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — place the block, add testimonials,
   and set the responsive display options.

## Where it lives in the admin menu

There is no separate settings page — everything is configured on the block itself.
Place and configure the Testimonials block through **Structure → Block layout**
(`/admin/structure/block`).
