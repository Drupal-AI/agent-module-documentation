<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# dkan_rss — feed template (`dataset.rss.feed.json`)

The feed layout is a JSON template, not Drupal config. Default ships at
`schema/dataset.rss.feed.json`. Each dataset's decoded `dataset.json` is mapped onto RSS
`channel`/`item` elements by `DkanRssCreator::datasetRss()`.

## Override / customize
`SchemaRetriever::getAllIds()` appends the id `dataset.rss.feed` to the DKAN metastore schema
list, so `DkanRssCreator::rssSchema()` first tries `schemaRetriever->retrieve('dataset.rss.feed')`
(a copy placed in DKAN's schema directory) and, on any exception, falls back to
`file_get_contents(.../dkan_rss/schema/dataset.rss.feed.json)`. To customize: copy
`dataset.rss.feed.json` into DKAN's schema location and edit it there — no code change needed.

## Template structure
Top level mirrors the RSS document: `@xmlns:dc`, `@xmlns:atom`, `@version`, and a `channel`
object. `channel.item` is the per-dataset mapping. `_sort` and `_limit` are directives consumed
and removed before serialization.

### Item field mapping (per dataset)
For each key in `channel.item` (`datasetRss()` loop):
- **String value** = a `dataset.json` property name. If that property exists on the dataset it is
  copied in (`$item->{key} = $dataset->{value}`). Defaults: `title` → item `title`,
  `description` → `description`, `pubDate` → dataset `issued`.
- **String value that is not a dataset property** but matches a method on `DkanRssCreator` is
  called with the dataset: `link` → `rss_item_link` resolves the item's canonical node URL by
  loading the node whose UUID equals `dataset.identifier`
  (`entityRepository->loadEntityByUuid('node', identifier)`; returns `FALSE` if not a node).
- **Object value** = a nested path, walked by `nestedProperty()`. Example `dc:creator` =
  `{ "publisher": { "name": "#" } }` reads `dataset.publisher.name` into the element's text
  (`#`). Multiple matched leaves are space-concatenated. `guid` = `{ "identifier": "#" }` reads
  `dataset.identifier`.

### `_formatters`
`item._formatters` maps an item field to a `DkanRssCreator` method applied to its value after
mapping. Shipped: `{ "pubDate": "rfc822Date" }` — `rfc822Date()` parses the value with
`\DateTime` and reformats to `DateTime::RFC2822` (returns input unchanged on parse failure).

### `_attributes`
`item._attributes` wraps a scalar field value into an element with XML attributes. Shipped:
`{ "guid": { "@isPermaLink": "false" } }` produces `<guid isPermaLink="false">…</guid>` (the
value is moved to the `#` text of a clone of the attribute object).

### `_sort` (channel level)
`_sort` maps the sort property to a comparator method used with `uasort`. Shipped:
`{ "pubDate": "dateSort" }`. `dateSort()` sorts by parsed date descending (newest first),
pushing empty dates to the end. Also available: `baseSortAsc`, `baseSortDesc` (spaceship on the
raw property). Removed from output after sorting.

### `_limit` (channel level)
Integer cap on item count via `array_slice`. `0` (default) = unlimited. Removed after applying.

## Always-applied behavior
- `addAtomLink()` injects a channel `atom:link` (`@href` = absolute URL of `dkan_rss.dataset_rss`,
  `@rel=self`, `@type=application/rss+xml`) for W3C-validator compliance.
- `removeEmptyItems()` strips empty properties from each item and from the channel before output.
- Only **published** datasets appear: the metastore `retrieveAll()` (called with no args) filters
  to `status = 1`.

## Notes
- `channel.title/link/description/copyright/pubDate` are static template values (edit the copy to
  set your portal's title/link). Empty ones are dropped by `removeEmptyItems()`.
- Output is serialized by Symfony `Serializer`+`XmlEncoder` (root node `rss`) and returned as
  `application/rss+xml`.
