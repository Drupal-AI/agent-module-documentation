<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The two Views display fields

Both are registered in `hook_views_data()` on `media_field_data` and are optional companions to the
`media_file_name` filter — they exist to make the filter's matches visible in a result table. Each
overrides `query()` as a **no-op** (the value is computed from the loaded media entity in
`render()`, so no extra SQL is added).

## Field `media_file_name` — "File name"

**Class:** `Drupal\media_views_filter\Plugin\views\field\MediaFileName`
**Annotation:** `@ViewsField("media_file_name")`
**Registered as:** `media_field_data.media_file_name` (title "File name", help "Name of file
referenced by media.").

`render(ResultRow $values)`:

```php
if ($values->_entity) {
  $media  = $values->_entity;
  $fid    = $media->getSource()->getSourceFieldValue($media);   // source field's file id
  if ($fid && ($file = File::load($fid))) {
    return Markup::create(
      '<a href="' . $file->createFileUrl() . '" target="_blank">'
      . $file->createFileUrl() . '</a>');
  }
}
return NULL;
```

It returns the **file URL** (not the raw filename) as a clickable link, because — per the source
comment — `file_managed.filename` is not always the real filename. The link opens in a new tab. The
source field id comes from the media type's source plugin (`getSourceFieldValue()`), so this works
for any file-backed media type (image, document, video file, audio, …), and returns `NULL` for media
with no loadable source file.

## Field `media_alt_text` — "Alt text"

**Class:** `Drupal\media_views_filter\Plugin\views\field\MediaAltText`
**Annotation:** `@ViewsField("media_alt_text")`
**Registered as:** `media_field_data.media_alt_text` (title "Alt text", help "Alt text attribute.").

`render(ResultRow $values)`:

```php
if ($values->_entity) {
  return $values->_entity->get('thumbnail')->getValue()[0]['alt'];
}
return NULL;
```

Returns the `alt` value of the media entity's **thumbnail** field (the image alt attribute) as a
plain string, or `NULL`.

## Adding them

Edit a media view → Add field → "File name" and/or "Alt text" → Apply. They take no per-field
settings beyond the standard Views field options.
