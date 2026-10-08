# Google Reviews — manual setup guide

**Google Reviews** (`googlereviews`) shows a business's Google reviews and its
overall Google star rating in Drupal blocks, pulled live from the Google Places
API. It is a simple way to surface social proof — testimonials, a star badge —
on a marketing page, a contact page, or a sidebar, using the reviews customers
have already left for your location on Google.

The module provides two block plugins. **Google Reviews List** renders individual
review cards, and **Google Reviews Rating** renders your aggregate rating and
total review count as a badge. A single fetch service talks to Google using your
API key and a Google **Place ID** (the identifier for your business location).
It supports both the legacy Google Places API and the newer Places API v1, and it
caches responses (24 hours by default) to stay within your Google quota.

To use it you need two things from Google: a **Google API key** with the Places
API enabled, and the **Place ID** of the location whose reviews you want to show.
You enter these on the module's settings page (store the API key as an
environment variable/secret rather than committing it). Each block can then
override the Place ID, and the reviews block adds moderation options such as a
maximum number of reviews, a minimum star threshold, and word filters.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings page, placing the two
   blocks, and their per‑block options.

## Where it lives in the admin menu

The settings page sits at **Configuration → System → Google Reviews**
(`/admin/config/system/googlereviews`), gated by the **Administer Google Reviews
configuration** permission. You place the actual blocks through **Structure →
Block layout** (or Layout Builder).
