<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using the POST fetcher

Plugin id **`httpfetcherpost`** — *"Download from URL additional POST parameters"*.
Class `Drupal\feeds_fetcher_post\Feeds\Fetcher\HttpFetcherPost extends
Drupal\feeds\Feeds\Fetcher\HttpFetcher`.

## Select it on a feed type

Structure > Feed types > *(type)* > **Fetcher**. Pick *"Download from URL additional POST
parameters"*. The fetcher-level settings shown are core's HTTP fetcher settings
(`request_timeout`, `auto_detect_feeds`, `always_download`, PubSubHubbub) — this module adds no
fetcher-level options.

## Configure a feed

Content > Feeds > *(feed)*. Fields:

- **URL** — the endpoint to POST to (core's Feed-URL field; supports the Feeds scheme
  translation via `Feed::translateSchemes()`).
- **Headers** — textarea, **one `KEY: VALUE` pair per line**. Parsed by `preg_match('/(.*?):
  (.*)/', ...)` — a literal `": "` (colon + space) separates key from value; a line without it is
  silently ignored. Example:
  ```
  Authorization: Bearer XXXXXXXX
  Content-Type: application/json
  Accept-Language: en
  ```
- **POST parameters** — textarea holding the request body.
- **POST variant** — required radios:
  - **`FORM_PARAMS`** (default) — each `KEY: VALUE` line becomes a form field; Guzzle sends
    `application/x-www-form-urlencoded`. Example body:
    ```
    query: widgets
    page: 1
    limit: 50
    ```
  - **`BODY`** — the **entire textarea is sent verbatim** as the raw request body. Use for JSON,
    XML/SOAP or any custom payload; set the matching `Content-Type` header yourself. Example:
    ```
    {"query":"widgets","page":1,"limit":50}
    ```

## What happens at fetch time

`get($url, $sink, $cache_key, $options, $feed_configuration)`:

1. `$url = Feed::translateSchemes($url)`.
2. Base options: `SINK => $sink`, `TIMEOUT => request_timeout`, `HEADERS => []`.
3. If `headers` non-empty → parse lines into `RequestOptions::HEADERS`.
4. If `post_parameter` non-empty → `BODY` variant sets `RequestOptions::BODY = post_parameter`;
   otherwise parse lines into `RequestOptions::FORM_PARAMS`.
5. If a `cache_key` cache hit exists → add `If-None-Match` / `If-Modified-Since` conditional
   headers (inherited ETag/Last-Modified caching).
6. `$response = $this->client->requestAsync('POST', $url, $options)->wait();`
7. On `GuzzleHttp\Exception\RequestException`: delete the partial `$sink` file and throw
   `\Drupal\feeds\Exception\FetchException` — **its message embeds `%headers` and
   `%post_parameter`** along with the error and variant.
8. On success, cache the response headers under `cache_key` and return the Guzzle response.

The returned response feeds straight into the feed type's configured **parser** and
**processor** — this module changes only the retrieval, not the parsing/mapping. Any format
(RSS/Atom, CSV, JSON via an extra JSON parser, etc.) works as long as a matching parser is
selected.

## Notes / gotchas

- `defaultFeedConfiguration()` sets `headers => ''`, `post_parameter => ''`,
  `post_variant => 'FORM_PARAMS'`.
- Header parsing needs the exact `": "` delimiter; `Key:Value` (no space) will **not** match.
- With `BODY`, no `Content-Type` is set automatically — add it in **Headers**.
- POST is not idempotent — beware retries/cron overlap against endpoints that mutate state.
- Credentials placed in Headers/POST parameters are stored unencrypted on the feed entity and
  appear in the failure exception message/logs; keep them low-scope and rotate them.
