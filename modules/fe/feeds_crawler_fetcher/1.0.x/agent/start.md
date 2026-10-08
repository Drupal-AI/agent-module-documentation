<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feeds Crawler Fetcher (feeds_crawler_fetcher) — agent index

Adds **one Feeds fetcher plugin** to the [Feeds](https://www.drupal.org/project/feeds) import
framework: id **`crawler`**, title *"Crawl a set of url"*. The feed source is a **textarea of URLs,
one per line**; on import every URL is fetched server-side and the responses are combined into a
single result file for the parser. Version **1.0.1**. Core `^10 || ^11`. Package (info.yml) `Custom`;
canonical category **Import and export / Feed aggregation**. License GPL-2.0-or-later.

- **The fetcher, the URL-list + paged fetch loop, JSON/HTML combining, config options, result** →
  [fetcher/crawler-fetcher.md](fetcher/crawler-fetcher.md)

## What it actually is

- One plugin instance: `CrawlerFetcher` (`@FeedsFetcher` id **`crawler`**), in
  `src/Feeds/Fetcher/CrawlerFetcher.php`, extending Feeds' `PluginBase` and implementing
  `FetcherInterface`, `ClearableInterface`, `ContainerFactoryPluginInterface`. It is **not** a new
  plugin type — it is a fetcher for Feeds' existing fetcher plugin type.
- Two plugin forms: `Form/CrawlerFetcherForm` (fetcher configuration: type of information, paged
  fetcher, total pages) and `Form/CrawlerFetcherFeedForm` (the per-feed **Feed URL** textarea).
- Result object `CrawlerFetcherResult` (`src/Feeds/Result/CrawlerFetcherResult.php`) extends Feeds'
  `FetcherResult` and deletes the temp file on `cleanUp()`.
- **No** routes, permissions, services, hooks, Drush, config/install, or config/schema ship (no
  `*.routing.yml`/`*.permissions.yml`/`*.services.yml`/`config/`/`.module`/`.install`; only the
  info.yml + `src/**` + `README.md` + `LICENSE.txt`).

## Dependencies

- **Hard runtime dependency on the `feeds` module** — it uses `Drupal\feeds\*` classes and the
  services `cache.feeds_download` and `feeds.file_system.in_progress`. This is **not declared** in
  `feeds_crawler_fetcher.info.yml` (no `dependencies:` key), so enable `feeds` yourself. No
  `composer.json` ships. README also suggests a parser such as Feeds Extensible Parsers (`feeds_ex`)
  for the HTML/XML case.

## Behavior notes (from source — see the solution doc)

- The `crawler` name is a misnomer: it does **not** follow/discover links — it fetches only the
  static configured URL list, with an optional `<page>` numeric substitution for simple pagination.
- The `fetcher_option` default is `"HTML"` (uppercase) but `writeFile()`'s `switch` matches only
  lowercase `"json"`/`"html"`; select the type in the fetcher form so a matching value is saved.
- See [fetcher/crawler-fetcher.md](fetcher/crawler-fetcher.md) for the full mechanism and config keys.
