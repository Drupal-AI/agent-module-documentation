<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The migrations

Three `migrate_plus` migration config entities in `config/install`, all in migration group
`media_gallery`, all carrying `dependencies.enforced.module: [media_gallery_migration2]`:

| Migration id | Source plugin | Destination | Purpose |
|---|---|---|---|
| `d7_media_gallery_files` | `d7_media_gallery_file` | `entity:file` | Copy each D7 gallery file into a managed `file` (via `file_copy`). |
| `d7_media_gallery_media` | `d7_media_gallery_file` | `entity:media` (bundle `image`) | Wrap each file in an image media entity; sets `field_media_image` + `thumbnail` via `migration_lookup` on `d7_file` / `d7_media_gallery_files`; alt from source. |
| `d7_media_gallery_entity` | `d7_node` (`node_type: media_gallery`) | `entity:media_gallery` | One `media_gallery` per D7 gallery node; maps title/status/created/changed, sets `uid` = 1, `use_pager` = 1, `description` (format `basic_html`), and builds `images` by `sub_process` over source **`media_gallery_file`** with `migration_lookup` on `d7_media_gallery_media`. |

The effective run order is files → media → entity (`d7_media_gallery_entity` optionally depends on
`d7_media_gallery_media`; `d7_media_gallery_media` optionally on `d7_file` + `d7_media_gallery_files`).

**7.x-2.x note:** the `images` sub-process source here is `media_gallery_file` (the 7.x-2.x property
name). In the sibling `media_gallery_migration` submodule it is `media_gallery_media`.

## Before you run — required source configuration

```yaml
source:
  plugin: d7_media_gallery_file
  scheme: public
  constants:
    source_base_path: 'http://d7media.docksal.site'
```

Change `source_base_path` (a placeholder) to your real D7 site's public base URL/path, and
register the legacy Drupal 7 database as the `migrate` source connection in `settings.php`.

## Running (via migrate_tools)

No Drush commands are added by this submodule; use `migrate_tools`:

```bash
drush migrate:status --group=media_gallery
drush migrate:import --group=media_gallery      # runs files, media, entity
drush migrate:rollback --group=media_gallery
drush migrate:import d7_media_gallery_entity --update
```

## Enable / disable notes

Enabling installs the three enforced config entities; uninstalling removes them. Because
`media_gallery_migration` ships migrations with the **same ids**, only one of the two migration
submodules can be enabled at a time.
