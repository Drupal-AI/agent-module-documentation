# Media PDF Thumbnail — hooks (`media_pdf_thumbnail.api.php`)

## `hook_media_pdf_thumbnail_image_render_alter(array &$element, array $infos)`

Alter the rendered PDF-thumbnail image element before it is output. `$element` is the image
field render array; `$infos` carries context (incl. `mediaEntity`).

```php
function mymodule_media_pdf_thumbnail_image_render_alter(array &$element, array $infos): void {
  $value = $element[0]["#item"]->getValue();
  $value['alt'] = 'Thumbnail of the document ' . $infos['mediaEntity']->name->value;
  $element[0]["#item"]->setValue($value);
}
```

Typical uses: set a meaningful `alt`/`title` from the media entity, add attributes/classes, or
swap the image item. This is the only invited hook.

## Core hooks the module itself implements (for orientation)

- `hook_file_download()` — enforces `view private pdf thumbnails` for generated images whose
  source PDF is private.
- `hook_entity_delete()` — when a `pdf_image_entity` is deleted, deletes its generated file.
- `hook_form_views_ui_config_item_form_alter()` — injects the per-bundle formatter options in
  the Views UI.
- `hook_token_info()` / `hook_tokens()` — the `media_pdf_thumbnail` tokens
  (see [../api/tokens.md](../api/tokens.md)).

There is no plugin type and no Drush command; extend behaviour via the render-alter hook above
or by decorating the `media_pdf_thumbnail.image.manager` service.
