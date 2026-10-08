# Podcast — manual setup guide

**Podcast** (`podcast`) lets you publish a valid podcast RSS feed — the kind Apple
Podcasts, Spotify, and other directories expect — entirely with Views. You keep
your episodes as ordinary Drupal content (usually nodes with an audio file field),
build a View feed display over them, and the module turns that feed into
podcast‑flavored XML complete with the iTunes (`itunes:*`) and Podcast Index
(`podcast:*`) tags the platforms require.

It works by adding two Views plugins that you use together on a **Feed** display:
a feed **style** called *Podcast RSS Feed* that builds the channel‑level tags (show
title, description, cover image, owner, categories, and so on) and a row plugin
called *Podcast Fields* that builds each episode `<item>` (the audio enclosure,
duration, season/episode numbers, transcript links, chapters, and more). You add
normal Views fields for your data, then use select boxes in the format settings to
map each field onto the right podcast XML element. Nothing is hard‑coded — you
decide which field feeds which tag.

Because the feed is just a View, you reuse everything you already know: your
existing content type, Views filters and sorts, and Views' *Custom text* field for
static values like a fixed category string. When you're done you point podcast
directories at the feed's path and they pull your episodes.

The module depends on the **Select or Other** module (`select_or_other`), which
powers the copyright field — it lets you either pick an existing View field or type
a literal copyright line. There is no separate admin settings page; all setup
happens on the View.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and its Select or Other dependency).
2. [Configuration](configuration/index.md) — build the feed View and map your
   fields onto the channel and episode tags, field by field.

## Where it lives in the admin menu

There is no dedicated settings page. You do all the work under **Structure →
Views** (`/admin/structure/views`), on the Feed display of the View you build for
your episodes.

## How to use it

At a high level:

1. Have a content type for episodes with an **audio file** field (and fields for
   things like duration, image, and publish date).
2. Build a View over that content type and add a **Feed** display.
3. Set the feed's format to **Podcast RSS Feed** and its row to **Podcast Fields**.
4. Add Views fields for every value you want in the feed, then map them to podcast
   tags in the format settings.
5. Give the feed a path (conventionally ending in `rss.xml`), save, and validate
   it before submitting to directories.

The full field‑by‑field walkthrough is in [Configuration](configuration/index.md).
