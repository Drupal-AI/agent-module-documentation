# Itunes RSS — manual setup guide

**Itunes RSS** (`itunes_rss`) adds a **Views feed style** that renders an RSS feed as
an **iTunes / Apple Podcasts–compatible** podcast feed. In other words, you build a
View of your episodes, add a feed display, choose this style, and map your Drupal
fields onto the `itunes:` RSS elements Apple expects — the result is a valid podcast
feed URL you can submit to Apple Podcasts and other directories.

Because it is built on **Views**, everything about *which* content appears in the
feed and in what order is controlled the way you already control any View: filters,
sorts, and a feed display. This module's job is the **output format** — producing the
correct RSS structure, including the `itunes:` namespace elements, from the fields
you map.

It depends only on core's **Views** module and targets Drupal 11.3+ and 12. It is a
port of the well-known `drupal-views-itunes-rss` plugin.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no module settings page**. All configuration happens inside the **Views
UI** when you build your feed, described in "How to use it" below.

## Where it lives in the admin menu

Itunes RSS adds no admin configuration page. You use it entirely from the **Views UI**
under **Structure → Views** (`/admin/structure/views`), by adding a **Feed** display
and choosing the iTunes RSS style.

## How to use it

1. Create (or edit) a **View** of your podcast episodes under **Structure → Views**.
2. Add a **Feed** display to the View.
3. Set the feed display's **Format / Style** to the **iTunes RSS** style this module
   provides.
4. In the style settings, **map your entity fields onto the iTunes elements** — for
   example the episode's audio file, title, description, duration, and artwork onto
   the corresponding `itunes:` fields.
5. Save the View and visit the feed's path. You now have a podcast feed you can
   submit to Apple Podcasts and other directories.
