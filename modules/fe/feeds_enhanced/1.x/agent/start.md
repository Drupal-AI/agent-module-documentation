<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Feeds Enhanced (feeds_enhanced) — agent index

Plugin pack for the contrib **Feeds** module (`drupal/feeds` ^3.0@beta). Adds fetchers, parsers, a
processor, replacement targets, and a `feed_pool_requestor` plugin type. Core `^10.1 || ^11`.
License GPL-2.0-or-later. Installed version 1.0.0-beta14 (version-dir `1.x`).

- **Module deps** (info.yml): `dx_toolkit`, `feeds`, `key`. Composer also pulls
  `phpseclib/phpseclib ^3.0` (SFTP transport) and `drupal/token ^1.0`.
- **No** routes, no `*.permissions.yml`, no controllers, no Drush, no settings form. All
  configuration is per-Feed-Type in the Feeds plugin UI. Config schema only (`config/schema/feeds_enhanced.schema.yml`).
- Optional submodule **`feeds_enhanced_tokens`** — universal token expansion (own doc tree under
  `modules/feeds_enhanced_tokens/1.x/`).

## What it provides (from source)

Fetchers (`src/Feeds/Fetcher/`):
- `sftp` — `SftpFetcher`, "Download via SFTP". phpseclib3 client (`src/SftpClient.php`), password
  resolved from a **Key** entity. Host stored as `host:port`, parsed at fetch time.
- `unconditional_http` — `HttpUnconditionalFetcher` extends core `HttpFetcher`, overrides
  `getCacheKey()` → `FALSE` so no conditional-GET headers are sent (always re-downloads).
- `null_data_source` — `NullDataSource`, returns an empty `FetcherResult('')`; for update-only /
  programmatic feeds.

Parsers (`src/Feeds/Parser/`):
- `ini` — `IniParser`, `parse_ini_file(..., INI_SCANNER_TYPED)`; keys mapped via feed-type sources.
- `entity_data` — `EntityDataParser`, ignores the fetcher result and reads existing entities of the
  processor's target type/bundle as source rows. Pair with `null_data_source`.

Processor + targets:
- `EnhancedContentEntityProcessor` (extends Feeds' `GenericContentEntityProcessor`).
  `hook_feeds_processor_plugins_alter()` swaps it in for **all** processors. Adds per-field
  multi-value collection (`collect_multi_values`).
- `AlternateTargetPlugin` enum + `hook_feeds_target_plugins_alter()` replace all 20 stock Feeds
  targets with subclasses in `src/Feeds/Target/` that add `FeedTargetSupportsMultiValueTrait`.

Plugin type + services (`feeds_enhanced.services.yml`):
- `feed_pool_requestor` plugin type: manager `plugin.manager.feed_pool_requestor`
  (`FeedPoolRequestorManager`), base `FeedPoolRequestorBase`, annotation `@FeedPoolRequestor`.
  Programmatic pooled Feed execution; ships no default deriver. `hook_cron()` prunes pools.
- `feeds_enhanced.updater` (`Updater`) — `update_9001` config-repair routine.
- `feeds_enhanced.logger` — logger channel.

## Solution docs

- Fetchers (SFTP / unconditional HTTP / null) → [plugins/fetchers.md](plugins/fetchers.md)
- INI + Entity-data parsers → [plugins/parsers.md](plugins/parsers.md)
- Enhanced processor + multi-value targets → [plugins/processor-targets.md](plugins/processor-targets.md)
- `feed_pool_requestor` programmatic API + cron → [api/feed-pool-requestor.md](api/feed-pool-requestor.md)
