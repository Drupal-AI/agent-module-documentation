# Media PDF Thumbnail — the field formatter

## Formatter: `media_pdf_thumbnail_image_field_formatter`

`src/Plugin/Field/FieldFormatter/MediaPdfThumbnailImageFieldFormatter.php`, extends core's
`ImageFormatter`.

```php
#[FieldFormatter(
  id: "media_pdf_thumbnail_image_field_formatter",
  label: @Translation("Media PDF Thumbnail Image"),
  field_types: {"image"},
)]
```

(Shipped as an `@FieldFormatter` annotation.) You select it on the **thumbnail** image field of
a Media entity in a view display (*Manage display* of the media type, or a media reference field
display). It renders a PDF-page image in place of the default thumbnail.

## Where to set it (config)

The formatter is configured in an `entity_view_display` config entity, e.g.
`core.entity_view_display.media.<type>.<view_mode>`, on the `thumbnail` component:

```yaml
content:
  thumbnail:
    type: media_pdf_thumbnail_image_field_formatter
    settings: { … per-bundle options … }
```

## Per-bundle options

The settings form (`_media_pdf_thumbnail_build_form` in `media_pdf_thumbnail.module`) builds one
fieldset per media bundle (plus a `default_bundle`), because a media view display can render
mixed bundles. Keys use the pattern `<bundleId><SUFFIX>` where the suffixes are class constants:

| Suffix constant | Key suffix | Meaning |
|---|---|---|
| `MEDIA_BUNDLE_FIELD` | `_field` | which **file field** on that bundle holds the PDF. |
| `MEDIA_BUNDLE_PAGE` | `_page` | page number to render (default `1`). |
| `MEDIA_BUNDLE_IMAGE_FORMAT` | `_format` | `jpg` or `png`. |
| `MEDIA_BUNDLE_IMAGE_STYLE` | `_image_style` | image style to apply. |
| `MEDIA_BUNDLE_LINK` | `_link` | link image to: `content` / `file` / `pdf_file` (or nothing). |
| `MEDIA_BUNDLE_ATTRIBUTES_DOWNLOAD` | `_attributes_download` | add `download` attr on the link. |
| `MEDIA_BUNDLE_ATTRIBUTES_TARGET` | `_attributes_target` | link `target` (`_blank`, …). |
| `MEDIA_BUNDLE_ATTRIBUTES_REL` | `_attributes_rel` | link `rel`. |
| `MEDIA_BUNDLE_USE_CRON` | `_use_cron` | defer generation to the cron queue. |
| `MEDIA_BUNDLE_ENABLE` | `_enable` | enable PDF-thumbnail behaviour for this bundle. |

Only file-type fields are offered for `_field` (`_media_pdf_thumbnail_get_fields_list()` filters
media fields to `type == 'file'`). A non-PDF file is ignored; multivalued fields use the first
value.

## Views integration

`media_pdf_thumbnail_form_views_ui_config_item_form_alter()` injects the same per-bundle options
when you choose this formatter for a `thumbnail__target_id` field in the Views UI, and a submit
handler flattens the fieldset values back into the field settings.

## Rendering

`viewElements()` (via the `ImageFieldFormatterElementViewTrait`) resolves the media entity,
finds the PDF file in the configured field, and calls
`media_pdf_thumbnail.image.manager->createThumbnail($media, $field, $format, $page)` (or queues
it). The manager returns `image_uri` / `image_id` and the element renders the generated image
(optionally linked). See [../api/tokens.md](../api/tokens.md) for the same via tokens.
