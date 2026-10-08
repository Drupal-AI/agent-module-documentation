<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: `deconfig-remove-hidden` (alias `drh`)

Cleans stray hidden configuration out of sync storage so `drush cim`/`cex` stop throwing `FoundHiddenConfigurationError`.

## Definitions (two, for Drush-version compatibility)
- Modern: `Drupal\deconfig\Commands\DeconfigCommands::deconfigRemoveHidden()` — registered in `drush.services.yml` as service `deconfig.commands` (arg `@config.storage.sync`, tag `drush.command`). Annotations: `@command deconfig-remove-hidden`, `@aliases drh`, `@bootstrap database`.
- Legacy: `deconfig.drush.inc` (`deconfig_drush_command()` / `drush_deconfig_remove_hidden()`) which calls the same `deconfig.commands` service.

## What it does (`DeconfigCommands::deconfigRemoveHidden`)
1. Guards that the injected `config.storage.sync` is actually a `DeconfigStorage`; if not, logs an error (`config.storage.sync is not Deconfig. Someone's messed with it?`) and returns.
2. Iterates all collections (`StorageInterface::DEFAULT_COLLECTION` + `getAllCollectionNames()`), recreating the storage per collection via `createCollection()`.
3. For each config name from `listAll()`, calls `read($name)`. If that throws `FoundHiddenConfigurationError`, it rewrites the item with `write($name, $storage->readRaw($name))` — `readRaw()` reads without throwing, `write()` re-strips the hidden values — and logs `Removed hidden configuration from "<name>"`.

## Usage
```
drush deconfig-remove-hidden
drush drh
```
Run it when import/export errors out reporting hidden config in sync. It requires Drush + a database bootstrap (i.e. CLI/shell access to the site); there is no HTTP route or permission surface.
