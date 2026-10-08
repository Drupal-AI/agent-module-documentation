Feeds Enhanced adds SFTP/unconditional-HTTP/null fetchers, INI and entity-data parsers, an enhanced content-entity processor with multi-value field collection, replacement field targets, and a programmatic Feed-pool API to Drupal's Feeds module.

---

Feeds Enhanced is a plugin pack for the contrib **Feeds** module (`drupal/feeds` ^3.0@beta). It ships new fetchers, parsers, a processor and a set of replacement target plugins, and it globally rewires Feeds' processors and stock targets via `hook_feeds_processor_plugins_alter()` / `hook_feeds_target_plugins_alter()` so every Feed Type transparently gets the enhanced behavior. The headline additions are an **SFTP fetcher** (phpseclib3 + Key module for credential storage), an **unconditional HTTP fetcher** that ignores conditional-GET caching, a **Null data source** fetcher paired with an **Entity data** parser to run Feeds over already-stored entity data (bulk transformation / companion-entity generation), an **INI parser**, and an **Enhanced content entity processor** that can accumulate values in multi-value fields across imports instead of replacing them. It also defines a new **`feed_pool_requestor`** plugin type (manager service `plugin.manager.feed_pool_requestor`) for pooling reusable Feed entities for concurrent programmatic imports, pruned by `hook_cron()`. An optional `feeds_enhanced_tokens` submodule adds universal token expansion. Requires the `dx_toolkit`, `feeds` and `key` modules; provides no routes, permissions, forms outside the Feeds plugin UI, or Drush commands.

---

- Download feed files from an SFTP server using credentials held in a Key entity ("Download via SFTP" fetcher).
- Store an SFTP password/private-key in the Key module instead of plaintext feed configuration.
- Configure the SFTP host as `hostname:port`; port is parsed at runtime and defaults to 22.
- Always re-download a remote feed even when unchanged, bypassing `If-Modified-Since` / `If-None-Match` ("Download unconditionally from url" fetcher).
- Keep historical snapshots of a feed whose source updates in place without changing modification dates.
- Run an update-only Feed Type that fetches nothing ("Null data source" fetcher).
- Use existing entity field data as the import source ("Entity data" parser) — no external file needed.
- Bulk-transform content: read one bundle's entities and map fields onto a target bundle/type.
- Generate companion or derivative entities from existing content on a schedule.
- Parse INI-formatted files (with optional section/multi-mode) and map keys to entity fields ("INI" parser).
- Import legacy `.ini` configuration exports into structured Drupal content.
- Accumulate values in multi-value fields across repeated imports (e.g. append `[tag3]` to existing `[tag1, tag2]`) with the Enhanced content entity processor.
- Preserve existing multi-value field data on update instead of overwriting it, respecting field cardinality limits.
- Enable per-field "Collect multiple values" on multi-value field mappings (taxonomy, entity reference, multi-text).
- Use enhanced replacements for stock Feeds targets (string, text, entity_reference, image, file, link, email, datetime, daterange, boolean, integer, number, telephone, timestamp, uri, path, password, user_role, book, config_entity_reference).
- Drive imports programmatically with a pooled Feed via `plugin.manager.feed_pool_requestor` and `execute(['source' => '…'])`.
- Run many concurrent programmatic imports of the same Feed Type without clobbering each other, using per-Feed locks.
- Reuse idle Feed entities from a pool (`maxIdle`) instead of creating a new Feed per import.
- Choose synchronous (`import()`) or asynchronous batch (`startBatchImport()`) execution per requestor (`async`).
- Inspect pool health with `getPoolStats()` (`total` / `locked` / `idle`) and reclaim excess idle Feeds with `prunePool()`.
- Automatically prune idle pooled Feeds on cron.
- Clear a pooled Feed's previously imported items before a fresh run with `clear()`.
- Repair processor configuration corrupted by earlier bad schema types via `update hook 9001` (`Updater::fixProcessorConfigurationTypes()`).
- Combine with the `feeds_enhanced_tokens` submodule for dynamic, environment-aware feed sources and paths.
