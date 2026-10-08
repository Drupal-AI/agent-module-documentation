<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Declared in `exif.drush.inc` (legacy Drush 8 `hook_drush_command()` style; supported entity types are
`file`, `media`, `node`). All operate only on bundles enabled in `exif.settings`.

## `exif-list [entity_type]`

Lists the bundles where EXIF extraction is enabled (optionally filtered to one of
`media|file|node`). Implemented by `drush_exif_list()` → `__drush_exif_list_active_types()`.

```bash
ddev drush exif-list
ddev drush exif-list media
```

## `exif-update [entity_type] [type]`

Re-saves every entity of the selected enabled bundle(s) so the presave hook re-reads metadata.
Implemented by `drush_exif_update()`; per entity type it queries the base table and calls
`Node::load()->save()` / `File::load()->save()` / `Media::load()->save()`.

```bash
ddev drush exif-update            # all enabled bundles
ddev drush exif-update node photography
```

## `exif-import <entity_type> <type> <field> <path>`

Imports a JPEG file or a directory tree of JPEGs, creating one entity per image with the file placed
in `<field>`. Implemented by `drush_exif_import()` → `__drush_exif_entity_import()`. Required args:
entity type (`file|media|node`), bundle, image/media field name, and a file or directory path. Files
are written to `public://` and, for node/media, a new entity is created (author uid 1); metadata is
then populated by the normal presave hook. Only `IMAGETYPE_JPEG` files are picked up when walking a
directory.

```bash
ddev drush exif-import node photography field_image /var/www/photos/
```

Note: these are legacy `.drush.inc` commands, not annotated Drush 9+ command classes.
