# Hooks

The module ships **no `*.api.php`** — it does not invite you to implement hooks. This lists
the core hooks it *implements* (in `image_field_caption.module`), useful for understanding
its behavior and interaction points.

- `hook_field_info_alter()` — reclasses the core `image` field type to
  `\Drupal\image_field_caption\ImageCaptionItem` (adds the caption settings).
- `hook_field_widget_single_element_form_alter()` — for `image` fields with `caption_field`
  enabled, adds a `#process` callback (`_image_field_caption_widget_process`) that injects the
  `image_field_caption` `text_format` element; also flags `#caption_field_required`.
- `hook_theme()` — registers the `image_caption_formatter` theme hook
  (template `image-caption-formatter.html.twig`), with variables `item`, `item_attributes`,
  `url`, `image_style`.
- `template_preprocess_image_caption_formatter()` — runs core
  `template_preprocess_image_formatter()`, then adds a `caption` variable as a
  `processed_text` render array built from the item's `caption` / `caption_format`.
- `hook_entity_storage_load()` — for entity types/bundles that have captions, loads each
  stored caption via the storage service and merges it into the image field item values.
- `hook_entity_insert()` — delegates to the update hook.
- `hook_entity_update()` — for each image field with `caption_field` enabled: deletes existing
  captions for the field, then inserts a caption row per delta that has caption text.
- `hook_entity_delete()` — deletes all captions for the entity's image fields.
- `hook_entity_revision_delete()` — implemented but body is commented out (no-op; revisions
  are not managed).

To customise the rendered caption, override the Twig template rather than a hook. To read or
write captions programmatically, use the `image_field_caption.storage` service — see
[../api/image_field_caption.md](../api/image_field_caption.md).
