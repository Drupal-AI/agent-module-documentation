<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Deconfig (deconfig) — agent index

Developer module that exempts selected configuration keys/objects from Drupal's config import/export, so an administrator can change them without config sync overwriting them. Version **1.0.x**. Core `^8.8 || ^9 || ^10 || ^11`. Package: Configuration.

## What it provides
- **Service decorator** `deconfig.storage.sync` → `Drupal\deconfig\DeconfigStorage`, decorating core `config.storage.sync` (see `deconfig.services.yml`). Constructor args: the wrapped inner sync storage + `@config.storage.active`.
- **Mechanism**: exemptions are declared inline in the sync YAML via a `_deconfig` entry mirroring the config hierarchy. The wrapper reads exempted items from active storage instead of sync so they never diff on export; `@`-prefixed keys enable "soft" mode (keep a default, use it only when active has no value).
- **Exception** `Drupal\deconfig\Exception\FoundHiddenConfigurationError` — thrown on `read()` when a hidden item is present in sync (makes `drush cim`/`cex` fail loudly).
- **Drush command** `deconfig-remove-hidden` (alias `drh`), defined twice for Drush-version compatibility: `Drupal\deconfig\Commands\DeconfigCommands` (`drush.services.yml`) and the legacy `deconfig.drush.inc`. Strips stray hidden config out of sync storage.

## No UI surface
No routes, no `*.permissions.yml`, no config/install or config/schema, no plugins, no libraries, no module dependencies, no composer requirements. `provides_drush_commands: true`.

## Solution docs
- [How the storage decorator works & YAML syntax](config/deconfig-storage.md)
- [Drush: deconfig-remove-hidden](drush/remove-hidden.md)
