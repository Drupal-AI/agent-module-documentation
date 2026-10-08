<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tome Sync — events, normalizers, file-sync service

## Events — `Drupal\tome_sync\Event\TomeSyncEvents`
Subscribe with an `event_subscriber` service to run custom logic during sync.
| Constant / name | Event class | Fired when |
|---|---|---|
| `EXPORT_CONTENT` = `tome_sync.export_content` | `ContentCrudEvent` | one content entity was exported (has the entity) |
| `IMPORT_CONTENT` = `tome_sync.import_content` | `ContentCrudEvent` | one content entity was imported |
| `DELETE_CONTENT` = `tome_sync.delete_content` | `ContentCrudEvent` | one content entity was deleted |
| `EXPORT_ALL` = `tome_sync.export_all` | base event | the whole export run finished |
| `IMPORT_ALL` = `tome_sync.import_all` | base event | the whole import run finished (also via `tome:import-complete`) |

(`tome_sync_autoclean` is simply a subscriber to `tome_sync.export_content`.)

## Normalizers (`serializer.normalizer.*_tome_sync`, priority-ordered)
Custom normalizers make exports portable: `ContentEntityNormalizer`, `UserEntityNormalizer`,
`EntityReferenceItemNormalizer`, `EntityReferenceRevisionItemNormalizer`, `FieldItemNormalizer`,
`PathAliasNormalizer`, `PathautoItemNormalizer`, `PathItemNormalizer`, `UriNormalizer`. They keep
references by UUID and preserve path aliases / pathauto state across environments.

## Services
- `tome_sync.exporter` (`Exporter`) / `tome_sync.importer` (`Importer`) — serialise/deserialise entities.
- `tome_sync.storage.content` (`JsonFileStorage`, or `YamlFileStorage` when `tome_sync_encoder=yaml`).
- `tome_sync.file_sync` (`FileSync`; swap for `NullFileSync` — see configure/settings.md).
- `tome_sync.content_hasher` (`ContentHasher`) — maintains the `tome_sync_content_hash` table for partial imports.
