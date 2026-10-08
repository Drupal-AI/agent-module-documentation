<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Feeds HTTP Authorization Fetcher adds a Feeds fetcher plugin that behaves like the standard "Download from URL" HTTP fetcher but also sends a configurable `Authorization` (and optional `Accept-Encoding`) header, so Feeds can import from APIs and feeds that require a bearer token or other credential.

---

The module requires the [Feeds](https://www.drupal.org/project/feeds) module and provides one extra
fetcher plugin, `httpauth` ("Download from URL with Authorization"), subclassing Feeds' core
`HttpFetcher`. On a feed type's *Fetcher* settings you select this fetcher; then, per feed, the edit
form (`HttpAuthFetcherFeedForm`, extending Feeds' `HttpFetcherFeedForm`) adds three fields on top of the
usual Feed URL: an **Authorization Header Key** (defaults to `Authorization`), an **Authorization Header
Token** (the credential value sent for that header), and an **Accept encoding headers** value. At fetch
time `HttpAuthFetcher::get()` runs the same request as core (scheme translation, timeout, ETag /
Last-Modified conditional caching, sink-to-file download), but injects `$headers[$key] = $token` when a
token is set (falling back to a literal `Authorization` header if only a token is given) plus the
`Accept-Encoding` header when provided. Everything else — caching, error handling, file cleanup on
failure — is inherited unchanged from Feeds core. There is no global config page, no permissions, and no
config schema of its own; settings live in the feed's per-fetcher configuration.

---

- Import a JSON/XML feed from an endpoint that requires a bearer token.
- Send an `Authorization: Bearer <token>` header with each Feeds fetch.
- Use a non-standard auth header name (e.g. `X-Api-Key`) via the Header Key field.
- Pull content from a partner API protected by a static token.
- Add a custom `Accept-Encoding` header (e.g. `gzip`) to feed requests.
- Reuse Feeds' scheduling/import pipeline against an authenticated source.
- Keep conditional-request caching (ETag / Last-Modified) while adding auth.
- Migrate content from a private CMS/API into Drupal nodes via Feeds.
- Periodically sync data from a token-protected REST endpoint on cron.
- Swap an existing feed's fetcher to the authenticated one without rebuilding the feed type.
- Import from a staging site behind a shared-secret header.
- Fetch a feed that rejects unauthenticated requests with 401/403.
- Supply different tokens per feed while sharing one feed type.
- Download large protected files to disk (sink) as part of an import.
- Provide credentials at the feed level so multiple feeds use distinct tokens.
