# Rater8 Testimonials Block — manual setup guide

**Rater8 Testimonials Block** (`rater8_testimonial_block`) is a customizable block
widget that showcases customer testimonials from the third-party
[Rater8](https://www.rater8.com/) platform directly on your Drupal site. You place
the block where you want testimonials to appear and give it your Rater8 ID; the
block then displays customer quotes and positive feedback sourced from Rater8 as
social proof — an easy way to build trust with prospective customers.

The block integrates with the Rater8 platform through a **Rater8 ID**, which
identifies your widget/account. Without an ID the block has nothing to display, so
supplying it is the one required step.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — place the block and set its Rater8
   ID.

## Where it lives in the admin menu

The module adds no settings page of its own. You configure it through the **Block
layout** system at **Structure → Block layout** (`/admin/structure/block`), where
you place and configure the Rater8 Testimonials block.
