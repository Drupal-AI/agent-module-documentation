<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Distro is a developer framework that provides an event-driven architecture for applying configuration updates shipped by distributions (or modules/themes) to a site, letting companion modules discover extension config changes and import them without overwriting local work.

---

Built on the same pattern as Configuration Split, the module exposes a distribution config storage service, `config_distro.storage.distro` — a core `ManagedStorage` backed by `DistroStorageManager`. Each time the storage is requested, the manager copies the active configuration into a memory storage, acquires a lock, and dispatches a `ConfigDistroEvents::TRANSFORM` (`config_distro.transform`) event carrying a mutable `DistroStorageTransformEvent`; subscribers rewrite that storage to represent the desired distribution state, and a read-only view is returned. Consumers then compare this distro storage against active configuration with a core `StorageComparer` and import the differences. The module ships the UI for this at `/admin/config/development/distro` (route `config_distro.import`, the module's `configure` route) via `ConfigDistroImportForm` (a subclass of core's `ConfigSync`) plus a diff controller, all gated by the `synchronize distro configuration` permission; and a Drush command `config-distro-update` (alias `cd-update`, option `--preview=list|diff`) that previews and applies the changes, firing a `ConfigDistroEvents::IMPORT` (`config_distro.import`) event on success. It requires `config_filter` and provides two submodules: **config_distro_filter** (a deprecated bridge that runs Config Filter plugins during the transform) and **config_distro_ignore** (retain specific config during distribution imports). On its own Config Distro is infrastructure — it needs a companion like Configuration Synchronizer (`config_sync`) to actually populate the distro storage with extension updates; it has no config entity or schema of its own.

---

- Provide the infrastructure for applying a distribution's configuration updates to a live site.
- Subscribe to `config_distro.transform` to rewrite the distro storage to a desired configuration state.
- React to a completed distribution import via the `config_distro.import` event.
- Preview pending distribution config changes as a list or unified diff before applying.
- Apply distribution configuration updates from the CLI with `drush config-distro-update` (`cd-update`).
- Review and import distribution updates through the UI at `/admin/config/development/distro`.
- Gate distribution-config synchronization behind the `synchronize distro configuration` permission.
- Compare the distribution storage against active config with a `StorageComparer` to find updates.
- Build a config packaging/distribution workflow on top of the transform event architecture.
- Integrate Configuration Synchronizer (`config_sync`) to discover and stage extension config updates.
- Retain site-specific customizations during distribution imports using the config_distro_ignore submodule.
- Run Config Filter plugins against the distro storage via the config_distro_filter bridge.
- Lock the transform so concurrent requests don't race while the distro storage is being built.
- Access the distribution storage programmatically via the `config_distro.storage.distro` service.
- Import only the configuration that differs between the distribution and the active site.
- Provide a Configuration Split-style storage manager for distribution updates.
- Notify other modules when distribution configuration has been imported.
- Offer both a UI and a Drush path so site builders and automation can apply updates.
- Underpin a distribution's "update site config to the new release" step during deployments.
- Extend the import behavior by swapping in a custom transform subscriber.
