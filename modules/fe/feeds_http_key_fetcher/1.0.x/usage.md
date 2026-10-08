<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Feeds HTTP API key Fetcher provides a Feeds fetcher plugin that adds an `x-api-key` header, taken from a per-feed key, when downloading a remote feed over HTTP.

---

Feeds HTTP API key Fetcher is an add-on for the Feeds module that registers one new fetcher plugin, "Download from URL with X API Key" (id `httpkey`). It extends the core Feeds `HttpFetcher`, so it downloads the feed URL exactly like the standard HTTP fetcher — including 304/ETag caching — but additionally sets an `x-api-key` request header whose value is the API key entered on the individual feed. You pick this fetcher on a Feed type at Structure > Feed types, then on each Feed you enter the endpoint URL and, in the "Authorization X API Key" field beneath it, the key to send. Use it when the JSON or XML endpoint you import from requires an API-key header to return a successful response, which the plain HTTP fetcher cannot supply. The module has a hard runtime dependency on Feeds and adds no settings page, route, permission, service, or Drush command of its own.

---

- Import a JSON feed from an endpoint that requires an `x-api-key` header.
- Import an XML feed from an API-key-protected endpoint.
- Add API-key authentication to an existing Feeds import without custom code.
- Pull content from a third-party SaaS API that gates GET requests behind an API key.
- Give different Feeds a different API key each, since the key is stored per feed.
- Reuse the standard Feeds HTTP fetcher behaviour (caching, 304 handling) but with a key header.
- Select "Download from URL with X API Key" as the fetcher on a new Feed type.
- Switch an existing Feed type from the plain HTTP fetcher to the key-header fetcher.
- Feed a mapped importer (parser + processor) from a key-protected source.
- Schedule recurring imports (via cron) from an API-key-protected endpoint.
- Import product, event, or listing data from a partner API that needs a key.
- Leave the key blank to fall back to a plain request when the endpoint does not require one.
- Take advantage of ETag / If-None-Match caching to skip re-import when the source is unchanged.
- Keep using Feeds' existing parsers and processors while only changing how the file is fetched.
- Consolidate authenticated and unauthenticated feed imports under one Feeds workflow.
- Migrate content from an external system whose export endpoint requires an API key.
- Point the fetcher at any HTTP(S) URL that accepts an `x-api-key` header.
- Run one-off manual imports of key-protected feeds from the Feeds admin UI.
- Provide editors a simple URL + key form on the feed instead of hand-built HTTP requests.
