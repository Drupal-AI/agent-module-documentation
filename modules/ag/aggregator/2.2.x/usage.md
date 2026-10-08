Aggregator ingests syndicated content (RSS, RDF, Atom) from external feed URLs into your Drupal site, storing each source as an `aggregator_feed` entity and each imported article as an `aggregator_item`, then displaying them on `/aggregator` and in blocks. It is the former Drupal core module (deprecated in core 9.4, removed in 10.0) now maintained in contrib, and powers Drupal Planet.

---

Administrators add feeds (a title, URL, and refresh interval) at `/admin/config/services/aggregator`, or bulk-import them from an OPML file. On cron, `hook_cron()` queues each feed whose refresh interval has elapsed into the `aggregator_feeds` queue; the `AggregatorRefresh` queue worker then runs the three-stage import pipeline. That pipeline is built from three swappable plugin types: a single **fetcher** downloads the raw feed (default uses Guzzle with ETag/If-Modified-Since caching), a single **parser** converts it to a common item structure (default uses the `laminas/laminas-feed` reader), and one or more **processors** act on the parsed items (the default processor stores them as `aggregator_item` entities and trims old ones). Global settings — active fetcher/parser/processors, items-per-listing, and a discard-old-items age — live in `aggregator.settings`; the default processor also contributes its own settings to the same form. Items are rendered through the restricted `aggregator_html` text format, and feeds ship with two Views (`aggregator_rss_feed`, `aggregator_sources`) plus an "Aggregator feed" block. Two permissions gate the module: "access news feeds" to view and "administer news feeds" to manage. The module invites customization through three `hook_*_info_alter()` hooks and the fetcher/parser/processor plugin interfaces. Feeds can perform SSRF-style requests, so grant the admin permission only to trusted roles.

---

- Pull an external site's RSS/Atom feed into your Drupal site and show it at `/aggregator`
- Build a "news river" or planet-style aggregation page from many source feeds (as Drupal Planet does)
- Add feeds with a per-feed refresh interval so cron keeps them up to date automatically
- Bulk-import a set of feeds from an OPML file exported by another reader
- Show the latest N items from one feed in a sidebar block via the "Aggregator feed" block
- Automatically discard aggregated items older than a configurable age to cap storage
- Limit how many items appear on feed listing pages site-wide
- Expose aggregated feeds and items to Views for custom listing pages and RSS output
- Re-publish an aggregated feed as your own RSS via the `aggregator_rss_feed` view
- Manually refresh a single feed's items on demand from the admin overview
- Delete all stored items for a feed without deleting the feed itself
- Replace the download step by writing a custom **fetcher** plugin (e.g. authenticated or proxied fetches)
- Replace the parsing step with a custom **parser** plugin for a non-standard feed format
- Add a custom **processor** plugin to push parsed items to an external system instead of (or in addition to) storing them
- Swap in an alternate fetcher/parser/processor class at runtime via `hook_aggregator_{fetcher,parser,processor}_info_alter()`
- Read aggregated items programmatically as `aggregator_item` entities for use elsewhere on the site
- Trigger a feed import in code by calling the `aggregator.items.importer` service's `refresh()`
- Normalize feed item post dates to import time when source timestamps are unreliable
- Render feed/item output with custom templates (`aggregator-feed.html.twig`, `aggregator-item.html.twig`)
- Migrate Drupal 6/7 aggregator feeds and items into Drupal 10/11 (migrate hooks provided)
- Filter aggregated content by feed using the `aggregator_sources` view
- Give anonymous or authenticated roles read-only access to aggregated news with "access news feeds"
- Restrict feed management to trusted editors with "administer news feeds" (mitigates SSRF risk)
- Sanitize untrusted feed HTML automatically through the restricted `aggregator_html` filter format
- Display an aggregated item's title as a link to the source article via the "Aggregator title" field formatter
- Expose feeds over JSON:API with a filter-access hook that respects the view permission
- Cache-validate feeds with ETag/Last-Modified so unchanged sources are not re-downloaded
