# Juicer — manual setup guide

**Juicer** (`juicer`) embeds a [Juicer.io](https://www.juicer.io/) social‑media
feed into your Drupal site as a configurable block. Juicer.io is a hosted service
that aggregates posts from your social accounts — Instagram, LinkedIn, Facebook,
X (Twitter), TikTok, Bluesky, YouTube and more — into a single feed. This module
takes that feed and renders it anywhere Drupal blocks can go: a sidebar, a content
region, or a Layout Builder layout.

The posts display in a responsive masonry grid (powered by Juicer's own CSS Grid
and Packery), clicking a post opens a detail overlay, and a "Load More" button
pulls in additional posts without reloading the page. You don't write any code —
you enter your Juicer feed ID (the "slug") on the block and the feed renders
immediately. The module depends only on Drupal core; the front‑end libraries it
needs (Swiper and Packery) are loaded automatically from Juicer's CDN.

Because the feed and its assets come from the external Juicer.io service, that
third party can load remote JavaScript and set cookies in your visitors' browsers.
The posts themselves are public content, so the block plays no access‑control role
— treat it as an embed you trust the provider to serve.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — place the Juicer Social Feed block
   and fill in its settings, field by field.

## Where it lives in the admin menu

Juicer adds no dedicated settings page. Everything is configured on the block
itself, which you place from **Structure → Block layout**
(`/admin/structure/block`). Search for the **Juicer Social Feed** block when you
click *Place block* in your chosen region.

## How to use it

1. Sign in to your Juicer.io account and note your feed's **slug** (its feed ID) —
   you'll find it on your Juicer dashboard. You need at least one feed configured
   there before the block has anything to show.
2. In Drupal, go to **Structure → Block layout**, click *Place block* in the
   region you want, and choose **Juicer Social Feed**.
3. Enter your feed slug, optionally tune the post count, source filter, title and
   subtitle (see [Configuration](configuration/index.md)), and save. Your feed
   renders on the front end straight away.
