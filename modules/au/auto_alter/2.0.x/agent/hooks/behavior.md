<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Runtime behaviour (hooks in auto_alter.module)

All automatic generation is gated by `auto_alter.settings:suggestion` (translation auto-population is
gated by `alttext_ai_auto_populate_translations`). Alt text is only filled when it is currently
**empty**. Every path ultimately calls `auto_alter_get_description($fid)` → the active engine.

## `hook_entity_presave()` — `auto_alter_entity_presave`

Runs for any `ContentEntityInterface`. Two branches:

1. **Translation auto-populate** (when `alttext_ai_auto_populate_translations` is on and the entity
   is a non-default translation): pulls descriptions cached in `tempstore.private` collection
   `auto_alter` key `last_descriptions` for the target langcode and writes them into image-field
   `alt` where empty or equal to the source alt. Returns early.
2. **Suggestion** (when `suggestion` is on): iterates bundle fields.
   - `image` fields: for each item with empty `alt`, sets `alt = auto_alter_get_description(target_id)`.
   - `text_with_summary` fields (e.g. body): parses the HTML with `Masterminds\HTML5`, finds `<img>`
     with empty `alt`, loads the referenced `file` by `data-entity-uuid`, and — if the file is an
     image — injects the generated description as an `alt="…"` attribute into the stored markup.

## `hook_form_alter()` — `auto_alter_form_alter`

Only active when `suggestion` is on. Pre-fills the image widget's `#default_value['alt']` (when the
widget has `#alt_field` and the alt is empty) on:
- standard fieldable entity add/edit forms (those with `#entity_builders`);
- `media_directories_add_form`, `media_library_add_form_dropzonejs`;
- `media_library_add_form_upload` (after the upload button fires).

Separately, on the CKEditor `editor_image_dialog` form it always adds a **"Get suggestion"** button
(`#ajax` callback `getAlternativeText`, wrapper `editor-image-dialog-form`) so an editor can request
alt text on demand for the embedded image.

## `hook_entity_translation_create()` — `auto_alter_entity_translation_create`

When `alttext_ai_auto_populate_translations` is on and a new (non-default) translation is created,
for each image field whose source alt is non-empty it calls `auto_alter_get_translated_alt($file,
$langcode)`, which uses the engine's `getDescriptions()` and writes the per-language description into
the translation's `alt`. Errors are logged to channel `auto_alter`.

## Extension point

`auto_alter_describe_image_info` — alter hook fired by the plugin manager; implement it to
add/modify/remove `AutoAlterDescribeImage` plugin definitions.
