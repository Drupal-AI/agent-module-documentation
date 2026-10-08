<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate Inline Image - agent index

`save_inline_image` migrate process plugin: extracts `<img>` from migrated HTML, saves images as managed
files, rewrites src + data-entity attributes. Deps: `migrate`, `migrate_file`. Drupal 10/11.

Key file: `src/Plugin/migrate/process/SaveInlineImage.php`
- Required config: `image_file_source_path`, `image_file_save_destination` (else MigrateException).
- `transform()`: DomCrawler over `<img>`; `saveImage()` = `file_get_contents(source)` ->
  `FileRepository::writeData()` into `<dest>/bat-<uuid>/`; rewrites `src`, adds `data-entity-type/uuid`.

Not web-reachable (runs at migration/CLI time only). Version dir `8.x-1.x`.
