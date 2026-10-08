# Search API Location — manual setup guide

**Search API Location** (`search_api_location`) adds **proximity / distance
search** to the Search API framework. Once a geofield is indexed with one of the
module's spatial data types, you can filter, sort, and facet your search results
by how far they are from a chosen point — the foundation for "stores near me",
"events within 10 km", and similar location-aware searches.

The module registers two Search API **data types** you assign to a geofield on an
index: **Latitude/Longitude** (`location`), used for Views-based distance
filtering and sorting, and **Spatial Recursive Prefix Tree** (`rpt`), needed for
interactive map heatmap facets. At index time it converts the geofield's stored
value into a `lat,lon` coordinate. It also defines a **Location Input** plugin
type — the way an end user supplies the "search from here" point — with built-in
options for typing raw coordinates or picking a spot on a Google map.

One important caveat: the search **backend must support these spatial data
types.** Search API Solr is the known-good backend; the default database backend
does **not** do spatial search. Search API Location has a couple of Composer
dependencies (the Search API module and the geoPHP library) and ships three
optional submodules: **Search API Location Views** (proximity filter/argument/sort
for Views), **Facets Map Widget** (an interactive Leaflet heatmap facet), and
**Search API Location Geocoder** (lets users type an address that gets geocoded).
It has no settings form of its own — you configure everything through Search API's
own admin UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the data-type
plugins and the Location Input plugin type — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (and its
   library), enable the module, and pick the submodules you need.
2. [Configuration](configuration/index.md) — index a geofield with a spatial data
   type, the backend requirement, and distance units.

## Where it lives in the admin menu

Search API Location adds no page of its own. You configure it entirely inside
**Search API** at **Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`), on each index's **Fields** page.

## How to use it

At a high level: add a geofield to your content, add that geofield to a Search API
index and set its **Type** to *Latitude/longitude* (and/or *Recursive Prefix Tree*
for heatmaps), reindex, then build the actual proximity search with the Views
submodule or a map facet. The step-by-step is in
[Configuration](configuration/index.md).
