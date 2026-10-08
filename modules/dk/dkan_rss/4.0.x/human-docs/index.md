# DKAN Dataset RSS feed — manual setup guide

**DKAN Dataset RSS feed** (`dkan_rss`) publishes your DKAN portal's datasets as a
standards‑compliant **RSS 2.0** XML feed at **`/datasets.rss`**. It lets data
consumers, aggregators and search‑engine crawlers subscribe to your catalog and
pick up new and updated datasets, and it gives partners a machine‑readable stream
of dataset metadata.

The feed is schema‑driven. A creator service reads the datasets from DKAN's
metastore and maps each dataset's metadata onto RSS `<item>` elements according to
a configurable mapping file (`dataset.rss.feed.json`), applying formatters (such as
RFC‑2822 dates), optional sorting and an optional item limit before serializing the
result as `application/rss+xml`. The default mapping produces a valid feed against
a standard DKAN install with demo content, and you can override the mapping to
suit your own schema. A block plugin (**RSS Link**) renders a link to the feed for
your visitors.

One operational point to be aware of: `/datasets.rss` is gated only by core's
`access content` permission, which anonymous users hold by default, so the **feed
is public** — appropriate for an open‑data catalog. The feed iterates all datasets
in the metastore, so before relying on it publicly, confirm your metastore only
returns published datasets if you have any drafts or non‑public datasets.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module against DKAN.

There is **no admin settings form** — the feed works on enable, and customization
is done by editing the mapping JSON, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no settings page. The feed is served at **`/datasets.rss`**, and
you can place the **RSS Link** block through **Structure → Block layout** to link
to it.

## How to use it

1. Enable the module — the feed is immediately available at `/datasets.rss`.
2. To link to it for visitors, place the **RSS Link** block in a region via
   **Structure → Block layout**, or link to `/datasets.rss` directly from your
   theme or menus.
3. To customize which dataset properties map to which RSS fields, copy the
   module's **`dataset.rss.feed.json`** file to your DKAN schema location and edit
   it there. It parallels DKAN's `dataset.json`: for example, map the dataset's
   `issued` property to the RSS item's `pubDate`, or set `dc:creator`. More
   advanced tweaks are possible via the `_attributes` and `_formatters` keys in the
   mapping file.
4. Validate the result against a tool like the W3C RSS validator.

> **Before going public:** the feed lists every dataset the metastore returns.
> Confirm that unpublished or draft datasets are excluded if any of your data
> isn't meant to be public.
