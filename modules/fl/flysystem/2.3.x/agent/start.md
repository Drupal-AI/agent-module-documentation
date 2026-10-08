<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Flysystem — agent index

Exposes League\Flysystem backends to Drupal as stream wrappers. Each backend is a **scheme**
declared in `settings.php` under `$settings['flysystem']` — there is **no Drupal config and
no `configure` route** (`configure: null`). Built-in drivers: `local`, `ftp`. Contrib adds
`s3v2`, `sftp`, `dropbox`, `gcs`, … Adapters are plugins (`@Adapter` annotation,
`plugin.manager.flysystem`).

- **Declare a scheme in settings.php, options, drivers, public flag, inspect live schemes** →
  [configure/schemes.md](configure/schemes.md)
- **The Adapter plugin type: annotation, interface, writing one** →
  [plugins/adapter.md](plugins/adapter.md)
- **Services (`flysystem_factory`), routes, sync/field-migration forms, permission** →
  [api/services.md](api/services.md)

Key facts:
- Config surface = `$settings['flysystem'][<scheme>] = ['driver'=>..., 'config'=>[...]]`.
- Scheme names: letters/numbers/`+`/`.`/`-` only — **no underscores**.
- `flysystem_factory->getSchemes()` lists active schemes; `->ensure()` validates them.
- One permission: `administer flysystem` (gates the sync + field-migration forms).
- Sync form route: `flysystem.config` at `/admin/config/media/file-system/flysystem`.
