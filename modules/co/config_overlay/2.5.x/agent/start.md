<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Overlay (config_overlay) — agent index

Turns the config **sync storage into an overlay of the shipped configuration** of all installed
extensions. On `config:export` it removes any object identical to an extension's/profile's
default config, so the sync directory keeps only what you added or changed (a Standard install
drops from ~200 exported files to ~10). On `config:import` it re-adds that shipped config so the
import still sees the full set. info.yml name **Config Overlay**, version **2.5.1**, package
`Config`, core `^9.5 || ^10 || ^11`. No hard module deps; optional tested integrations with
Config Ignore 3.x and Config Split 2.x.

## Mechanism (no UI, no routes, no permissions)
The module ships **no routing/permissions/menu/Drush** — installing + enabling it is the entire
setup. It works purely through core's config storage-transform events plus config CRUD events:

- `EventSubscriber/ConfigTransformSubscriber` — the core.
  - `removeShipped()` (export): deletes each to-be-exported object that is byte-identical to the
    extension's shipped config (ignoring `_core`/`uuid` keys).
  - `overlayShipped()` (import): re-adds non-deleted, non-overridden shipped config, amending the
    active `uuid`/`_core` so import detects no spurious diff. Handles language config collections.
  - `ensureCoreExtension()` / `ensureConfigOverlayDeleted()` (import, prio 100): when installing a
    site from a profile's shipped config, seed `core.extension` / `config_overlay.deleted` from
    the profile's `config/sync` (or `config/install`) so the overlay has the extension list.
- `EventSubscriber/ConfigDeleteSubscriber` — tracks deletions of *shipped* config in the
  `config_overlay.deleted` config object (`onDelete`), and un-tracks on re-`onSave`. Skips
  deletions that Config Ignore 3.x ignores on both import and export.
- `Config/ExtensionStorageFactory` → builds a read-only union storage (profile `config/sync` →
  `ExtensionInstallStorage` `config/install` → `ExtensionOptionalStorage` `config/optional`)
  representing all shipped config for the extension list in a given storage.
- `Config/ExtensionOptionalStorage` — lists optional extension config only when its dependencies
  are met. `Config/ReadOnlyUnionStorage` — first-match-wins, write/delete throw.
- `ConfigOverlayServiceProvider::alter()` — sets transform priorities; auto-adds a second
  early/late pass when Config Split is present; overridable via `$settings['config_overlay_priorities']`.
- `config_overlay.module` — `hook_module_preinstall`/`preinstall` keep the delete subscriber's
  extension storage in sync with the changing module list.
- `config_overlay.install` — records already-deleted shipped config at install; provides
  `config_overlay_install_tasks_alter()` for profiles installing from config.

## Provided config
- `config_overlay.deleted` — `{ names: [config names] }` list of deleted shipped config
  (schema `config/schema/config_overlay.schema.yml`); appears in the export once any shipped
  config is deleted.

## Docs
- How it works, priorities/settings, Config Ignore + Config Split integration, install-from-config,
  edge cases → [config/overlay.md](config/overlay.md)
