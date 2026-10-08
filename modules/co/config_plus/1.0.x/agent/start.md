<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Plus — agent start

Developer/build-time helpers around Drupal's **config entity** system. info.yml name
**"Config Plus"** (`config_plus`), version **1.0.0-alpha3**, package `Config`, core
`^9 || ^10 || ^11`. No admin UI, no routes, no permissions, no Drush commands, no config
schema — it is a code-only building block plus one install-time fixer. Three distinct pieces:

1. **Config installer service** — `config_plus.config_installer`
   (`Drupal\config_plus\ConfigInstaller`). Method
   `installConfig($type, $extension_name, $prefix = '')` reads config YAML from the named
   extension's `config/install/` and `config/optional/` directories, dependency-sorts it, and
   creates any config **entities** that do not already exist — as if Drupal's own installer had
   run at module install (adds `_core.default_config_hash`, uses
   `createFromStorageRecord()->trustData()->save()`). Intended to be called from a
   `hook_update_N()` to ship new config to existing sites. Optionally applies `config_rewrite`
   rewrites afterwards **iff** the `config_rewrite` module is installed (services wired with
   `@?`, so absent = no-op).

2. **Save-time validation subscriber** —
   `EventSubscriber\ConfigEntityInstallValidationSubscriber` on `ConfigEvents::SAVE`. When a
   *config entity* is saved whose UUID key is empty (the signature of saving through the config
   factory instead of the config entity API), it throws `ConfigException`. It fires **after**
   the save — it flags/alerts, it does not prevent the write. See
   [reference/behaviour.md](reference/behaviour.md).

3. **Missing-UUID fixer** — `config_plus_fix_missing_uuids()` in `.module`, run once from
   `hook_install()`. Iterates every config-entity type, and for each stored entity with an empty
   UUID: deletes any stale `uuid:`-prefixed key-value lookup entry pointing at it, then writes a
   freshly generated UUID via the editable config factory, and logs the fix.

Key facts: service id `config_plus.config_installer`; the installer only handles config
**entities** in the default collection, and only creates config that does **not** already exist
(never overwrites existing active config, except via the optional config_rewrite pass). Author
Hristo Chonov (1xINTERNET). Not covered by Drupal's security advisory policy (alpha).

- Mechanism details, edge cases, the config_rewrite integration, the validation exception
  → [reference/behaviour.md](reference/behaviour.md)
