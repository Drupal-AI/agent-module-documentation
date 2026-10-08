<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extra Paragraph Types (EPT): Image (ept_image) — agent index

Ships a single **`ept_image`** Paragraphs bundle: an image page-section built on a core **Media**
reference (image bundle), with optional title, body text, caption, wrapper link, and a GLightbox
popup. Per-paragraph display (image style, lightbox, greyscale) plus the shared EPT design options
(margin/padding/border/background/container width) come from `ept_core`. All behavior is config +
templates + preprocess; there is no admin settings form of its own.

Dependencies: `ept_core:ept_core`, `drupal:link`, `drupal:media`, `glightbox:glightbox`,
`paragraphs:paragraphs`. Core: `^10.1 || ^11 || ^12`.

Install note: `hook_requirements()` (`ept_image.install`) blocks install until an **`image`** media
type exists (`MediaType` id `image`); create one at `/admin/structure/media` first.

Configure route: **none** (no settings form; shared settings live in `ept_core`).
No permissions, no Drush, no config schema, no plugin types defined.

- **The paragraph type + its 6 fields (widgets/formatters, form tabs)** → [fields/paragraph-type.md](fields/paragraph-type.md)
- **The per-image display settings widget (image style, lightbox, greyscale)** → [fields/settings-widget.md](fields/settings-widget.md)
- **Rendering: templates, preprocess hooks, image-style-on-the-fly, GLightbox, libraries** → [theme/rendering.md](theme/rendering.md)

Key facts:
- Paragraph bundle: `ept_image` (`paragraphs.paragraphs_type.ept_image`).
- Fields: `field_ept_title` (text_long), `field_ept_text` (text_long), `field_ept_image`
  (entity_reference→media, **required**, `image` bundle, cardinality 1), `field_ept_image_caption`
  (text_long), `field_ept_image_link` (link, `link_type: 17` generic), `field_ept_settings`
  (`ept_settings`, from ept_core).
- Settings widget plugin: `ept_settings_image` → `Drupal\ept_image\Plugin\Field\FieldWidget\EptSettingsImageWidget`
  (extends ept_core `EptSettingsDefaultWidget`). Adds `image_style`, `image_lightbox`,
  `lightbox_image_style`, `greyscale`, `colorful_on_hover`.
- Service (autowired): `Drupal\ept_image\Hook\EptImageHooks`.
- Hooks: `hook_preprocess_paragraph`, `hook_theme`, `hook_theme_registry_alter`,
  `hook_theme_suggestions_field_alter`.
- Templates: `paragraph--ept-image--default.html.twig`,
  `field--paragraph--ept-image--field-ept-image.html.twig`.
- Libraries: `ept_image/ept_image` (css), `ept_image/ept_image_lightbox` (css + `glightbox/glightbox`).
- Form display: field_group Tabs (Content / Settings); `field_ept_image` uses `media_library_widget`.
- View display: `field_ept_image` uses `media_thumbnail` formatter (lazy loading).
