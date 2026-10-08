<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feeds HTTP API key Fetcher (feeds_http_key_fetcher) — agent index

Adds one Feeds **fetcher plugin**, `httpkey` ("Download from URL with X API Key"), that extends
core Feeds' `HttpFetcher` and sends an `x-api-key` HTTP header (value = a per-feed configured key)
when downloading the feed URL. Use it to import from JSON/XML endpoints that require an API-key header.

- **Version:** 1.0.2 (version dir `1.0.x`). Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Package "Feeds".
- **Dependency:** hard runtime dependency on the `feeds` module (extends its `HttpFetcher`); note it is
  **not declared** in `feeds_http_key_fetcher.info.yml` — Feeds must be enabled or the plugin cannot load.
- **Provides:** a `@FeedsFetcher` plugin (`src/Feeds/Fetcher/HttpKeyFetcher.php`) and its per-feed form
  (`src/Feeds/Fetcher/Form/HttpKeyFetcherFeedForm.php`). No routes, permissions, services, config schema,
  Drush commands, settings page, or install/update hooks.
- **Config location:** the key is stored in **per-feed Feeds configuration** (`$feed->getConfigurationFor($this)['key']`),
  not the Key module and not an environment variable.

Solution docs:

- [Fetcher plugin, key field, and header injection](fetcher/http-key-fetcher.md)
