<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feeds Instagram (feeds_instagram) — agent index

Feeds fetcher plugin that imports an Instagram Business Account's media through the Facebook (Meta) Graph API. Version dir `8.x` (dev checkout; `info.yml` has no `version:`). Core `^9.3 || ^10 || ^11`, package `Feeds`.

## What it provides
- **Fetcher plugin** `feeds_instagram_fetcher` (title "Instagram"): `src/Feeds/Fetcher/FeedsInstagramFetcher.php` — implements `FetcherInterface`, `ClearableInterface`; uses `Facebook\Facebook` (`facebook/graph-sdk`).
- **Plugin config form** `FeedsInstagramFetcherForm` (App ID, App Secret, import limit) — configured on the feed type.
- **Per-feed form** `FeedsInstagramFetcherFeedForm` (Facebook OAuth login, Page select → Instagram Business Account) — configured on each feed.
- **Cache bin service** `cache.feeds_instagram_tokens` (`feeds_instagram.services.yml`, permanent DB backend) — stores the Facebook access token per feed.
- `hook_help` (`feeds_instagram.module`), `hook_uninstall` clears the token bin (`feeds_instagram.install`).

## No routes, permissions, config schema, Drush, or entities of its own
Configuration lives in the Feeds feed-type / feed entities. Admin access is governed by Feeds' own permissions.

## Dependencies
- Modules: `feeds`, `pcb` (Permanent Cache Bust).
- Library: `facebook/graph-sdk` `^5.0`.
- Recommended parser: JsonPath parser from Feeds extensible parsers, context `$.*`.

## Solution docs
- [fetcher/instagram-fetcher.md](fetcher/instagram-fetcher.md) — fetcher lifecycle, Graph SDK client, OAuth token flow, token cache, config forms, and the parsed media fields.
