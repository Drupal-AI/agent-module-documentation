<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contextual Image Widget Crop (contextual_image_widget_crop) — agent index

Extends **Image Widget Crop** for the **Media Library** workflow: when an editor adds/edits a Media
image referenced by a host entity, it limits the crop UI to only the crop type(s) actually used by
that field's display image style(s). Package `Media`. Depends on core **`media_library`** and
contrib **`image_widget_crop`** (`^2.4 || ^3.0`). Core `^10.2 || ^11 || ^12`. GPL-2.0-or-later.
Version 1.0.6. Maintainer: Sven Decabooter.

- **The two widgets, the AJAX route/form, crop-type derivation, install & config** →
  [fields/widgets.md](fields/widgets.md)

## What it actually is

- **No** settings form (`configure: null`), **no** permissions, **no** config schema, **no** Drush,
  **no** config/install. It ships plugins, hooks and one altered route only.
- Two field widget plugins in `src/Plugin/Field/FieldWidget/`:
  - `ContextualImageCropMediaLibraryWidget` (id `contextual_image_widget_crop_media_library_widget`,
    label *"Contextual Image Widget Crop: Media library"*, `field_types = entity_reference`) extends
    core `MediaLibraryWidget`. Set on the **host entity's** Media reference field (Manage form
    display).
  - `ContextualImageCropWidget` (id `contextual_image_widget_crop`, label *"Contextual ImageWidget
    crop"*, `field_types = image`) extends `image_widget_crop`'s `ImageCropWidget`. Set on the
    **Media type's** Image field (media library form display).
- `MediaAjaxForm` (`src/Form/MediaAjaxForm.php`) — extends core `MediaForm`; renders the media edit
  form inside a modal and closes/refreshes the thumbnail via AJAX.

## Mechanism (from source)

- Hook class `EntityTypeHooks::entityTypeAlter()` adds link template `edit-form-ajax`
  (`/media/{media}/ajax`) and form class `edit_ajax` → `MediaAjaxForm` to the **media** entity type.
- `RouteSubscriber::alterRoutes()` builds route `entity.media.edit_form_ajax` for that link template,
  gated by **`_entity_access: media.update`** and param `media` constrained to `\d+`.
- The media-library widget computes crop types via `getImageStyles()` (walks the field's view-mode
  displays, resolving fixed `image_style` and `responsive_image_style` mappings) and `getCropType()`
  (reads the `crop_crop` effect's `data.crop_type`). Crop types are stashed in a
  `tempstore.private` collection `contextual_image_widget_crop` (`CROP_CONTEXT`) and passed as the
  `crop-context` query param on the per-item "edit / crop" link.
- `ContextualImageCropWidget::formElement()` reads `crop-context` from the request and does
  `array_intersect($element['#crop_list'], $context)`, sets `#warn_multiple_usages = FALSE`,
  `#show_crop_area = TRUE`, then clears the tempstore key.
- Hook classes `ThemeHooks` (theme `contextual_image_widget_crop_library_widget_thumbnail`,
  template `templates/contextual-image-widget-crop-library-widget-thumbnail.html.twig`) and
  `HelpHooks` (`help.page.*`). `.module` delegates all three legacy hooks to these OOP hook services.

## Notes

- The crop-type list can only be **narrowed** (`array_intersect` against the widget's own
  `#crop_list`); the query cannot add crop types.
- If no display image style with a `crop_crop` effect is found, the widget falls back to the
  standard media library behaviour (returns the parent element unchanged).
