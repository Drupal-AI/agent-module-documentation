# Drimage Drush commands

Provided by `ImageStyleDeleteCommands` (`drush.services.yml` →
`drimage.image_style_delete_commands`), backed by `drimage.image_style_repository`.

## `drimage:delete-styles` (alias `drimage-delete-styles`)

Deletes the image styles drimage auto-generated (all `drimage_*` styles).

```bash
# Delete every auto-generated drimage image style.
ddev drush drimage:delete-styles

# Delete only styles for a specific crop type (names ending in _<crop_type>).
ddev drush drimage:delete-styles --crop-type=<crop_type_id>
```

- `--crop-type=<id>` → `ImageStyleRepository::deleteByCropType()` (name starts `drimage_`, ends
  `_<id>`). Without it → `deleteAll()` (name starts `drimage_`).
- Reports the count deleted. Styles regenerate on demand on the next front-end request, so this is
  safe to run to reclaim disk or force a rebuild after changing global settings.
