<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Media Orange Logic

Install via Composer only — it pulls `drupal/media_library_extend` and requires patches
(see the module `readme.md`, e.g. issue 3218930 patches for MLE).

1. Provide DAM credentials at `/admin/config/media/media-orange-logic`
   (`MediaOrangeLogicAdminForm`, permission `administer orange logic`). Config object:
   `media_orange_logic.settings` (search endpoint, token endpoint, login).

## Entity Browser path
- Add an entity-reference field (target type *media*) to a content type.
- Manage form display → choose the **Entity Browser** widget → select **OrangeLogicMediaBrowser**.
- Optionally add an *Orange Logic* field to the media type to store the full DAM payload.

## Media Library path
- Enable the `orange_logic_media_library` submodule.
- Add an entity-reference (media) field; on the form display select the **Media Library** widget.
- Add a media library pane with a field mapping at `/admin/config/media/media-library/pane`
  (mapping fills extra media fields not covered by the entity browser widget).

## Samples
Enable `media_orange_logic_samples` for ready-made `audio_orange_logic` / `video_orange_logic`
media types, field storage, form/view displays and the `orangelogicmediabrowser` entity browser.

The module is under active development; per the readme some features (autofill of alt-text,
audio/video in the Media Library widget, per-field media-type filtering) are incomplete.
