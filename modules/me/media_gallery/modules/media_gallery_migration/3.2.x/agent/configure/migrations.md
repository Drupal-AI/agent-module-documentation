<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The migrations

Three `migrate_plus` migration config entities in `config/install`, all in migration group
`media_gallery`, all carrying `dependencies.enforced.module: [media_gallery_migration]`:

| Migration id | Source plugin | Destination | Purpose |
|---|---|---|---|
| `d7_media_gallery_files` | `d7_media_gallery_file` | `entity:file` | Copy each D7 gallery file into a managed `file` (via `file_copy`). |
| `d7_media_gallery_media` | `d7_media_gallery_file` | `entity:media` (bundle `image`) | Wrap each file in an image media entity; sets `field_media_image` + `thumbnail` via `migration_lookup` on `d7_file` / `d7_media_gallery_files`; alt from source. |
| `d7_media_gallery_entity` | `d7_node` (`node_type: media_gallery`) | `entity:media_gallery` | One `media_gallery` per D7 gallery node; maps title/status/created/changed, sets `uid` = 1, `use_pager` = 1, `description` (format `basic_html`), and builds `images` by `sub_process` over source `media_gallery_media` with `migration_lookup` on `d7_media_gallery_media`. |

Dependencies between them: `d7_media_gallery_entity` has an optional dependency on
`d7_media_gallery_media`; `d7_media_gallery_media` has optional deps on `d7_file` and
`d7_media_gallery_files`. So the effective order is files → media → entity.

## Before you run — required source configuration

Both file-reading migrations set:

```yaml
source:
  plugin: d7_media_gallery_file
  scheme: public
  constants:
    source_base_path: 'http://d7media.docksal.site'
```

`source_base_path` is a **placeholder** — change it to your real D7 site's public base URL (or
local path) so `file_copy` can fetch the originals. You must also register the legacy Drupal 7
database as a `migrate` source connection (standard `migrate_drupal` setup), e.g. a `migrate`
key in `settings.php`.

## Running (via migrate_tools)

This submodule adds **no** Drush commands; use `migrate_tools`:

```bash
drush migrate:status --group=media_gallery
drush migrate:import --group=media_gallery      # runs files, media, entity
drush migrate:rollback --group=media_gallery
drush migrate:import d7_media_gallery_entity --update
```

## Enable / disable notes

Enabling installs the three config entities; uninstalling removes them (enforced dependency).
Because `media_gallery_migration2` ships migrations with the **same ids**, only one of the two
migration submodules can be enabled at a time.
