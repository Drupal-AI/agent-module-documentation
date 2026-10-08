# Hreflang — manual setup guide

**Hreflang** (`hreflang`) automatically adds `<link rel="alternate" hreflang="…">`
tags to the `<head>` of every page on a multilingual Drupal site — one tag for each
enabled language, each pointing at the equivalent URL in that language. These tags
tell Google and other search engines which version of a page to serve to a visitor
in a given language or region, which is a cornerstone of good multilingual SEO.

Drupal core's Content Translation module can add hreflang tags too, but only on
*translated entity pages* (nodes, taxonomy terms, and the like). Hreflang extends
this to the whole site: the front page, Views pages, custom routes, and entity
pages all get proper hreflang tags, as long as the site actually has more than one
language enabled. On a single‑language site the module simply does nothing, and it
skips the tags on 403 and 404 error pages.

Beyond turning it on, there is very little to configure — three checkboxes on a
single settings page control whether an `x-default` tag is added, where that tag
points, and whether the module should hand entity pages back to Content Translation.
Sensible defaults mean most sites get correct behavior the moment the module is
enabled.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the three settings on the Hreflang
   tags form, explained one by one.

## Where it lives in the admin menu

Its settings form sits at **Configuration → Search and metadata → Hreflang tags**
(`/admin/config/search/hreflang`), and is gated by the **Administer site
configuration** permission.

## How to use it

Enable the module on a multilingual site and you are essentially done — it starts
emitting one hreflang tag per enabled language, plus an `x-default` tag, on every
page automatically. Visit the settings form only if you want to adjust the
`x-default` behavior or defer entity pages to Content Translation (see
[Configuration](configuration/index.md)). To confirm it is working, view the page
source of any page and look for the `<link rel="alternate" hreflang="…">` tags in
the head, then check for a clean report in Google Search Console once the site is
crawled.
