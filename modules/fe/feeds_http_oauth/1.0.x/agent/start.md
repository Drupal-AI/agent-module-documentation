<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feeds HTTP OAuth Fetcher (feeds_http_oauth) — agent index

An OAuth 2.0-enabled HTTP fetcher plugin for **Feeds 3.x**. Adds one Feeds fetcher,
**"Download from url (OAuth 2.0)"** (id `http_oauth`), that extends Feeds' core `HttpFetcher`:
it obtains an OAuth access token from a per-feed token URL and downloads the feed source with the
token in an `Authorization` header. Version **1.0.0-alpha1** (dir `1.0.x`). Core `^10 || ^11`.
Package `Feeds`.

- **Dependencies:** `feeds` (Feeds 3.x) and `key` (Key module).
- **Provides:** one `@FeedsFetcher` plugin (`http_oauth`) + its per-feed config form. No routes,
  no permissions, no services, no Drush, no `hook`s, no settings page.
- **Config schema:** `feeds.fetcher.http_oauth` (`config/schema/feeds_http_oauth.schema.yml`) — the
  per-feed OAuth mapping stored inside the feed's fetcher configuration.

## The fetcher, its OAuth feed form, grant types, Key resolution, token exchange and data fetch
→ [fetcher/oauth-fetcher.md](fetcher/oauth-fetcher.md)

## What it actually is (from source)

- `src/Feeds/Fetcher/HttpOAuthFetcher.php` — the plugin. Extends
  `Drupal\feeds\Feeds\Fetcher\HttpFetcher`, injects `key.repository` in addition to the parent's
  services. Overrides `get()` (adds the OAuth token to the download request) and adds
  `getAccessToken()` (the token exchange). `defaultFeedConfiguration()` seeds the per-feed OAuth keys.
- `src/Feeds/Fetcher/Form/HttpOAuthFetcherFeedForm.php` — extends core `HttpFetcherFeedForm`; adds
  the "OAuth 2.0 settings" `details` group to the feed edit form and merges/saves the OAuth config.
- The fetcher's `configuration` form is core's `HttpFetcherForm` (unchanged); only the per-feed
  `feed` form is overridden.
