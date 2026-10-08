<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Optimize config storage (optimize_config_storage) — agent index
**Replaces the active config storage with a variant that reads the whole config table once per request.**

- **Version:** 2.0.x
- **Core:** ^8 || ^9 || ^10
- **Mechanism:** `OptimizeConfigStorageServiceProvider::alter()` sets `config.storage.active` class to `OptimizeConfigMemoryStorage` (extends core `DatabaseStorage`)
- **Behaviour:** single `SELECT data, name, collection FROM {config}` cached in `drupal_static`; write ops reset the static
- **Provides:** no routes, permissions or config

**Security:** no endpoints; table name escaped via `escapeTable()` and reads use the core DB API (no raw user input in SQL). Infrastructure-level change — validate on your site before production use.
