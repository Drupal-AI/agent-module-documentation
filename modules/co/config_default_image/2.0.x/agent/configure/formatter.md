# Configuring the Config Default Image formatter

## Setup (Manage Display)

1. Enable the module (and the submodule matching your base formatter, if using responsive/SVG).
2. Commit a web-friendly image into a git-tracked directory (custom module/theme), e.g.
   `modules/custom/my_module/images/default.png`.
3. On the entity's **Manage Display** (`entity.entity_view_display.*`), set the image field's
   **Format** to **"Image or default image"** (id `config_default_image`).
4. Open the formatter settings gear and fill in the **Default image** details (see keys below).
   Leave the field's own field-level default image *unset*.
5. `drush cex` — commit both the changed display config and the image asset to VCS.

## Settings keys

Stored on the `core.entity_view_display.<entity>.<bundle>.<mode>` component at
`content.<field>.settings.default_image` (schema type `config_default_image`):

| Key | Type | Meaning |
|---|---|---|
| `path` | string (required) | Drupal-root-relative path to the image, e.g. `themes/custom/x/img/d.jpg`. Also accepts a stream URI like `public://…`. |
| `use_image_style` | boolean | Apply the formatter's selected image style to the default image. |
| `alt` | label | Alt text for the fallback image. |
| `title` | label | Title attribute (tooltip). |
| `width` | integer | Stored intrinsic width (value element; not user-edited in the form). |
| `height` | integer | Stored intrinsic height. |

Plus the inherited core image-formatter settings (`image_style`, `image_link`).

## Render behavior (`viewElements`)

- Runs the parent formatter first; the default only kicks in when the field produced **no**
  elements (field empty).
- Builds a runtime, unsaved `File` entity (`uid: 0`, `status: 1`, `uri: <path>`) and injects it
  into a cloned `FieldItemList` (marked `_is_default`), then delegates to the parent formatter — so
  responsive/SVG/regular rendering all "just work".
- **Image-style + schemeless path:** because `ImageStyle::buildUri()` needs a scheme, if
  `use_image_style` is on and `path` has no stream scheme, the file is copied once to
  `public://config_default_image/<path>` (creating directories as needed) and that copy is used.
  If `use_image_style` is off, `image_style` is forced to `FALSE` and the raw path is rendered.

## Notes

- Path is relative to the Drupal root; keep the asset in the repo so config + image deploy together.
