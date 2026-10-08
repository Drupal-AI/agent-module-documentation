<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Gallery Migration imports Drupal 7 "Media" module galleries (the **Media 7.x-1.x** data model) into `media_gallery` entities, core media items, and files on a Drupal 10/11 site.

---

This submodule of Media Gallery ships three `migrate_plus` migration config entities in the
`media_gallery` migration group: `d7_media_gallery_files` (copies the source files into `file`
entities), `d7_media_gallery_media` (wraps each file in an image `media` entity), and
`d7_media_gallery_entity` (creates a `media_gallery` entity per D7 `media_gallery` node and
references its media). It provides one custom migrate source plugin, `d7_media_gallery_file`
(`MediaGalleryFile extends DrupalSqlBase`), that reads the legacy `file_managed` table and, in
`prepareRow()`, keeps only files that belong to a gallery by joining the **Media 7.x-1.x** table
`field_data_media_gallery_media` (column `media_gallery_media_fid`). The migrations depend on
core `migrate`/`migrate_drupal` plus contrib `migrate_plus` and `migrate_tools`, and are run with
Drush (`drush migrate:import`). Before running you must point the migration at your real D7 source:
edit the `source_base_path` constant (default `http://d7media.docksal.site`) and configure the
legacy database connection. This is the variant for sites that used **Media 7.x-1.x**; the sibling
`media_gallery_migration2` submodule targets Media 7.x-2.x. The two cannot be enabled at the same
time because they ship migration config entities with identical ids.

---

- Import Drupal 7 Media 7.x-1.x galleries into Drupal 10/11 `media_gallery` entities.
- Copy legacy D7 gallery files into managed `file` entities during an upgrade.
- Wrap each migrated D7 file in a core image `media` entity.
- Preserve gallery titles, publish status, and created/changed timestamps from D7 nodes.
- Reconstruct each gallery's ordered `images` reference list from the D7 gallery-file relationship.
- Run the migration with `drush migrate:import --group=media_gallery`.
- Check migration progress/counts with the migrate_plus/migrate_tools config entities.
- Roll a gallery migration back with `drush migrate:rollback`.
- Re-run an incremental import after new D7 content with `--update`.
- Point the migration at a live D7 site's files by setting `source_base_path`.
- Migrate only public-scheme files by keeping the `scheme: public` source setting.
- Skip legacy files that were never part of any gallery (handled automatically in `prepareRow`).
- Carry over media alt text from the D7 `field_data_media_title` table.
- Chain file → media → gallery so references resolve via `migration_lookup`.
- Stage a Drupal 7 → 11 media upgrade as part of a larger `migrate_drupal` run.
- Provide a worked example of a custom `DrupalSqlBase` file source plugin for galleries.
- Default new galleries to a single author (uid 1) and pager enabled during import.
- Assign migrated media to the `image` bundle by default.
- Import galleries from a D7 database configured as the `migrate` source connection.
- Use as the Media 7.x-1.x branch of a two-variant migration path.
