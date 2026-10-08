# Drush: delete generated styles

`src/Commands/ImageStyleDeleteCommands.php`, service `drimage_improved.image_style_delete_commands`.

## `drimage_improved:delete-styles` (alias `drimage_improved-delete-styles`)
Deletes all image styles drimage generated on the fly (styles named `drimage_improved_*`),
via `ImageStyleRepository::deleteAll()`. Reports the count deleted.

Options:
- `--crop-type=<id>` — delete only styles for that image_widget_crop crop type
  (`ImageStyleRepository::deleteByCropType()`).

Use it to reclaim disk / reset after changing threshold or crop configuration; styles regenerate
on demand on the next page view.
