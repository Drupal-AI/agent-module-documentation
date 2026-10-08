# Core Views Facets — manual setup guide

**Core Views Facets** (`core_views_facets`) is an add-on for the
[Facets](https://www.drupal.org/project/facets) module that lets you build faceted
navigation from an **ordinary Views page** — using that view's exposed or
contextual filters — **without a Search API index**. Normally Facets works on top
of a Search API index; this module teaches Facets to treat a plain,
database-backed Views page as a facet source instead, so you can add clickable
"drill-down" facet blocks (Content type, Tags, Published, and so on) to a listing
you already built in Views.

The practical win is reach and simplicity: any catalogue, directory or article
listing that's a Views page with exposed filters can gain multi-attribute faceted
navigation, with optional AJAX in-place refresh, and no separate search index to
build and maintain. It's a good fit when a full Search API setup would be overkill,
or when you want to migrate an existing SQL-backed view to faceting cheaply.

Setting it up is a short **multi-step workflow through the Facets UI and your
view** — this module has no settings form of its own (`configure: null`). The one
step you must not skip is switching the facet source's URL processor to *Core views
url processor*; without it the facet links won't actually filter the view. This
guide is written for a **human** clicking through the admin UI; if you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead. The module requires the **Facets**
module (`^2.0 || ^3.0`) plus core's **Views** and **System**, has no submodules,
and adds no third-party libraries.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in
   Facets) and enable it.
2. [Configuration](configuration/index.md) — the step-by-step setup: prepare the
   view, set the required URL processor, add a facet, and place its block.

## Where it lives in the admin menu

The module itself adds no admin page. You do all the work through the **Facets**
admin area at **Configuration → Search and metadata → Facets**
(`/admin/config/search/facets`), plus your view's edit screen and **Block layout**.

## How to use it

Once installed and enabled, every Views **page** display that has an exposed
and/or contextual filter automatically shows up in Facets as a facet source. From
there you assign the required URL processor, add facets on the view's filters, and
place the facet blocks. The full walkthrough is in
[Configuration](configuration/index.md).
