<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views RSS: DC Elements adds the full Dublin Core Metadata Element Set (`dc:title`, `dc:creator`, `dc:date`, ...) as selectable RSS item elements alongside core RSS elements.

---

This submodule implements `hook_views_rss_namespaces()` (declaring the `dc` namespace, `http://purl.org/dc/elements/1.1/`) and `hook_views_rss_item_elements()`, returning all fifteen Dublin Core elements (`dc:title`, `dc:creator`, `dc:subject`, `dc:description`, `dc:publisher`, `dc:contributor`, `dc:date`, `dc:type`, `dc:format`, `dc:identifier`, `dc:source`, `dc:language`, `dc:relation`, `dc:coverage`, `dc:rights`) as configurable item-element options in the row plugin's settings form, under an "Item elements : dc" fieldset. Most elements are plain pass-through text fields with only descriptive help text; two get special preprocessing: `dc:creator` strips a trailing "Author"/"Role..." suffix pattern (mirroring `views_rss_core`'s `<author>` handling) down to a clean name, and `dc:date` is first normalized through `views_rss_core`'s pubDate preprocessor (to strip stray HTML wrapper tags) and then reformatted to ISO-8601 (`date('c', ...)`) as Dublin Core's date profile requires, rather than the RFC-822 format core RSS elements use. Enabling this submodule adds the `dc` XML namespace declaration to the feed's `<rss>` root element automatically whenever any `dc:*` element is configured on a view.

---

- Add `dc:creator` to credit a content author on each RSS item, alongside or instead of `<author>`.
- Add `dc:date` for an ISO-8601-formatted publication date (as opposed to RFC-822 `pubDate`).
- Add `dc:subject` to expose taxonomy/keyword metadata per item for DC-aware aggregators.
- Add `dc:description` with relative-path rewriting, separate from the RSS `<description>`.
- Add `dc:publisher` / `dc:contributor` to credit an organization or additional contributors.
- Add `dc:type` / `dc:format` to describe an item's genre or physical/digital manifestation.
- Add `dc:identifier` for a formal unique identifier (DOI, ISBN, URI) distinct from `<guid>`.
- Add `dc:source` to reference the resource an item was derived from.
- Add `dc:language` to tag an item's content language per RFC 1766.
- Add `dc:relation` / `dc:coverage` for related-resource or spatial/temporal scope metadata.
- Add `dc:rights` to publish a copyright/licensing statement per item.
- Publish a feed compatible with library/archival aggregators that expect Dublin Core metadata.
- Combine with `views_rss_core` so an item carries both native RSS and DC element sets.
- Automatically get the `dc` namespace declared on `<rss>` without manually entering its URI.
- Supply Dublin Core metadata for content syndicated into DC-aware catalog/search systems.
