# Native Search Enhancements — manual setup guide

**Native Search Enhancements** (`native_search_enhancements`) makes Drupal's
built‑in core **Search** more relevant and controllable — without adding a
separate search backend. If your site uses core Search (rather than Search API or
an external engine like Solr), this module gives you three things it otherwise
lacks: the ability to **exclude** chosen content types from the index and
results, **taxonomy terms returned as their own search results**, and
**configurable ranking** so you can influence how results are ordered.

On the taxonomy side it does more than list terms: it can return canonical term
links (with URL‑alias support and optional URL fragments), match terms exactly or
partially, and handle multilingual term names. On the ranking side you can tune
how much a content item's title matters and how much influence taxonomy results
carry. Together these let you shape core Search results much more closely than
Drupal does out of the box.

It depends on core **Node**, **Search**, and **Taxonomy**, and works on Drupal 10
and 11. Administration is gated by a dedicated **`administer native search
enhancements`** permission. Note that this is an early release intended for
testing and community feedback, and it only enhances core's native Search — it
does **not** integrate with Search API or external backends.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and make sure core Search is set up.
2. [Configuration](configuration/index.md) — content exclusions, taxonomy results,
   and ranking settings, field by field.
