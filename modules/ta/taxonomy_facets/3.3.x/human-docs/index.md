# Taxonomy Facets — manual setup guide

**Taxonomy Facets** (`taxonomy_facets`) turns your vocabularies into a faceted
browsing experience — the filter sidebars you see on shops and catalogues —
using clean URLs and **no JavaScript at all**. Every combination of filters is
its own plain, server‑rendered page (for example `/browse/main/europe/italian`),
so the whole faceted site can even be frozen to static HTML and still browse like
a live CMS.

The trick is that it takes the opposite approach to most faceted search. There is
no search backend, no live query engine, and no client‑side state — just links.
A node listing lives at a configurable base path (default `/browse`), and each
segment of the URL is a taxonomy term's URL alias. Hierarchical terms are written
as their full ancestor trail, root first, so the hierarchy is visible right in
the address bar. Selection is single‑select per vocabulary — only the leaf term
filters, its ancestors are just the readable trail — and the segments are ordered
canonically so every filter combination has exactly one URL. The listing shows
the nodes that match the intersection of all the terms in the URL: terms from
different vocabularies are AND‑ed together, and selecting a parent term also
matches content tagged with any of its descendants, to any depth.

The facet menus themselves are rendered by a configurable block, one vocabulary
per block, as nested HTML links; selecting a term applies it (replacing any
current term from the same vocabulary) while keeping your other facets, and
active facets get a "remove" link. An optional per‑block "Collapse hierarchy"
mode gives you drill‑down navigation that opens one branch at a time — and,
because the open state is just the selected term's own page, it drills down
identically in a static export with no JavaScript. Each term can also show a
contextual count of how many results selecting it would give.

The payoff is faceted navigation you can serve from a CDN for almost nothing,
with no server‑side attack surface, where every facet page is a distinct,
crawlable, SEO‑friendly URL. The flip side of that same design is worth planning
for: facets create a great many crawlable URLs, so keep crawl budget and
duplicate‑content in mind (the XML Sitemap submodule helps here). The listed
content always respects its own access; the module shapes listings but has no
access‑control role of its own. It is configured at a settings form, has no
dependencies beyond core, and this branch targets Drupal 11 (and 12). Three
optional submodules extend it — see the table below.

This guide is written for a **human** setting the site up through the admin UI.
If you are an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — set the base path, place a facet
   menu block, and tune the options.

## Where it lives in the admin menu

Its settings are on the **Taxonomy Facets settings form**
(`taxonomy_facets.settings_form`), where you configure the browse base path and
facet behaviour. The facet menus are placed as **blocks** through the Block
layout UI, one vocabulary per block. Browsing then happens at your configured
base path (default `/browse`).

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **URL Export** | `taxonomy_facets_export` | Exports the set of facet URLs. |
| **Tome Static export** | `taxonomy_facets_tome` | Integration with Tome so the whole faceted site can be frozen to static HTML and served from a plain web server or CDN, with faceted filtering still working. |
| **XML Sitemap** | `taxonomy_facets_simple_sitemap` | Simple XML Sitemap integration, so the many facet URLs can be surfaced to search engines (and to help manage crawl). |
