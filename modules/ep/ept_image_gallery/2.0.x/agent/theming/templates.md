<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming the EPT Image Gallery

## Templates (in `templates/`)

| Template | Purpose |
|---|---|
| `paragraph--ept-image-gallery--default.html.twig` | The gallery paragraph wrapper. Builds a `classes` array (`paragraph`, `ept-paragraph`, `ept-paragraph-image-gallery`, plus the chosen **Styles** value e.g. `four_columns`), attaches the `ept_image_gallery/ept_image_gallery` library, renders `field_ept_title` (with configurable wrapper tag / strip-tags from `field_ept_settings`), then the rest of the content. |
| `field--paragraph--field-ept-image-gallery--ept-image-gallery.html.twig` | Field template for the images field. |

## Theme registration

- `hook_theme()` (`EptImageGalleryHooks::galleryTheme`, legacy-bridged in `.module` as
  `ept_image_gallery_gallery_theme`) registers
  `field__paragraph__field_ept_image_gallery__ept_image_gallery` with `base hook: field`.
- `ept_image_gallery_theme_suggestions_field_alter()` adds that suggestion whenever the field is
  `field_ept_image_gallery`.
- `hook_theme_registry_alter()` (`EptImageGalleryHooks::themeRegistryAlter`) registers a second
  field variant pointing at the module's `templates/` dir.

## Styling / CSS classes

The layout is pure CSS driven by the wrapper class the widget writes. `css/ept_image_gallery.css`
(library `ept_image_gallery/ept_image_gallery`, CSS-only) targets, under
`.ept-container .field--name-field-ept-image-gallery`, each style class:
`.one_column`, `.two_columns`, `.three_columns`, `.four_columns`, `.five_columns`,
`.fixed_size_image`, `.fluid_grid`, `.featured_images_grid`.

Override by adding a same-named rule with higher specificity in your theme, or override the two
Twig templates. GLightbox itself provides the popup markup/behavior (from the `glightbox` module,
not this one).
