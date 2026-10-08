<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feeds HTTP Authorization Fetcher — using the fetcher

No admin settings page — everything is configured on Feeds entities.

## 1. Select the fetcher on a feed type
On the feed type (`/admin/structure/feeds/manage/<type>`) → *Fetcher* → choose **Download from URL
with Authorization** (plugin id `httpauth`). Its config form is Feeds' standard
`HttpFetcherForm` (request timeout etc.).

## 2. Per-feed fields (`HttpAuthFetcherFeedForm`)
On each feed's add/edit form:
- **Feed URL** (`source`, `#type` url, required) — the URL to fetch.
- **Authorization Header Key** (`key`) — header name; default `Authorization`.
- **Authorization Header Token** (`token`) — the credential value sent for that header.
- **Accept encoding headers** (`accept_encoding_header`) — optional `Accept-Encoding` value
  (e.g. `deflate, gzip;q=1.0`).

Stored in the feed's per-fetcher configuration (`$feed->setConfigurationFor($plugin, …)`);
`defaultFeedConfiguration()` seeds `key = 'Authorization'`, `token = ''`,
`accept_encoding_header = ''`.

## 3. Header injection (`HttpAuthFetcher::get()`)
```
$key   = $feed_configuration['key']   ?? '';
$token = $feed_configuration['token'] ?? '';
if ($key && $token)      $headers[$key] = $token;      // custom header name
elseif ($token)          $headers['Authorization'] = $token;  // fallback
if ($accept_encoding)    $headers['Accept-Encoding'] = $accept_encoding;
```
Note the token is sent **verbatim** — include any scheme yourself (e.g. put `Bearer xyz`, not just
`xyz`, in the token field if the endpoint expects `Bearer`).

Otherwise the request is core Feeds behavior: `Feed::translateSchemes($url)`, `request_timeout`,
conditional `If-None-Match`/`If-Modified-Since` from the fetch cache, response streamed to the sink
file, `FetchException` + `unlink($sink)` on a Guzzle `RequestException`, and response headers cached
under the cache key.

## Notes
- The fetch URL and credentials are set by whoever can create/edit the feed (a Feeds
  content-management privilege) — the same trust level and outbound-request behavior as core Feeds'
  own HTTP fetcher; this module only adds the header, it does not widen who can trigger a fetch.
- No config schema ships, so these fetcher settings are not separately schema-validated.
