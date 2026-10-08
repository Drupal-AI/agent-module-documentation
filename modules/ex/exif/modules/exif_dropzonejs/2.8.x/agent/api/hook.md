<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The DropzoneJS form-alter hook

File: `exif_dropzonejs.module`. There are no classes, services, routes, or config — the module is
this one hook plus a post-update.

## `exif_dropzonejs_form_media_library_add_form_dropzonejs_alter($form, $form_state, $form_id)`

`hook_form_FORM_ID_alter()` for the `media_library_add_form_dropzonejs` form. Flow:

1. Bail if the form has no `#source_field_name` yet (not submitted) or no uploaded file id
   (`$form['media'][0]['fields'][$media_field_name]['widget'][0]['#default_value']['fids'][0]`).
2. Load the media entity from `$form_state->getStorage()['media'][0]`, its media type, and the
   media type's `exif` third-party settings (`getThirdPartySettings('exif')`) plus mappable fields
   (`ExifHelper::fieldsForMapping($bundle)`).
3. Loop over each uploaded media item (DropzoneJS allows many at once). For each:
   - Load the `File` and read metadata: `(new ExifContent())->getDataFromFileUri($file->getFileUri())`.
   - **Alt text:** if the field's `#default_value['alt']` is empty and `third_party_settings['alt']`
     is set, split it as `group:tag`, and if that tag exists in the metadata set the alt default and
     call `ExifHelper::announceFieldPreloaded()`.
   - **Mapped fields** (`third_party_settings['field_map']`): for each mapped field with a non-empty
     tag value:
     - string / string_long / text / text_long / text_with_summary → set the widget's
       `['value']['#default_value']` to the tag value.
     - `entity_reference` to `taxonomy_term` → resolve the chosen vocabulary
       (`field->getSettings('vocabulary')['handler_settings']['target_bundles']`), find or create a
       `group > tag > value` term hierarchy (`ExifHelper::getTermByName` / `createTerm`), then clone
       the reference widget row per term (adjusting `#delta`/`#weight`) so multiple terms attach.

The hook only sets defaults when the target is empty, so editor-entered values are preserved. It
reuses parent-module config (no settings of its own).

## Post-update

`exif_dropzonejs.post_update.php` → `exif_dropzonejs_post_update_fix_settings()`: for every media
type, if a legacy `exif.exif_dropzonejs.field_map` third-party setting exists, copy it to
`exif.field_map` and remove the old key, then `save()`. This unifies the field-map storage with the
parent module's `exif` third-party settings.
