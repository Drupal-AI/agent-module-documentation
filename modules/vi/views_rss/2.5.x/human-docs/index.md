# Advanced Views RSS Feed — manual setup guide

**Advanced Views RSS Feed** (`views_rss`) — formerly just "Views RSS" — replaces
Drupal core's fixed RSS output with a **fields-based** RSS feed you build in Views.
Instead of core's take-it-or-leave-it `node`/`comment` RSS, you add whatever fields
you like to a View and then map each field to any RSS 2.0 `<channel>` or `<item>`
element through simple dropdowns. It gives site builders full control over exactly
what a feed contains.

It works by adding a Views **style** plugin ("Advanced RSS feed") and a matching
**row** plugin. The base module is deliberately just the machinery: on its own it
defines *no* RSS elements at all. The actual elements — `<title>`, `<link>`,
`<description>`, Dublin Core metadata, Yahoo Media RSS, and so on — are contributed
by its submodules. This is why enabling the base module is not enough on its own:
you will almost always also enable **Views RSS: Core Elements** (`views_rss_core`),
which supplies the standard RSS elements, and it is required for the feed to produce
valid output (every RSS item needs at least a title or a description).

There is no global settings page. Everything is configured per-View, on the feed
display's style and row settings — so building a feed is a Views task, described
under "How to build a feed" below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and choose which element-set submodules you need.

There is **no configuration page** for this module — it has no global settings form.
All configuration happens inside the Views UI, described below.

## Where it lives in the admin menu

Advanced Views RSS Feed adds no admin settings page. You use it entirely from the
**Views** UI at **Structure → Views** (`/admin/structure/views`), by adding a Feed
display to a View and choosing the *Advanced RSS feed* format.

## How to build a feed

1. Create or edit a View at **Structure → Views**.
2. Add a **Feed** display (or a Page display with an attached Feed).
3. Set the display's **Format** to **Advanced RSS feed**. When prompted for the row
   style, also choose **Advanced RSS feed** (the style and row plugins require each
   other).
4. Add the **fields** you want to expose to the View — for example Title, Body/summary,
   an image or file field, an authored-on date, a taxonomy reference.
5. Open the **Format → Settings** (the style options) to map fields to `<channel>`
   elements, and the **row Settings** to map fields to `<item>` elements. The
   available elements are grouped by namespace and come from whichever element-set
   submodules you enabled — so if you only see the core elements, enable more
   submodules (see [Installation](installation/index.md)).
6. Common per-feed options include "Replace relative paths with absolute URLs" (so
   off-site feed readers can resolve links and images) and channel hints such as
   `<ttl>`, `<image>`, and `<atom:link>` self-discovery.
7. Save the View and visit the feed's path to see the generated RSS 2.0 XML.

> **Note:** After enabling or changing which element-set submodules are active, run
> `drush cr` — the module caches its element and namespace registries indefinitely,
> and a cache rebuild is what makes newly available elements show up in the Views
> settings forms.
