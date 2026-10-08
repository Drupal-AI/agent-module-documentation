<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Gallery Migration (Media 7.x-1.x) — agent index

Submodule of **media_gallery**. Imports Drupal 7 **Media 7.x-1.x** galleries into `media_gallery`
entities, `media` items, and `file` entities on D10/11. Depends on `media_gallery`, core
`migrate`/`migrate_drupal`, and contrib `migrate_plus` + `migrate_tools`. Ships three
`migrate_plus.migration.*` config entities (group `media_gallery`) and one migrate source plugin.
No permissions, no config schema, no Drush commands of its own (use `migrate_tools`' `drush
migrate:*`).

- **The three migrations, the migration group, run/rollback commands, and the `source_base_path`
  you must change** → [configure/migrations.md](configure/migrations.md)
- **The `d7_media_gallery_file` source plugin and the D7 table it reads
  (`field_data_media_gallery_media`)** → [api/source-plugin.md](api/source-plugin.md)

Key facts: migration ids `d7_media_gallery_files`, `d7_media_gallery_media`,
`d7_media_gallery_entity`; source plugin id `d7_media_gallery_file`
(`Drupal\media_gallery_migration\Plugin\migrate\source\MediaGalleryFile`). The migration config
entities carry an **enforced** dependency on `media_gallery_migration`, so they are removed when
this submodule is uninstalled. This is the **Media 7.x-1.x** variant; `media_gallery_migration2`
is the Media 7.x-2.x variant and cannot be enabled at the same time (identical config ids).
