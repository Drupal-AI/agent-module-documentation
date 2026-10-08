<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Gallery Migration (v2) imports Drupal 7 "Media" module galleries built on the **Media 7.x-2.x** data model into `media_gallery` entities, core media items, and files on a Drupal 10/11 site.

---

This submodule of Media Gallery is the **Media 7.x-2.x** counterpart of `media_gallery_migration`.
It ships three `migrate_plus` migration config entities in the `media_gallery` migration group:
`d7_media_gallery_files` (source files → `file` entities), `d7_media_gallery_media` (files → image
`media` entities), and `d7_media_gallery_entity` (D7 `media_gallery` nodes → `media_gallery`
entities). It provides its own `d7_media_gallery_file` source plugin
(`MediaGalleryFile extends DrupalSqlBase`) that reads the legacy `file_managed` table and, in
`prepareRow()`, keeps only gallery files by joining the **Media 7.x-2.x** table
`field_data_media_gallery_file` (column `media_gallery_file_fid`) — this table/column and the
`d7_media_gallery_entity` `images` sub-process source (`media_gallery_file`) are the only real
differences from the 7.x-1.x submodule. It depends on core `migrate`/`migrate_drupal` plus contrib
`migrate_plus` and `migrate_tools`, and is run with Drush (`drush migrate:import`). Before running,
set the `source_base_path` constant (default `http://d7media.docksal.site`) and configure the
legacy D7 database connection. Because it ships migration config entities with the **same ids** as
`media_gallery_migration`, the two migration submodules cannot be enabled simultaneously — pick the
one that matches your D7 Media version.

---

- Import Drupal 7 Media 7.x-2.x galleries into Drupal 10/11 `media_gallery` entities.
- Copy legacy D7 gallery files into managed `file` entities during an upgrade.
- Wrap each migrated D7 file in a core image `media` entity.
- Preserve gallery titles, publish status, and created/changed timestamps from D7 nodes.
- Rebuild each gallery's `images` reference list from the 7.x-2.x gallery-file relationship.
- Run the migration with `drush migrate:import --group=media_gallery`.
- Roll a gallery migration back with `drush migrate:rollback --group=media_gallery`.
- Re-run an incremental import after new D7 content with `--update`.
- Point the migration at a live D7 site's files by setting `source_base_path`.
- Migrate only public-scheme files by keeping the `scheme: public` source setting.
- Skip legacy files that were never part of any gallery (handled in `prepareRow`).
- Carry over media alt text from the D7 `field_data_media_title` table.
- Chain file → media → gallery so references resolve via `migration_lookup`.
- Stage a Drupal 7 → 11 media upgrade as part of a larger `migrate_drupal` run.
- Choose this submodule when the source site used Media 7.x-2.x (`field_data_media_gallery_file`).
- Default migrated galleries to author uid 1 and pager enabled.
- Assign migrated media to the `image` bundle by default.
- Provide a worked example of a `DrupalSqlBase` gallery-file source for the 7.x-2.x schema.
- Import galleries from a D7 database configured as the `migrate` source connection.
- Use as the Media 7.x-2.x branch of the two-variant migration path.
- Uninstall to cleanly remove its enforced migration config when the import is done.
