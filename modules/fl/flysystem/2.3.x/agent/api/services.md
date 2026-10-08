<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — services, routes, forms, permission

## `flysystem_factory` (`Drupal\flysystem\FlysystemFactory`)

The central service. Reads `$settings['flysystem']`, applies defaults, and builds filesystems.

| Method | Returns |
|---|---|
| `getSchemes()` | `string[]` of active (valid) scheme names. |
| `getSettings($scheme)` | the scheme's settings array (`driver`, `config`, `replicate`, …). |
| `getPlugin($scheme)` | the `FlysystemPluginInterface` for the scheme. |
| `getFilesystem($scheme)` | a `League\Flysystem\Filesystem`. |
| `ensure($force = FALSE)` | validates every scheme; returns `[scheme => [errors]]`. Runs on cron + `hook_rebuild`. |

Defaults merged per scheme: `driver=''`, `config=[]`, `replicate=FALSE`, `cache=FALSE`,
`name=''`, `description=''`.

## Other services

- `plugin.manager.flysystem` — the `@Adapter` plugin manager (see plugins/adapter.md).
- `cache.flysystem` — cache bin for filesystem metadata.
- `path_processor.flysystem` / `path_processor.flysystem_redirect` — inbound path processors
  for `/_flysystem/...` and image-style redirect URLs.
- `flysystem.ensure_subscriber`, `flysystem.image_style_copier` — event subscribers.

## Routes

| Route | Path | Purpose |
|---|---|---|
| `flysystem.files` / `flysystem.serve` | `/_flysystem/{scheme}[/{filepath}]` | Serve/download scheme files through Drupal. |
| `flysystem.config` | `/admin/config/media/file-system/flysystem` | **Sync** form (copy all files scheme→scheme). |
| `flysystem.migrate_field` | `/admin/config/media/file-system/flysystem/field-migration` | Move existing field uploads to a scheme. |

Plus dynamically generated per-scheme routes (`FlysystemRoutes::routes()`) for public local
schemes and image-style derivatives.

## Forms

- `ConfigForm` (Sync): pick `sync_from` / `sync_to` schemes + `force`; batch-copies files.
  "From" and "To" must differ. Useful after adding a remote scheme to a previously-local site.
- `FieldMigration`: migrate file/image field data onto a Flysystem scheme.

## Permission

`administer flysystem` (`restrict access: TRUE`) — gates both admin forms. File **access**
itself is handled by Drupal file permissions + `flysystem_entity_access()`, not this
permission.

## Hooks the module implements (not for you to implement)

`hook_cron`, `hook_rebuild` (both call `ensure()`), `hook_file_download`,
`hook_entity_access` (grants download/view on public-scheme files).
