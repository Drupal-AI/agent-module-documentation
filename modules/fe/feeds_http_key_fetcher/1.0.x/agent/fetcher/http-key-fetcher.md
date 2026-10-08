<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `httpkey` fetcher plugin, key field, and header injection

## What it is

`src/Feeds/Fetcher/HttpKeyFetcher.php` defines a Feeds fetcher plugin via the `@FeedsFetcher`
annotation:

- `id = "httpkey"`
- `title = "Download from URL with X API Key"`
- `description = "Downloads data from a URL using Drupal's HTTP request handler with specified X API key header."`
- `form = { "configuration" = HttpFetcherForm, "feed" = HttpKeyFetcherFeedForm }`

`class HttpKeyFetcher extends HttpFetcher` — the core Feeds HTTP fetcher
(`Drupal\feeds\Feeds\Fetcher\HttpFetcher`). It reuses all of the parent's behaviour (temp file sink,
caching, HTTP client) and only overrides `defaultFeedConfiguration()`, `fetch()`, and a protected
`get()` to add the API-key header.

## Enable / select it

1. Install with Composer and enable it: `drush en feeds_http_key_fetcher -y` (Feeds must be enabled —
   the dependency is real but not declared in the `.info.yml`).
2. Structure > Feed types (`/admin/structure/feeds`): create or edit a Feed type and set the
   **Fetcher** to **Download from URL with X API Key**. Add a parser (JSON/XML) and a processor/mappings.
3. Content > Feeds: add or edit a Feed of that type. Enter the **Feed URL** and, in the
   **Authorization X API Key** field beneath it, the key value to send.
4. Import (manually or via cron). The GET carries `x-api-key: <key>`.

## The per-feed form and where the key is stored

`src/Feeds/Fetcher/Form/HttpKeyFetcherFeedForm.php` extends `HttpFetcherFeedForm`.
`buildConfigurationForm()` calls the parent, then defines two fields on the feed edit form:

- `$form['source']` — `#type => 'url'`, `#title` "Feed URL", `#maxlength => 2048`, `#required => TRUE`,
  `#default_value => $feed->getSource()`.
- `$form['key']` — `#title` "Authorization X API Key:", `#type => 'textfield'`, `#maxlength => 255`,
  `#description` noting it is the optional key for the `x-api-key` header,
  `#default_value => $feed->getConfigurationFor($this->plugin)['key']`.

`submitConfigurationForm()` reads `$form_state->getValue('key')` and writes it back with
`$feed->setConfigurationFor($this->plugin, $feed_config)`. So the key lives in the **per-feed Feeds
configuration** (the fetcher's config array on that Feed entity) — there is no Key entity, no
environment variable, and no site-wide settings form. `defaultFeedConfiguration()` in
`HttpKeyFetcher` seeds the config with `'key' => ''`.

## Header injection, caching, and ETag behaviour

`fetch(FeedInterface $feed, StateInterface $state)`:

- Creates a temp sink via `$this->fileSystem->tempnam('temporary://', 'feeds_http_fetcher')` then
  `realpath()`.
- Calls the overridden `get($feed->getSource(), $sink, $this->getCacheKey($feed), $feed->getConfigurationFor($this)['key'])`.
- If the response is `304 Not Modified` (`Response::HTTP_NOT_MODIFIED`), it sets a "feed has not been
  updated" message and throws `EmptyFeedException` (nothing to re-import).
- Otherwise returns `new HttpFetcherResult($sink, $response->getHeaders())`.
- A `// @todo Handle redirects.` comment marks the commented-out `$feed->setSource($response->getEffectiveUrl())`.

`get($url, $sink, $cache_key = FALSE, $key = null)` (protected override):

- `$url = Feed::translateSchemes($url);`
- Builds `$options = [RequestOptions::SINK => $sink]`.
- **Header injection:** if `$key !== null`, sets `$options[RequestOptions::HEADERS]['x-api-key'] = $key`.
- **Caching:** if a cache key is set and cached headers exist, adds `If-None-Match` (from `etag`) and
  `If-Modified-Since` (from `last-modified`) request headers, enabling 304 responses.
- Performs `$this->client->get($url, $options)` (the inherited core `http_client` Guzzle client).
  On `RequestException` it throws a `\RuntimeException` with a "feed from %site seems to be broken"
  message.
- On success, when caching is enabled it stores the response headers (`array_change_key_case(...)`)
  under the cache key, then returns the Guzzle response.

## Notes for agents

- There is no `.install`, no config/install, no config/schema, no routing/permissions/services in this
  module. All admin surface is the standard Feeds Feed-type and Feed edit forms.
- The key is per feed, so two Feeds of the same type can use different keys.
- The header is added whenever the passed key is `!== null`. The stored default from
  `defaultFeedConfiguration()` is an empty string `''`, which is not null — so a feed with a blank key
  still sends an (empty) `x-api-key:` header rather than omitting it entirely.
