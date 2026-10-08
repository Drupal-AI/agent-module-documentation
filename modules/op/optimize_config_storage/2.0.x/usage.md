<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Optimises configuration reads by loading the entire config table into a static array once per request instead of issuing a separate SQL query per config object.

---

A service provider (`OptimizeConfigStorageServiceProvider`) alters the `config.storage.active` service to use `OptimizeConfigMemoryStorage`, a subclass of core's `DatabaseStorage`. Its `autoloadConfig()` runs a single `SELECT data, name, collection FROM {config}` and caches the result via `drupal_static`; `read()`, `readMultiple()` and `listAll()` then serve from that in-memory map. Write paths (`doWrite`, `rename`, `delete`, `deleteAll`, `exists`) reset the static cache so subsequent reads stay consistent. The table name is escaped with `escapeTable()` and the query uses core's connection API.

This targets the query volume that occurs while building `cache_config`, so it is most useful on sites with a large number of small config objects being read cold. There is no configuration, route or permission — install it and the swap happens automatically. Because it holds the full config set in a per-request static, it trades a little memory for far fewer round-trips; validate it against your site before relying on it in production.

---
- Reduce the number of SQL queries used to read configuration
- Load the config table once per request instead of per object
- Speed up building the config cache on cold caches
- Serve config reads from an in-memory static map
- Keep reads consistent after writes via static-cache resets
- Install as a drop-in with no configuration required
- Help sites with many small config objects
- Lower database round-trips during bootstrap-adjacent config access
- Remove cleanly by uninstalling (restores core storage)
- Benchmark config-read performance before/after
- Reduce database load during config-heavy requests
- Serve listAll/readMultiple from the cached config map
- Help pages that read many config objects on a cold cache
- Trade a little request memory for fewer DB round-trips
- Keep behaviour transparent to modules reading config
