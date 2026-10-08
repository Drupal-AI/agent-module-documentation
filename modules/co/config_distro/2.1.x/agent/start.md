<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config Distro — agent index

Event-driven **framework** for applying a distribution's configuration updates. It exposes a
distro config storage, fires transform/import events, and ships a UI + Drush command to preview
and import the diff against active config. It needs a companion (e.g. `config_sync`) to actually
populate the distro storage. Requires `config_filter`.

- **The distro storage service + the transform/import events (how the pipeline works, how to
  subscribe)** → [api/storage-events.md](api/storage-events.md)
- **The Drush command `config-distro-update` / `cd-update`** → [drush/commands.md](drush/commands.md)
- **The import UI: route, path, permission, form** → [configure/import.md](configure/import.md)

Submodules (nested docs):
- **config_distro_filter** (deprecated bridge) →
  [modules/config_distro_filter/2.1.x/agent/start.md](../../modules/config_distro_filter/2.1.x/agent/start.md)
- **config_distro_ignore** (retain config on import) →
  [modules/config_distro_ignore/2.1.x/agent/start.md](../../modules/config_distro_ignore/2.1.x/agent/start.md)

Key facts:
- Storage service: `config_distro.storage.distro` (a `ManagedStorage` → `DistroStorageManager`);
  reading it copies active config to memory and dispatches `config_distro.transform`.
- Events: `ConfigDistroEvents::TRANSFORM` (`config_distro.transform`) and
  `ConfigDistroEvents::IMPORT` (`config_distro.import`).
- UI: `config_distro.import` at `/admin/config/development/distro`, permission
  `synchronize distro configuration`. Drush: `config-distro-update` (`cd-update`).
