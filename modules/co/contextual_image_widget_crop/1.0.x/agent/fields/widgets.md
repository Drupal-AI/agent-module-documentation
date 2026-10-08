<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Widgets, AJAX route & crop-type derivation

All source lives in `contextual_image_widget_crop`. There is no settings UI, no permission, no
config object — behaviour comes entirely from the two field widgets, the altered media route, and
the crop types you already have.

## Install & enable

- `drush en contextual_image_widget_crop`. Requires `media_library` (core) and contrib
  `image_widget_crop` (`^2.4 || ^3.0`, which pulls in `crop`).
- Prerequisites: one or more **crop types** (Config → Media → Crop types), one or more **image
  styles** with a `crop_crop` effect referencing a crop type, and Image Widget Crop configured.

## Configuration (three form/display steps, from README + `HelpHooks`)

1. **Host entity form display** — on the entity that references media (e.g. node *blogpost*, Manage
   form display), set the Media reference field's widget to **"Contextual Image Widget Crop: Media
   library"** (`contextual_image_widget_crop_media_library_widget`).
2. **Host entity display** — on Manage display, give that Media field an image formatter using the
   image style whose `crop_crop` effect defines the crop type you want editors to use (e.g.
   `image_blog_post` → a 4:3 crop type).
3. **Media type form display** — on Media type *Image* → the *Media library* form display, set the
   *Image* field widget to **"Contextual ImageWidget crop"** (`contextual_image_widget_crop`).
   Configure it like the normal ImageWidget crop widget.

## `ContextualImageCropMediaLibraryWidget`

`src/Plugin/Field/FieldWidget/ContextualImageCropMediaLibraryWidget.php`, extends core
`MediaLibraryWidget`. In `formElement()`:

- `getImageStyles($entity)` iterates every view mode's `entity_view_display`, gets the field's
  renderer plugin settings, and collects image styles — both a fixed `image_style` and, for a
  `responsive_image_style`, the styles from its `image_style` and `sizes` mappings
  (`ResponsiveImageStyle::getImageStyleMappings()`).
- `getCropType(ImageStyleInterface $style)` returns the first `crop_crop` effect's
  `data.crop_type`, or `NULL`. Results are de-duped/filtered; if none, the element is returned
  unchanged (standard behaviour).
- The crop types are stored in `$form_state->set('crop_context', …)`; the overridden static
  `openMediaLibrary()` copies them into `tempstore.private` collection
  `contextual_image_widget_crop` under `MediaAjaxForm::CROP_CONTEXT` before opening the library.
- For each referenced `MediaInterface` whose source is an `Image`, it replaces core's edit button
  with an **"edit / crop"** `use-ajax` modal link to the `edit-form-ajax` link template, carrying
  query params `crop-context` (crop type ids), `element-parents` (a `/`-joined parents+file-id
  path), `file-uri`, `image-style`. It also renders a
  `contextual_image_widget_crop_library_widget_thumbnail` themed thumbnail keyed by
  `element_parents` for later AJAX refresh.

## `ContextualImageCropWidget`

`src/Plugin/Field/FieldWidget/ContextualImageCropWidget.php`, extends `image_widget_crop`'s
`ImageCropWidget`. `formElement()` calls the parent, then if the request has a `crop-context` query
param it does `array_intersect($element['#crop_list'], $context)` (narrow-only — cannot add crop
types), sets `#warn_multiple_usages = FALSE` and `#show_crop_area = TRUE`, and deletes the
`CROP_CONTEXT` tempstore key. Constructor adds `tempstore.private` + `request_stack` on top of the
parent's services.

## AJAX media edit route & form

- `Hook\EntityTypeHooks::entityTypeAlter()` adds to the **media** entity type: link template
  `edit-form-ajax` = `/media/{media}/ajax`, and form class `edit_ajax` =
  `Drupal\contextual_image_widget_crop\Form\MediaAjaxForm`.
- `Routing\RouteSubscriber::alterRoutes()` registers route **`entity.media.edit_form_ajax`** with
  `_entity_form: media.edit_ajax`, requirement **`_entity_access: media.update`**, param
  `media` = `\d+` (entity:media), `_admin_route: TRUE`. Access is enforced by core entity access —
  the caller must have update permission on that media item.
- `Form\MediaAjaxForm` extends core `MediaForm`: wraps the form in `#media-ajax-form`, adds
  `status_messages`, and sets the submit `#ajax` callback to `ajaxCloseDialog()`. On success it
  clears messages and issues a `ReplaceCommand` on
  `div[data-contextual-image-widget-crop-refresh="{element-parents}"]` re-rendering the thumbnail
  (theme `contextual_image_widget_crop_library_widget_thumbnail` with the `image-style` + `file-uri`
  from the query), then `CloseModalDialogCommand`. On validation error it replaces the form with
  its error state. The constructor reads `crop-context` from the request into the tempstore.

## Theme & hooks

- `Hook\ThemeHooks::theme()` defines `contextual_image_widget_crop_library_widget_thumbnail`
  (variables `element_parents`, `image`), template
  `templates/contextual-image-widget-crop-library-widget-thumbnail.html.twig` — a `div` with
  `data-contextual-image-widget-crop-refresh="{{ element_parents }}"` (Twig-escaped attribute)
  wrapping `{{ image }}`.
- `Hook\HelpHooks::help()` provides `help.page.contextual_image_widget_crop`. The `.module` file
  delegates the legacy `hook_help`, `hook_theme`, `hook_entity_type_alter` to these autowired
  `#[Hook]` services (`services.yml`).
