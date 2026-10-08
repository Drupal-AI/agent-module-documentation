<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views RSS: Core Elements registers the standard RSS 2.0 `<channel>` and `<item>` elements (title, link, description, guid, pubDate, enclosure, category, ...) with the parent Advanced Views RSS Feed module.

---

This submodule implements `hook_views_rss_namespaces()` (declaring the `atom` and `content` namespaces), `hook_views_rss_channel_elements()` (title, description, link, atom:link, language, category, image, copyright, managingEditor, webMaster, generator, docs, cloud, ttl, skipHours, skipDays, pubDate, lastBuildDate), and `hook_views_rss_item_elements()` (title, link, description, author, category, comments, enclosure, guid, pubDate, source, content:encoded). It is a required dependency of the row plugin: `RssFields::validate()` in `views_rss`'s row plugin refuses to save a View unless `views_rss_core` is enabled, because RSS 2.0 requires every item to carry a title or description and only this submodule provides those. Most of its elements carry a `preprocess functions` chain (in `views_rss_core.inc`) that turns a raw field/view value into RSS-ready markup: comma-separated category strings become multiple `<category>` tags, taxonomy term hierarchies become slash-delimited category paths with a `domain` attribute, file/image fields become `<enclosure>` with `url`/`length`/`type` attributes, and dates are RFC-822-formatted. It also implements `hook_views_rss_date_sources()` and `hook_views_query_alter()` so the channel `<lastBuildDate>` can be derived from the most-recently-changed row in the View's base table.

---

- Enable the minimum RSS 2.0-compliant feed: map a field to `title` and/or `description`.
- Add an item `<link>` element pointing at each node/entity's canonical URL.
- Add a `<guid>` element with `isPermaLink` set automatically based on whether the link is absolute.
- Attach a downloadable file or image as an `<enclosure>` with correct `length`/`type` attributes.
- Turn a taxonomy-reference field into one or more `<category>` elements with hierarchical paths.
- Add a `<comments>` link so feed readers can jump to a node's comment page.
- Populate channel `<image>` (feed artwork) from a path, with title/link/description sub-elements.
- Set channel `<copyright>`, `<managingEditor>`, `<webMaster>`, and `<generator>` text elements.
- Set channel `<ttl>` so aggregators know how long to cache the feed.
- Hint aggregators which hours/days to skip polling via `<skipHours>`/`<skipDays>`.
- Add a self-referencing `<atom:link rel="self">` element automatically.
- Let the channel `<language>` default to the current site language when left blank.
- Add an `<author>` element derived from an "Authored by" field, stripping role suffixes.
- Add a `<source>` element identifying which RSS channel/site an item came from.
- Provide full HTML content via `<content:encoded>` (CDATA-wrapped) alongside a short `<description>`.
- Derive channel `<pubDate>` and `<lastBuildDate>` from the most recent item date automatically.
- Validate an admin-entered channel `<image>` path against RSS's 144x400px size limit.
- Validate a channel `<docs>` URL is well-formed before saving the View.
- Combine with `views_rss_dc` or `views_rss_media` to add Dublin Core / MRSS elements on top of core ones.
- Satisfy the row plugin's hard requirement (`views_rss_core` enabled) for any feed built with `rss_fields`.
- Rewrite relative image/link paths inside `<description>` to absolute URLs for off-site feed readers.
