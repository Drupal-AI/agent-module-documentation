# Advanced Views RSS Feed — manual setup guide

**Advanced Views RSS Feed** (`views_rss`) replaces Drupal's built-in RSS feed style
with a far more flexible, **fields-based** one. Core's RSS output is fixed — you get a
standard node or comment feed and little say over what goes in it. This module gives
you a Views style and row plugin pair that let you map **any field on your View to any
RSS 2.0 channel or item element** through dropdowns and text boxes, so you can build
exactly the feed a podcast app, an aggregator, or a syndication partner expects.

The base module is really just the machinery: the style plugin, the row plugin, the
hooks, and an RFC-822 date format. It deliberately ships **no RSS elements itself** —
the actual `<title>`, `<link>`, `<description>`, Dublin Core, and Media RSS elements
are provided by its five **submodules**. The important one is **Views RSS: Core
Elements** (`views_rss_core`), which supplies the standard RSS elements and is
**required** for the feed to work (every RSS item needs at least a title or a
description). The others are optional: Dublin Core metadata, a raw/CDATA output tweak,
Yahoo Media RSS for audio/video, and a getID3-powered extension that adds real media
metadata like bitrate and duration.

There is **no global settings page** — everything is configured per View, inside the
style and row plugin options of a Feed display. The module depends only on core's
Views module; two of the submodules have their own optional library or module
suggestions. This guide is written for a **human** building a feed in the Views UI. If
you want terse, token-cheap references for an AI coding agent — the plugin ids, the
options structure, and the element-definition hooks — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module and the submodules you need (start with Core Elements).

## Where it lives in the admin menu

There is no admin configuration page. All of the module's settings live inside the
Views UI at **Structure → Views** (`/admin/structure/views`): when you add a **Feed**
display to a View and choose the **Advanced RSS feed** format, its channel- and
item-element options appear right there in the style and row settings.

## How to use it

Build a custom RSS feed on an existing (or new) View:

1. **Enable Core Elements first.** Make sure the **Views RSS: Core Elements**
   submodule (`views_rss_core`) is enabled — without it the feed has no RSS elements
   to map to and the row plugin will refuse to work. Enable any other submodules you
   want (Dublin Core, Media RSS, etc.) too.
2. **Add a Feed display to your View.** Edit a View that lists the content you want to
   syndicate and add a **Feed** display.
3. **Choose the "Advanced RSS feed" format.** In the display's **Format** setting,
   pick **Advanced RSS feed** for the style. This is the module's style plugin; it
   requires and automatically uses the matching **Advanced RSS feed** row plugin, so
   set the row style to match.
4. **Add fields, then map them to RSS elements.** Add the View fields you want to
   syndicate (title, body/summary, an image or file field for enclosures, an authored
   date, a taxonomy reference for categories, and so on). Then, in the style options,
   assign fields to **channel** elements (feed-level: image, ttl, language, and the
   automatic `atom:link`/`pubDate`), and in the row options assign fields to **item**
   elements (`<title>`, `<link>`, `<description>`, `<enclosure>`, `<guid>`,
   `<category>`, and more, grouped by namespace).
5. **Tune the output.** Toggle options like **Replace relative paths with absolute
   URLs** (so off-site readers can resolve embedded links and images) and choose
   whether the feed's own RSS icon is attached to the View's links.
6. **Save and visit the feed path.** The Feed display's path serves a valid RSS 2.0
   document; optional elements you leave blank are simply omitted.

For a podcast or media feed, also enable **Views RSS: Media Elements**
(`views_rss_media`) and, if you want real per-file bitrate/resolution/duration, the
getID3 extension. For the plugin ids and the hooks used to define or alter elements,
see the [`agent/`](../agent/start.md) docs.
