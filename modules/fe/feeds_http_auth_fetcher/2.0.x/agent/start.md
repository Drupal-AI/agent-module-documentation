<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feeds HTTP Authorization Fetcher — agent index

One Feeds fetcher plugin (`httpauth`) = core `HttpFetcher` + a configurable `Authorization` /
`Accept-Encoding` header. Requires the Feeds module (info.yml omits the dependency, but the plugin
subclasses `\Drupal\feeds\Feeds\Fetcher\HttpFetcher`). No config page, no permissions, no schema.

- **Selecting the fetcher, the per-feed fields, and the header-injection logic** →
  [configure/fetcher.md](configure/fetcher.md)

Key facts:
- Plugin `@FeedsFetcher(id = "httpauth")` in `src/Feeds/Fetcher/HttpAuthFetcher.php`; feed form
  `HttpAuthFetcherFeedForm` (extends `HttpFetcherFeedForm`).
- Per-feed config keys: `key` (header name, default `Authorization`), `token` (header value),
  `accept_encoding_header`. Set on the feed edit form.
- `get()` injects `$headers[$key] = $token` (or literal `Authorization` if only a token), plus
  `Accept-Encoding`; otherwise identical to core (scheme translate, timeout, ETag/Last-Modified cache,
  file sink, error cleanup).
