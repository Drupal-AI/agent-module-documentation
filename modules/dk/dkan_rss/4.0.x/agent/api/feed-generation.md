<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# dkan_rss — route, controller, services, block

## Install / enable
`ddev drush en dkan_rss -y`. Requires DKAN (`dkan`, `dkan_metastore`) and `facets` already
present (composer: `drupal/dkan:^4`, `drupal/facets`, `symfony/property-access`). No config form,
no config to import, no permissions declared by this module.

## Route (`dkan_rss.routing.yml`)
```
dkan_rss.dataset_rss:
  path: '/datasets.rss'
  methods: [GET]
  defaults: { _controller: '\Drupal\dkan_rss\Controller\DkanRssController::datasetRss' }
  requirements: { _permission: 'access content' }
```
Single endpoint. Takes no query/path parameters. Requires core permission `access content`.

## Controller — `DkanRssController` (`src/Controller/DkanRssController.php`)
Implements `ContainerInjectionInterface`; `create()` injects `dkan_rss.rss_creator.service`.
`datasetRss()` returns a Symfony `Response` with `Content-Type: application/rss+xml` whose body is
`$this->rssCreator->datasetRss()`. No caching metadata is set.

## Service — `DkanRssCreator` (`src/DkanRssCreator.php`)
Constructor args (see `dkan_rss.services.yml`): `SchemaRetriever`, `dkan.metastore.service`
(`MetastoreService`), `dkan.metastore.storage` (`DataFactory`), `@entity.repository`,
`@extension.list.module`. Builds a Symfony `Serializer` with `ObjectNormalizer` +
`XmlEncoder(['xml_root_node_name' => 'rss'])`.

`datasetRss()` flow:
1. `retrieveDatasets()` → `storage->getInstance('dataset')->retrieveAll()` — all **published**
   datasets (metastore filters `status = 1`), each a JSON string.
2. `rssSchema()` → template JSON (override via `SchemaRetriever`, else shipped file); `json_decode`.
3. `addAtomLink($rssSchema->channel)` — self `atom:link`.
4. Per dataset: `json_decode`, then for each `channel->item` key apply the mapping rules
   (string property / method name / nested object via `nestedProperty()`), then `removeEmptyItems`,
   `_formatters`, `_attributes` (see `../config/feed-schema.md`).
5. Apply `_sort` (`uasort` with the named comparator: `dateSort`/`baseSortAsc`/`baseSortDesc`) and
   `_limit` (`array_slice`); unset both directives.
6. `removeEmptyItems($channel)`; `serializer->serialize($rssSchema, 'xml')` → returned string.

Helper methods: `nestedProperty()` (recursive path walk, space-concatenates leaves),
`rfc822Date()` (`\DateTime` → RFC2822, input on failure), `rss_item_link()` (loads node by dataset
`identifier` UUID via `entityRepository`, returns canonical absolute URL or `FALSE`),
`removeEmptyItems()`, comparators.

## Service — `SchemaRetriever` (`src/SchemaRetriever.php`)
Extends `Drupal\dkan_metastore\SchemaRetriever`. Only override: `getAllIds()` appends
`'dataset.rss.feed'` so the feed template participates in DKAN's schema retrieval (enabling the
override-by-copy mechanism). Constructed with `%app.root%` and `@extension.list.module`.

## Block — `RssLinkBlock` (`src/Plugin/Block/RssLinkBlock.php`)
`@Block(id = "dkan_rss_rss_link", category = "DKAN RSS")`. `build()` renders theme
`dkan_rss_link` with `#link` = `Url::fromRoute('dkan_rss.dataset_rss')->toString()` and
`#text = t('RSS link')`. Template `templates/dkan-rss-link.html.twig`:
`<a href="{{ link }}">{{ text }}</a>`. Theme hook declared in `dkan_rss_theme()`
(`dkan_rss.module`).

## Operate
- Enable module → feed live at `/datasets.rss` with the default template and demo/real datasets.
- Customize appearance by overriding `dataset.rss.feed.json` (see `../config/feed-schema.md`).
- Place the "RSS Link" block (category "DKAN RSS") in a region to expose a subscribe link.
