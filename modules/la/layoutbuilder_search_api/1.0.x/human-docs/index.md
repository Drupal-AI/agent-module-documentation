# Layout Builder Search API — manual setup guide

**Layout Builder Search API** (`layoutbuilder_search_api`) lets you index the
content that lives inside your Layout Builder layouts. When a page is built with
Layout Builder, a lot of the meaningful, searchable text sits in **inline blocks**
and referenced **reusable block content** placed into the layout — not in the
host node's own fields. By default a Search API index can't see into those
blocks. This module fixes that.

It adds a single Search API **processor** called *Layout builder references*. When
you enable it on an index, it walks each item's Layout Builder sections, finds
every inline block and placed block‑content component, and makes their fields
available as Search API properties. You choose which block content types to
expose, and then add their individual fields on the index's *Fields* tab — so you
get precise, field‑level search over structured block data (a hero headline, an
FAQ question/answer, a CTA's text) instead of indexing a blob of rendered page
HTML. It loads the correct block revision that is actually on the page, and it is
language‑aware.

There is no settings page of its own (`configure: null`) and no permissions —
everything is configured directly on your Search API index. This is a
site‑builder / developer tool: you need an existing Search API setup (an index
with an entity datasource) and a site that uses Layout Builder.

> **Heads up — compatibility on Drupal 11.4+.** As of version 1.0.3 this module
> is **broken on current core (Drupal 11.4 and later)**: the processor class
> conflicts with a typed property that core's Layout Builder helper trait now
> declares, which causes a PHP fatal error the moment Search API tries to
> instantiate the processor (enabling it on an index, saving such an index, or
> opening the Processors UI). Until the module is patched you cannot actually
> enable the processor on Drupal 11.4+. The steps below describe the intended
> behavior.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module adds no page of its own. You work with it on your existing Search API
index, at **Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`) → your index → the **Processors** and
**Fields** tabs.

## How to use it

Once the module is enabled (see [Installation](installation/index.md)):

1. Open your Search API index and go to the **Processors** tab.
2. Enable **Layout builder references**.
3. In its settings, tick the **block content types** you want to expose to the
   index — only the types you tick will have their fields made available.
4. Go to the index's **Fields** tab and click **Add fields**. Under each block
   type you enabled you will find that block's fields (nested under the generated
   property). Add the ones you want to index.
5. Reindex.

From then on, when Search API indexes an entity it pulls the current revision of
each inline/referenced block used in that entity's layout and indexes the fields
you chose. You can combine these with the host entity's own fields in the same
index, build facets over structured block fields, and feed a Solr or
Elasticsearch backend with clean, structured data rather than rendered markup.
