# Facets Pretty Paths — manual setup guide

**Facets Pretty Paths** (`facets_pretty_paths`) makes faceted-search URLs
readable. Out of the box, the [Facets](https://www.drupal.org/project/facets)
module encodes active filters as query strings like
`?f[0]=brand:drupal&f[1]=color:blue`. This module swaps that for clean,
slash-separated "pretty" paths such as `/brand/drupal/color/blue` — friendlier
for visitors, more shareable, and much better for SEO.

It works by plugging into Facets as an alternative **URL processor**. You switch
a facet source from the default query-string processor to the pretty-paths
processor, and from then on every facet on that source reads and writes its
active filters as extra path segments. The module also registers the routes
needed for those paths to resolve back to your search page and builds
breadcrumbs from the active filters.

How each raw facet value is turned into a URL segment (and back) is handled by a
pluggable **coder**. The module bundles several coders so you can control the
look of your slugs — for example encoding a taxonomy-term facet as
`/color/blue-2` (name + ID) or `/color/blue` (name only), a node-reference facet
as `/author/jane-doe-7`, or a list field as `/size/large-3`. Developers can add
their own coder plugin for bespoke needs.

There is **no admin settings page of its own** — all configuration happens on the
Facets facet-source and facet edit forms. It requires both **Facets** and
**Pathauto** (the latter supplies the alias cleaner several coders use).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including
   Facets and Pathauto) and enable the module.
2. [Configuration](configuration/index.md) — switch a facet source to pretty
   paths and choose a coder per facet.

## Where it lives in the admin menu

Facets Pretty Paths adds no menu items of its own. You configure it entirely from
the Facets admin area at **Configuration → Search and metadata → Facets**
(`/admin/config/search/facets`) — on the facet-source edit form and on each
facet's edit form.

## How to use it

1. Have a working faceted search built with the Facets module.
2. Edit the **facet source** and set its **URL Processor** to **Pretty paths**.
3. Rebuild the cache so the new routes register.
4. On each facet, pick the **Pretty paths coder** that produces the slug style
   you want.

See [Configuration](configuration/index.md) for the step-by-step detail.
