<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DKAN Dataset RSS feed (dkan_rss) — agent index

**Serves a schema-mapped RSS 2.0 feed of DKAN datasets at `/datasets.rss`.**

- **Version dir:** 4.0.x (installed `dev-4.0.x`) · **Core:** `^10 || ^11` · **License:** GPL-2.0-or-later · **Package:** DKAN
- **Requires:** modules `dkan`, `dkan_metastore`, `facets`; composer `drupal/dkan:^4`, `drupal/facets`, `symfony/property-access`. No settings form, no permissions of its own, no Drush.

## What it provides
- **Route** `dkan_rss.dataset_rss` → `GET /datasets.rss`, requirement `_permission: 'access content'`, response `Content-Type: application/rss+xml` (`DkanRssController::datasetRss`).
- **Services** (`dkan_rss.services.yml`):
  - `dkan_rss.rss_creator.service` → `DkanRssCreator` — builds the feed XML from published datasets + the JSON template.
  - `dkan_rss.schema_retriever.service` → `SchemaRetriever` (extends `dkan_metastore` `SchemaRetriever`) — registers the `dataset.rss.feed` schema id so an overriding copy in DKAN's schema dir is found.
- **Template** `schema/dataset.rss.feed.json` — the default RSS-mapping template (not a Drupal config schema; a DKAN JSON schema file).
- **Block plugin** `dkan_rss_rss_link` (`RssLinkBlock`, category "DKAN RSS") — renders `<a href="/datasets.rss">RSS link</a>` via theme hook `dkan_rss_link` (`templates/dkan-rss-link.html.twig`).
- **Theme hook** `dkan_rss_link` (`dkan_rss_theme()` in `dkan_rss.module`) with `link`, `text` vars.

## How the feed is built
`DkanRssCreator::datasetRss()` retrieves all published datasets, decodes each `dataset.json`, and maps its properties onto RSS item elements per the template — simple maps, nested paths (`nestedProperty`), method-backed values (`rss_item_link` resolves canonical node URL by UUID), `_formatters` (`rfc822Date`), `_attributes`, `_sort` (`dateSort`/`baseSortAsc`/`baseSortDesc`), `_limit`. Serializes with Symfony `Serializer` + `XmlEncoder`. See the solution docs.

## Solution docs
- [`agent/config/feed-schema.md`](config/feed-schema.md) — the `dataset.rss.feed.json` template: mappings, nested properties, formatters, attributes, sort, limit, and how to override it.
- [`agent/api/feed-generation.md`](api/feed-generation.md) — route, controller, `DkanRssCreator`/`SchemaRetriever` services, block, and the request→XML flow.
