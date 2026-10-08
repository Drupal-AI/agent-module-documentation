<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration Share — agent start

info.yml name **Configuration Share** (`config_share`), version **8.x-1.0-rc5**, core `^10.1 || ^11`.
Dependencies: core `config` + contrib `config_provider` (the Configuration Provider module).

Lets extensions/distributions **share** commonly-needed config items (user roles, field storages, etc.)
by placing them in a module's `config/shared/` directory instead of `config/install/`. Shared config is
**not** installed when its providing module is installed — it is created **on demand**, only when some
other config being installed declares it as a `dependencies.config` entry. This lets features from
different distributions depend on the same shared repository without conflicting base-feature dependencies.
No routes, no forms, no admin UI, no permissions, no services file, no hooks, no config schema — it is
purely two plugins.

## Mechanism (source)

Both classes live under `src/Plugin/`.

- **`ConfigProvider/ConfigProviderShare`** (id `config/shared`, extends `config_provider`'s
  `ConfigProviderBase`) — the core of the module.
  - `addConfigToCreate()` runs during extension install: for the config already queued to create, it
    resolves each item's `dependencies.config` against config found in enabled extensions' `config/shared/`
    directories (via `getExtensionInstallStorage('config/shared', $collection)`), and merges those shared
    items into the create list. `mergeSharedDependencies()` recurses so shared config that itself depends
    on other shared config is pulled in too. Runs across the default collection and every registered
    config collection.
  - `addInstallableConfig()` writes the resolved shared config into the provider storage.
  - Items already present in active storage are skipped (`array_diff` against `getActiveStorages()->listAll()`).
- **`FeaturesAssignment/ConfigSharedType`** (id `shared`, extends the **Features** module's
  `FeaturesAssignmentMethodBase`) — optional; only loads when the contrib `features` module is present.
  During a Features export it reassigns any config whose package short name is `core` into the
  `config/shared` subdirectory, so Features writes shared items to the right place.

## Provide shared config (developer usage)

1. Add `config_share` to your module's `dependencies` in `*.info.yml`.
2. Put the shareable config YAML in the module's `config/shared/` directory (not `config/install/`).
3. Do **not** add the shared item's own module dependencies to the providing module — they matter only
   when the shared item is actually installed on demand.

The **Compatible** module is the intended standard shared-config repository; a custom `config/shared`
module is an interim alternative. See [../usage.md](../usage.md) and
[../human-docs/index.md](../human-docs/index.md).
