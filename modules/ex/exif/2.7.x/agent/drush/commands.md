# Exif Drush commands

Declared in `exif.drush.inc` using the **legacy `hook_drush_command()` (Drush 8/9) style**. These
`.drush.inc` files are not loaded by modern Drush (10+), so on a current DDEV/Drush stack the commands
below may be unavailable — treat them as legacy/reference. There is no `drush.services.yml` or
`src/Drush/` command class in this release.

| Command | Args | Purpose |
|---|---|---|
| `exif-list` | `[entity_type]` | List bundles where Exif extraction is enabled (`node`/`media`/`file`, or all). |
| `exif-update` | `[entity_type] [type]` | Re-save every entity of a type so metadata is re-read (respects `update_metadata`). Runs raw `SELECT` + `->save()` per entity. |
| `exif-import` | `<entity_type> <type> <field> <path>` | Recursively import JPEGs from `path` as new entities of `type`, attaching each file to image `field` and letting the save hooks fill metadata. |

Examples:

```bash
drush exif-list node
drush exif-update media photo
drush exif-import node photography field_image /var/data/photos
```

`exif-import` only picks files where `exif_imagetype($item) == IMAGETYPE_JPEG`. `exif-update` iterates
all entities of the bundle with no batching, so it is memory-heavy on large sites.
