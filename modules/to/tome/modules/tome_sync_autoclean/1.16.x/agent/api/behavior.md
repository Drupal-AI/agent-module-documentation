<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tome Sync Autoclean — behavior

Pure glue: one service, no config surface.

## Service (`tome_sync_autoclean.services.yml`)
`tome_sync_autoclean.export_event_subscriber` → `ExportEventSubscriber`
(tagged `event_subscriber`), constructed with `@tome_sync.storage.content`,
`@config.storage.sync`, `@tome_sync.file_sync`, `@file_system`.

## What it does
- Subscribes to `TomeSyncEvents::EXPORT_CONTENT` (`tome_sync.export_content`), fired after each
  content entity is exported by Tome Sync.
- After export, it deletes exported files that are no longer referenced by any content or config,
  reusing Tome Sync's `CleanFilesTrait`, `ContentIndexerTrait`, and `PathTrait` — i.e. the same
  logic as `drush tome:clean-files`, but automatic.

## Caveats (why it is experimental)
- **Data loss risk:** an unsaved file on one edit form can be deleted when another entity is
  saved/exported; can break revision reverts if a file was removed.
- Intended for editing environments with heavy file churn, not production of record.

## Turning it on/off
- On: enable the module (`drush en tome_sync_autoclean -y`). There is nothing else to configure.
- Off: uninstall the module (`drush pmu tome_sync_autoclean -y`).
