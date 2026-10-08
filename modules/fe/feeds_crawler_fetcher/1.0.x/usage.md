<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Feeds Crawler Fetcher adds a Feeds fetcher that downloads a whole list of URLs as a single import.

---

Feeds Crawler Fetcher provides one extra fetcher plugin, **"Crawl a set of url"** (id `crawler`), for the Feeds import framework. Rather than a single feed source URL, the feed's source becomes a textarea in which you enter one URL per line; on import the fetcher requests every listed URL server-side using Drupal's core HTTP client and combines the responses into one result file that your chosen parser then processes. An optional **paged** mode lets a URL contain a `<page>` token that is substituted with a sequence of page numbers (0 up to the configured total), so a paginated source can be pulled without listing every page URL by hand. Responses are combined as JSON (json-decoded and array-merged) or as HTML (concatenated), depending on the fetcher's "Type of information" option. Despite the name, it does not discover or follow links inside fetched content — it only fetches the static list of URLs you configure. It needs the Feeds module.

---

- Import from several source URLs in a single Feeds import instead of one feed per URL.
- Point one feed at a newline-separated list of URLs.
- Fetch a paginated source by adding a `<page>` placeholder and a page count.
- Aggregate multiple JSON endpoints into one merged JSON result for the parser.
- Aggregate multiple HTML/XML pages into one concatenated result for the parser.
- Add a "Crawl a set of url" fetcher option to a Feeds feed type.
- Pair the fetcher with an HTML/XML or JSON parser (for example Feeds Extensible Parsers) to map fields.
- Pull page 0..N of a listing endpoint by templating the page number into the URL.
- Consolidate content spread across multiple pages of the same site.
- Import product/catalog listings that are split across paged URLs.
- Import article or news listings that expose one URL per page.
- Collect data from multiple regional or per-category endpoints into one feed.
- Reuse the standard Feeds mapping and processor with a multi-URL source.
- Set a per-request timeout for the outbound fetches.
- Enable download caching of response headers per feed (default) or force re-download.
- Keep all fetched content in a single temp file handed to the parser as the fetch result.
- Clear cached fetch metadata automatically when a feed is deleted.
- Schedule the multi-URL import on Feeds' normal cron/import runs.
- Migrate a set of static pages into Drupal entities via Feeds.
- Replace several single-URL feeds with one consolidated crawling feed.
- Batch-import from an API that paginates results by a numeric page parameter.
