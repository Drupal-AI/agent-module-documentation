<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Configuration Snapshot is a developer API module that stores per-extension snapshots of configuration (as originally provided by a module or theme) inside Drupal's config system, exposing each snapshot as a standard `StorageInterface`. It has no UI of its own — other modules (such as Features) use it to detect drift between shipped config and the active site config.

---

Configuration Snapshot provides a way to keep a "snapshot" of the configuration a module or theme ships, so a consumer can later compare it against the live active configuration and see what changed. Each snapshot is a `config_snapshot` config entity identified by three parts — a **snapshot set** (namespaced per consuming module), an **extension type** (`module`/`theme`), and an **extension name** — persisted as `config_snapshot.snapshot.<set>.<type>.<name>`. Its items store, per config collection, the config object name and its raw data. The module exposes each snapshot through `ConfigSnapshotStorage`, a full implementation of core's `StorageInterface`, so callers can `read()`/`write()`/`listAll()` snapshot config exactly like any other config storage. A `ConfigSnapshotServiceProvider` registers one container service (`config_snapshot.<set>.<type>.<name>`) per existing snapshot at container-build time, and the `ConfigSnapshotStorageTrait::getConfigSnapshotStorage()` helper returns that service when available or falls back to a fresh storage object (important right after a new extension is installed, before the container is rebuilt). There is no admin page, no route, no Drush command, and no permission — it is purely a building block for other modules. Historically it underpins the Features module's "what has diverged from the packaged config?" detection.

---

- Store the configuration a module ships as a snapshot so drift can be detected later.
- Back the Features module's detection of config that has diverged from what a feature provides.
- Compare a theme's or module's original config against the current active config programmatically.
- Read snapshotted config through a standard `StorageInterface` (`read`, `readMultiple`, `listAll`).
- Write config into a per-extension snapshot with `ConfigSnapshotStorage::write()`.
- Namespace snapshots per consuming module using a distinct "snapshot set" string.
- Keep separate snapshots per config collection (e.g. per language override).
- Get a snapshot storage in code via `ConfigSnapshotStorageTrait::getConfigSnapshotStorage()`.
- Fall back to a fresh storage for an extension just installed, before the container rebuilds.
- List all config names captured in a snapshot for a given extension.
- Delete or rename individual config items within a snapshot.
- Enumerate the non-default config collections present in a snapshot.
- Persist snapshot data as a `config_snapshot` config entity that exports cleanly.
- Build tooling that shows a diff between shipped and active configuration.
- Track which config objects an extension originally owned for uninstall cleanup logic.
- Register a container service per snapshot automatically for fast repeated access.
- Provide a config baseline for a custom deployment or configuration-audit workflow.
- Snapshot config at a known-good point so a module can offer a "revert to provided" action.
- Depend on it from a contrib module instead of reinventing per-extension config storage.
- Store arbitrary config data keyed by collection and name without a bespoke schema.
- Support multi-collection (translation override) snapshots in a single entity.
- Use as the storage layer behind a config-change-report or config-history feature.
