<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Juicebox plugins & their settings

Juicebox does **not** define any plugin *types* of its own — it provides two plugins that
extend core managers, plus two alter hooks.

## Field formatter — `juicebox_formatter`

- Class: `Drupal\juicebox\Plugin\Field\FieldFormatter\JuiceboxFieldFormatter`
- `@FieldFormatter(id = "juicebox_formatter", label = "Juicebox Gallery")`
- **field_types**: `image`, `file`, `entity_reference` (entity-reference only applies when
  the referenced media bundle's source plugin is `image` — enforced by `isApplicable()`).
- Config schema: `field.formatter.settings.juicebox_formatter`.

Settings keys (own + common):

| Key | Default | Notes |
|---|---|---|
| `image_style` | `juicebox_medium` (or `juicebox_multisize` if the Pro library advertises it) | main image; `''` = original |
| `thumb_style` | `juicebox_square_thumb` | thumbnails; `''` = original |
| `caption_source` | `''` | `alt` \| `title` \| `filename` \| `description` \| `''` (no caption) |
| `title_source` | `''` | same option set as caption |
| `jlib_galleryWidth` / `jlib_galleryHeight` | `100%` / `100%` | gallery dimensions |
| `jlib_backgroundColor` | `#222222` | |
| `jlib_textColor` | `rgba(255,255,255,1)` | |
| `jlib_thumbFrameColor` | `rgba(255,255,255,.5)` | |
| `jlib_showOpenButton` / `jlib_showExpandButton` / `jlib_showThumbsButton` | (bool) | UI buttons |
| `jlib_useThumbDots` | (bool) | thumbnails as dots |
| `jlib_useFullscreenExpand` | (string) | |
| `manual_config` | `''` | raw Juicebox `name=value` pairs (Pro options) |
| `custom_parent_classes` | `''` | extra CSS classes on the wrapper |
| `linkurl_source` | `''` | per-slide link URL source (`image_styled` available) |
| `linkurl_target` | `_blank` | link target |
| `incompatible_file_action` | `show_icon_and_link` | or `skip` — how to treat non-image files |
| `apply_markup_filter` | (bool) | filter caption/title markup |

## Views style — `juicebox`

- Class: `Drupal\juicebox\Plugin\views\style\JuiceboxDisplayStyle`
- `@ViewsStyle(id = "juicebox", title = "Juicebox Gallery")`
- Config schema: `views.style.juicebox`. Instead of image *styles*, it maps View **fields**:
  `image_field`, `image_field_style`, `thumb_field`, `thumb_field_style`, `title_field`,
  `caption_field`, `show_title` — plus the same `jlib_*` common options as the formatter.

## Alter hooks (`juicebox.api.php`)

- `hook_juicebox_gallery_alter($gallery, $data)` — mutate the gallery object (images,
  captions, titles) before embed/XML build. `$gallery` implements `JuiceboxGalleryInterface`.
- `hook_juicebox_classes_alter(&$class, array $library)` — swap the gallery-builder class
  (must implement `JuiceboxGalleryInterface`) for a given library version.

Service `juicebox.formatter` (`JuiceboxFormatterInterface`) builds galleries, resolves the
library, computes `confBaseOptions()` defaults, and emits embed markup + the XML feed
(routes `juicebox.xml_field` and `juicebox.xml_viewsstyle`).
