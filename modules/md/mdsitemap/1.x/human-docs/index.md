# Markdown Sitemap (LLM) — manual setup guide

**Markdown Sitemap (LLM)** (`mdsitemap`) generates a dedicated sitemap aimed at **LLM
(AI) crawlers** rather than search engines. Where a traditional `sitemap.xml` lists page
URLs for search indexing, this module publishes a separate endpoint at **`/sitemap-llm`**
that lists your content URLs with a **configurable suffix** — for example `.md`, `.txt` or
`.ai` — so you can point AI crawlers at machine‑readable versions of your pages. It pairs
naturally with a module like [Markdownify](https://www.drupal.org/project/markdownify) that
serves clean Markdown or text versions of your content, and it is compatible with the
`llms.txt` convention (just add a link to `/sitemap-llm`).

The sitemap automatically detects any entity type that has a canonical URL, and you choose
in the admin UI exactly which entity types and bundles to include — nodes, taxonomy terms,
media, commerce products, and so on. It keeps itself fresh with automatic cache
invalidation whenever entities are inserted, updated or deleted, or when its configuration
changes, and it has no dependencies beyond Drupal core.

One deliberate consideration to weigh up front: this module **intentionally makes your
content more available to AI crawlers** — and, in practice, to any consumer that can read
the sitemap, since a Markdown content map is easy for anyone to scrape. Treat turning it on
as a policy choice, and include only **public content you actually intend AI systems to
ingest**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — choose the URL suffix and the entity types
   and bundles to include, on the MD Sitemap settings page.

## Where it lives in the admin menu

After installing, the settings page is at **Configuration → Search and metadata → MD
Sitemap** (`/admin/config/search/md-sitemap`). The generated sitemap itself is served at
**`/sitemap-llm`**.
