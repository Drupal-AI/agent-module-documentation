<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, plugin & constants

config_sync defines no new plugin *types*; it provides one config_distro filter plugin
instance and three services (plus an event subscriber). Registered in
`config_sync.services.yml`.

## Services

| Service id | Class | Role |
|---|---|---|
| `config_sync.snapshotter` | `ConfigSyncSnapshotter` | Takes/refreshes snapshots of extension-provided config into the `config_sync` snapshot set. |
| `config_sync.lister` | `ConfigSyncLister` | Builds per-extension changelists (what config updates are available); reads the update mode from state. |
| `config_sync.collector` | `SyncConfigCollector` | Collects the installable/provided config for extensions. |
| `config_sync_snapshot_subscriber` | `ConfigSyncSnapshotSubscriber` | Event subscriber that snapshots after a distro import. |
| `config_sync.route_subscriber` | `RouteSubscriber` | Alters config_distro routes. |

### Snapshotter (`ConfigSyncSnapshotterInterface`)

```php
$s = \Drupal::service('config_sync.snapshotter');
$s->createSnapshot();                                   // snapshot all installed extensions
$s->refreshExtensionSnapshot('module', ['mymod'], \Drupal\config_sync\ConfigSyncSnapshotterInterface::SNAPSHOT_MODE_INSTALL);
```

Constants: `SNAPSHOT_MODE_INSTALL = 'install'`, `SNAPSHOT_MODE_IMPORT = 'import'`,
`CONFIG_SNAPSHOT_SET = 'config_sync'`. Snapshot entities are config_snapshot entities named
`config_sync.<type>.<extension>` (e.g. `config_sync.module.system`).

### Lister (`ConfigSyncListerInterface`)

```php
$changelists = \Drupal::service('config_sync.lister')->getExtensionChangelists();
// [extension_type][extension][collection][operation_type][config_id] = label
$one = \Drupal::service('config_sync.lister')->getExtensionChangelist('module', 'mymod');
```

Update-mode constants (also used by the import form and `--update-mode`):
`UPDATE_MODE_MERGE = 1`, `UPDATE_MODE_PARTIAL_RESET = 2`, `UPDATE_MODE_FULL_RESET = 3`,
`DEFAULT_UPDATE_MODE = UPDATE_MODE_MERGE`. The lister reads
`state->get('config_sync.update_mode', DEFAULT_UPDATE_MODE)`.

## The sync filter plugin

`Drupal\config_sync\Plugin\ConfigFilter\SyncFilter` — a **config_filter/config_distro**
plugin (`@ConfigFilter id = "config_sync"`, `storages = {"config_distro.storage.distro"}`,
weight 10, `deriver = SyncFilterDeriver`). It injects each extension's provided-config updates
into the config_distro sync storage, applying the merge/reset behavior per the update mode.
This is a plugin *instance* of config_filter's existing type — config_sync does **not** define
a new plugin type.
