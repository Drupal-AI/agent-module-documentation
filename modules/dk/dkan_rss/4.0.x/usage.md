DKAN Dataset RSS feed exposes the datasets in a DKANv2 metastore as an RSS 2.0 feed at `/datasets.rss`.

---

The module registers a single GET route, `/datasets.rss` (`dkan_rss.dataset_rss`), whose controller returns an `application/rss+xml` response built by the `dkan_rss.rss_creator.service` (`DkanRssCreator`). The creator pulls every published dataset from the metastore (`storage->getInstance('dataset')->retrieveAll()`), decodes each dataset's `dataset.json`, and maps its properties onto RSS channel/item elements using a JSON template, `dataset.rss.feed.json`. That template drives everything: simple property-to-element mappings (`title`, `description`), nested property paths (e.g. `dc:creator` drawn from `publisher.name`), method-backed values (`rss_item_link` resolves a dataset's canonical node URL by UUID), per-field `_formatters` (e.g. `rfc822Date` for `pubDate`), `_attributes` (e.g. `guid[@isPermaLink]=false`), a `_sort` directive (default `dateSort`, newest first), and a `_limit`. The default template lives in the module at `schema/dataset.rss.feed.json`; the `SchemaRetriever` service registers the `dataset.rss.feed` schema id so a copy placed in DKAN's schema directory overrides it, falling back to the shipped file when none is present. Empty item properties are stripped, and an `atom:link` self-reference is added for feed-validator compliance. A `dkan_rss_rss_link` block (category "DKAN RSS") renders an `<a>` link to the feed. It requires DKAN (dkan, dkan_metastore) and Facets.

---

- Publish an RSS feed of all datasets in a DKAN open-data portal at `/datasets.rss`.
- Let data consumers subscribe to new/updated datasets in any RSS reader.
- Syndicate dataset metadata (title, description, link, publisher, publication date) to aggregators.
- Provide a machine-readable dataset stream alongside DKAN's JSON metastore API.
- Map a dataset's `title` and `description` to the RSS item title and description via the template.
- Link each RSS item to its dataset's canonical node page (resolved from the dataset UUID).
- Emit the dataset publisher name as `dc:creator` using the Dublin Core namespace.
- Set each item's `pubDate` from the dataset's `issued` date and format it as RFC822/RFC2822.
- Order feed items by publication date, newest first, using the `_sort: dateSort` directive.
- Cap the number of items in the feed with the `_limit` property (0 = unlimited).
- Mark item `guid` values as non-permalinks via the `_attributes` directive.
- Customize the feed layout by copying `dataset.rss.feed.json` into DKAN's schema directory and editing it.
- Add new RSS elements by mapping additional `dataset.json` properties in the template.
- Build nested/compound RSS elements from deep `dataset.json` property paths.
- Concatenate multiple source properties into a single RSS element value (nested-property accumulation).
- Add an "RSS feed" link to any region/page using the provided RSS Link block.
- Expose a standards-compliant feed (self `atom:link`, RFC822 dates) that passes the W3C feed validator.
- Serve the feed without additional configuration immediately after enabling the module.
- Integrate with DKAN demo/sample content to produce a valid feed out of the box.
- Provide open-data catalog syndication for data.gov-style DKAN portals.
