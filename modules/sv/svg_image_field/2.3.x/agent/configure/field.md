# Adding & configuring the field

No global settings form — everything is per-field via **Field UI**.

## Add the field
1. **Manage fields** on your bundle → add field → **Vector image** (`svg_image_field`).
2. Field settings mirror the core image field: Alt field, Alt required, Title field, Title
   required, and a default image (schema `field.field_settings.svg_image_field`).

## Widget settings (`svg_image_field_widget`)
Set on **Manage form display**:
- `progress_indicator` — throbber/bar during upload.
- `preview_image_max_width` / `preview_image_max_height` — bounds for the inline edit preview.

## Formatter settings (`svg_image_field_formatter`)
Set on **Manage display**:

| Key | Meaning |
|---|---|
| `inline` | Output the SVG markup inline in the DOM (stylable) vs. as an `<img>`. |
| `apply_dimensions` + `width`/`height` | Emit explicit width/height. |
| `force_fill` | Stretch to fill the container. |
| `enable_alt` / `enable_title` | Render alt/title attributes. |
| `link` | Link the image to nothing, its content, or the file. |
| `sanitize` | Run output through `enshrined/svg-sanitize` to strip scripts/unsafe content. |
| `sanitize_remote` | Also sanitize SVGs loaded from remote URLs. |

Second formatter **`svg_image_url_formatter`** outputs just the file URL (no markup).

## Media
To use SVGs as media, either configure a media type manually with the **SVG** media source
(`svg`) or install the `svg_image_field_media_bundle` submodule to import a ready-made
"Vector image" media type. Uploads are validated by the `FileIsSvgImage` constraint
(MIME + content check).
