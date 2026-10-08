# Media PDF Thumbnail — tokens & image manager

## Tokens (`media_pdf_thumbnail.tokens.inc`)

Token type: **`media_pdf_thumbnail`**, evaluated against a `media` object in the token data.
The token name encodes the request; general form:

```
[media_pdf_thumbnail:<pdf_field_name>:<page>:<format>:<value>]
[media_pdf_thumbnail:<pdf_field_name>:<page>:<format>:render:<image_style>]
[media_pdf_thumbnail:<pdf_field_name>:<page>:<format>:render:<image_style>:link_pdf]
```

- `<pdf_field_name>` — the media file field holding the PDF (e.g. `field_media_file`).
- `<page>` — page number (e.g. `1`).
- `<format>` — `jpg` or `png`.
- `<value>` — `image_uri`, `image_id`, or `render` (with a following image style).
- `render:<style>` — themed `image_style` output; append `:link_pdf` to wrap it in a link to
  the PDF file.

### Examples

```php
$token = \Drupal::token();

// file URI of the generated image
$uri = $token->replace('[media_pdf_thumbnail:field_media_file:1:jpg:image_uri]', ['media' => $media]);

// file id
$fid = $token->replace('[media_pdf_thumbnail:field_media_file:1:jpg:image_id]', ['media' => $media]);

// rendered, image-styled thumbnail
$html = $token->replace('[media_pdf_thumbnail:field_media_file:1:jpg:render:medium]', ['media' => $media]);

// rendered thumbnail linked to the PDF
$html = $token->replace('[media_pdf_thumbnail:field_media_file:1:jpg:render:medium:link_pdf]', ['media' => $media]);
```

Each token invocation calls `media_pdf_thumbnail.image.manager->createThumbnail($media, $field,
$format, $page)` and returns the requested value (generating + caching the image on first use).

## Image manager service: `media_pdf_thumbnail.image.manager`

Class `Manager\MediaPdfThumbnailImageManager`. Key public methods:

| Method | Returns / purpose |
|---|---|
| `createThumbnail(EntityInterface $entity, string $fileFieldName, string $imageFormat, int $page = 1)` | generate (or fetch cached) the thumbnail; returns an info array (`image_uri`, `image_id`, `pdf_uri`, …) or FALSE/NULL. |
| `getImageIfExists($entity, FileInterface $file, $fieldName, $format, $page = 1)` | return cached image info without regenerating. |
| `getFileEntityFromField($entity, $fieldName)` | the file entity referenced by a field. |
| `getPdfImage($entity, $fieldName, FileInterface $file, $format, $page)` | low-level generate one page. |
| `getPdfEntityByPdfFileUri(string $fileUri)` | reverse-lookup `pdf_image_entity` rows for a PDF (used by private-file access). |
| `getGenericThumbnail(bool $load = FALSE)` | the fallback generic image. |

Valid source mime type is `application/pdf` (`VALID_MIME_TYPE`). Other manager services:
`media_pdf_thumbnail.imagick.manager` (rasterises via imagick),
`media_pdf_thumbnail.pdf_image_entity.queue.manager` (cron queue), and
`media_pdf_thumbnail.pdf_image_entity.purge.manager` (cleanup).
