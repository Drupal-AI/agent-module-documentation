# Google PageMap Embed — manual setup guide

**Google PageMap Embed** (`google_pagemap`) adds Google **PageMap** structured‑data
attributes to your pages. A PageMap is a block of structured metadata that Google can
index and then use as filters for search queries — particularly useful for advanced
indexing of custom search results, such as a Google Programmable Search Engine. In
short, it exposes structured attributes about each page to Google's crawler.

You choose which **content types** should carry a PageMap and which **fields** on
those content types should become attributes in it. Once configured, the module adds
the PageMap markup to the `html_head` of every page that should have one — for
example, it can include the content type itself as one of the attributes. It's a pure
SEO/metadata enhancement with no content or access role of its own.

The module depends on the **Preprocessor Plugins** module (`preprocessors`), whose
HTML preprocessor plugin is what actually injects the PageMap markup into the head.
It's designed to pair well with the Vertex AI Search module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   Preprocessors dependency) and enable the module.
2. [Configuration](configuration/index.md) — choose the content types and fields that
   feed each PageMap.

## Where it lives in the admin menu

The settings page is at **Configuration → Search and metadata → PageMap**
(`/admin/config/search/pagemap`). After configuring your PageMap embeds, you'll need
to have your site **re‑indexed** for the changes to take effect in search.
