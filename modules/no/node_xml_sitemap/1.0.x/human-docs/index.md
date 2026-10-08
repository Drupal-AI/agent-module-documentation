# Node XML Sitemap — manual setup guide

**Node XML Sitemap** (`node_xml_sitemap`) provides a **node‑based XML sitemap** — it
generates sitemap entries for your node content so search engines can discover and
index your pages. It is built on top of the contributed **XML Sitemap** module and
focuses the sitemap specifically on nodes, giving you a straightforward, node‑driven
sitemap by content type.

Because it builds on XML Sitemap, that module does the actual sitemap generation and
submission; Node XML Sitemap adds a node‑oriented listing that shows the valid node
URLs it will include. As an SEO feature it should only ever surface content that is
genuinely public and indexable — respect each node's published and access state — and
it has no access‑control role of its own.

The module provides a page (its `node_xml_sitemap.form` route) that lists the valid
node URLs for your project. There is very little to set up beyond enabling it and the
underlying XML Sitemap module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it and its XML Sitemap dependency.
2. [Configuration](configuration/index.md) — the node‑URL listing page and how
   inclusion is driven by XML Sitemap.

## Where it lives in the admin menu

Once enabled, the module's listing page shows the valid node sitemap URLs at
`/admin/node-sitemap-listing`. The underlying sitemap itself is managed through the
**XML Sitemap** module at **Configuration → Search and metadata → XML sitemap**.
