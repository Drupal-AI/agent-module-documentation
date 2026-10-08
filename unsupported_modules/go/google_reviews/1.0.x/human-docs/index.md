# Google Reviews — manual setup guide

**Google Reviews** (machine name `google_reviews`, distributed as the Composer project
`drupal/google_reviews_slider`) pulls your business's Google reviews into Drupal and shows
them off in a sliding carousel block, complete with a star rating — instant social proof for
your site. It talks to the Google Places API, imports each review as a Drupal node, and
renders published reviews in a Swiper‑based slider.

Here's how it works: on the settings form you provide a Google Places **API key** and one or
more **Place IDs** (each Place ID identifies a business location on Google). The module then
fetches that location's reviews and creates one `review` node per review, along with an
overall rating and total review count. You can aggregate several locations by listing
multiple Place IDs. Imports happen automatically on cron, or on demand via a **Fetch
reviews** button. There are display controls too: a minimum rating to show, a cap on how many
reviews appear, a maximum review age, a block title, whether to show a computed average and/or
Google's own reported rating, and an optional "Leave us a review" link.

Two things are important to understand. First, imported reviews arrive **unpublished**, so an
editor must publish the ones you want visible — this is your moderation step. Second, the
star icons and slider styling use the Swiper library loaded from a CDN, and the module installs
a `review` content type (with `field_review_*` fields) that you can also reuse in your own
Views or displays.

It works only after you enter credentials and configure it — it does nothing useful on enable
alone. It has no dependencies beyond core and ships no submodules.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — enter your API key and Place IDs, tune the
   display options, import reviews, publish them, and place the block.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Review Settings**
(`/admin/review-settings`). The reviews slider is placed as a block under **Structure → Block
layout**, where it's called **Google reviews content block** (category *Reviews*).

## How to use it

At a glance: enter your Google Places API key and Place ID(s) on the settings form, click
**Fetch reviews** to import, publish the review nodes you want shown, then place the reviews
block in a region. The full walkthrough is in [Configuration](configuration/index.md).
