<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration Snapshot — agent index

Developer API module. Stores per-extension **snapshots of configuration** as `config_snapshot`
config entities and exposes each as a core `StorageInterface`. **No UI, no configure route
(`configure: null`), no permissions, no Drush, no plugin types.** Depends on core `config`.
Mainly consumed by other modules (e.g. Features) to detect config drift.

- **The API: entity, storage, trait, service provider — how to create/read a snapshot** →
  [api/snapshots.md](api/snapshots.md)

Key facts:

- A snapshot is identified by three parts: **snapshotSet** (namespace per consuming module),
  **extensionType** (`module`/`theme`), **extensionName**.
- Persisted as config `config_snapshot.snapshot.<set>.<type>.<name>`; entity id is
  `<set>.<type>.<name>`.
- `\Drupal\config_snapshot\ConfigSnapshotStorage` implements `StorageInterface`
  (`read`/`write`/`listAll`/`delete`/collections).
- Get one via `ConfigSnapshotStorageTrait::getConfigSnapshotStorage($set, $type, $name, $collection)`
  (returns the registered service, or a fresh object as fallback).
- `ConfigSnapshotServiceProvider` registers a service `config_snapshot.<set>.<type>.<name>`
  per snapshot at container build.
