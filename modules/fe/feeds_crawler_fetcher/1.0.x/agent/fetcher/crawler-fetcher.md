<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `crawler` fetcher — mechanism, config, result

Source: `src/Feeds/Fetcher/CrawlerFetcher.php`, `src/Feeds/Fetcher/Form/CrawlerFetcherForm.php`,
`src/Feeds/Fetcher/Form/CrawlerFetcherFeedForm.php`, `src/Feeds/Result/CrawlerFetcherResult.php`.

## Install / enable

1. `composer require drupal/feeds_crawler_fetcher` (no `composer.json` ships, so nothing is pulled in
   transitively — install/enable **Feeds** yourself: `drush en feeds feeds_crawler_fetcher -y`).
2. Create/edit a feed type at **Structure → Feed types**, set **Fetcher = "Crawl a set of url"**,
   choose a parser (HTML/XML or JSON — e.g. Feeds Extensible Parsers) and map fields as usual.
3. On a feed of that type, paste **one URL per line** into the **Feed URL** textarea and import.

`feeds` is a hard runtime dependency but is **not** listed in `feeds_crawler_fetcher.info.yml`.

## Plugin definition

`CrawlerFetcher` is annotated `@FeedsFetcher(id = "crawler", title = "Crawl a set of url", …)` with two
external plugin forms: `configuration` → `CrawlerFetcherForm`, `feed` → `CrawlerFetcherFeedForm`. It
extends `Drupal\feeds\Plugin\Type\PluginBase` and implements `FetcherInterface`, `ClearableInterface`,
`ContainerFactoryPluginInterface`. `create()` injects `http_client` (Guzzle), `cache.feeds_download`,
`file_system`, and `feeds.file_system.in_progress` (`FeedsFileSystemInterface`).

## The feed source (per-feed form)

`CrawlerFetcherFeedForm::buildConfigurationForm()` renders a single required `#type => 'textarea'`
field **Feed URL** (`source`), defaulting to `$feed->getSource()`. `submitConfigurationForm()` stores
it via `$feed->setSource(...)`. `validateConfigurationForm()` is present but its body is **entirely
commented out** — there is no scheme validation or reachability check on the entered URLs.

## Fetch loop (`fetch()`)

1. Creates a result `$sink` temp file: `feedsFileSystem->tempnam($feed, 'multiple_fetcher_')`.
2. Computes a `$cache_key` only if caching is on (`useCache()` = `!always_download`).
3. Splits the feed source into `$urls = preg_split('/\r\n|[\r\n]/', $feed->getSource())` — one URL
   per line.
4. For each URL: makes a per-URL temp file `temp_multipe_fetcher_` (sic), then:
   - **Paged mode** — if `configuration['paged_fetcher']` is truthy **and** the URL contains the
     literal token `<page>`: loops `for ($i = 0; $i < configuration['pages']; $i++)`, replaces
     `<page>` with `$i`, and calls `writeFile()` for each page (pages `0 … pages-1`).
   - **Otherwise** — calls `writeFile()` once for the URL as-is.
5. Returns `new CrawlerFetcherResult($sink, $this->fileSystem)`.

**Not a real crawler:** it never parses fetched content for links to follow. "Crawling" here means
iterating the static configured URL list plus the numeric `<page>` substitution.

## HTTP GET (`get()`)

`get($url, $sink, $cache_key, $options)` translates the scheme with `Feed::translateSchemes($url)`,
sets Guzzle options `SINK => $sink`, `TIMEOUT => configuration['request_timeout']`, `HEADERS => []`,
then `$this->client->getAsync($url, $options)->wait()`. On `RequestException` it unlinks the sink and
throws Feeds' `FetchException` with the URL and error message.

- **Caching is effectively metadata-only.** When `$cache_key` is set, the response headers are stored
  (`cache->set($cache_key, array_change_key_case($response->getHeaders()))`), but the code that would
  add `If-None-Match`/`If-Modified-Since` conditional-request headers from the cache is **commented
  out**. So the cache never actually short-circuits a download; `always_download` currently only
  controls whether headers are cached, not whether content is re-fetched.

## Combining responses (`writeFile()`)

`writeFile($url, $temp_sink, $sink, $cache_key)` downloads into `$temp_sink`, then merges into the
result `$sink` based on `configuration['fetcher_option']`:

- **`"json"`** — `json_decode` the current `$sink` (empty → `[]`), `array_merge` it with the
  json-decoded `$temp_sink`, `json_encode` the result back, `$flags = 0` (overwrite). Note
  `array_merge` **concatenates** list-style JSON arrays but **overwrites by key** for
  object/associative JSON.
- **`"html"`** — `$flags = FILE_APPEND`, `$content = file_get_contents($temp_sink)` (append raw
  response). Use this for HTML/XML sources.
- Finally `file_put_contents($sink, $content, $flags)`.

### Behavior gotchas (functional, from source)

- **Default option doesn't match the switch.** `defaultConfiguration()` sets
  `fetcher_option => "HTML"` (uppercase), but the `switch` in `writeFile()` only has lowercase
  `case "json"` / `case "html"`. If a fetcher is never saved through the config form, the stored value
  is `"HTML"` → neither case matches → `$content` stays `''` and `$flags` is left **undefined** →
  `file_put_contents($sink, '', $flags)` emits an "undefined variable" warning and writes an empty
  result. Fix in practice: open the fetcher config form and pick **HTML** or **Json** (the form's
  select stores the lowercase keys `html`/`json`), which makes it work.
- **Missing `break` on `case "html"`.** It falls through into `default:` (which is empty, so no harm
  today), but it is a latent bug if `default` ever gains logic.

## Fetcher configuration form (`CrawlerFetcherForm`)

Exposes three fields: **Type of information** (`fetcher_option`, select `html => "HTML"`,
`json => "Json"`), **Paged Fetcher** (`paged_fetcher`, checkbox; description says add a `<page>`
parameter to the URL), and **Total Pages** (`pages`, number).

`defaultConfiguration()` also declares several keys that are **not** exposed by any form and are
carried over from Feeds' HTTP fetcher: `auto_detect_feeds` (FALSE), `use_pubsubhubbub` (FALSE),
`always_download` (FALSE), `fallback_hub` (''), `request_timeout` (30), plus `paged_fetcher` (0) and
`pages` (0). Since only three keys are editable, `request_timeout` stays **30s** and `always_download`
stays FALSE unless changed in code/config. No `config/schema/` ships for these keys.

## Result object (`CrawlerFetcherResult`)

Extends Feeds' `FetcherResult`; constructed with the sink path and `file_system`. `cleanUp()` unlinks
the result file. It uses `DependencySerializationTrait` with a `__wakeup()` that re-attaches
`file_system` for objects serialized before the property existed (Feeds 8.x-3.0-beta compatibility).

## Cleanup / clear

`clear()` calls `onFeedDeleteMultiple([$feed])`, which deletes the per-feed download cache entry
(`getCacheKey()` = `feed->id() . ':' . hash('sha256', feed->getSource())`). `onFeedDeleteMultiple()`
runs the same delete for each feed on bulk delete.
