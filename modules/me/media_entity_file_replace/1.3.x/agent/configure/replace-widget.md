# Enable & use the Replace file widget

There is no settings form. The widget is a pseudo-field exposed on the media type's
**form display**.

## Enable
1. Go to **Admin → Structure → Media → (media type) → Manage form display**
   (`/admin/structure/media/manage/<type>/form-display`).
2. Move **Replace file** out of the *Disabled* region (it is hidden by default). Place it
   directly beneath the existing "File"/"Image" widget.
3. Save.

Only media types whose source plugin is a **File** source (Document, Image, Audio, Video…)
expose this pseudo-field (added in `hook_entity_extra_field_info()`).

## Use (editor)
Edit an existing media entity (not on create). The **Replace file** fieldset appears with:
- **File** — the replacement upload (restricted to the source field's allowed extensions).
- **Overwrite original file (.ext)** — checkbox, default **on**:
  - **checked** → the new file's bytes are copied over the original on disk; filename/path
    are preserved. The replacement **must have the same extension**. Image-style
    derivatives are flushed and the file entity re-saved (size/metadata recalculated).
  - **unchecked** → the media references the newly uploaded file (its own filename); the old
    file's usage count drops and it may be garbage-collected on cron.

When the widget is active the core file widget's **Remove**/**Upload** buttons are hidden so
editors use replacement instead of the reference-swapping core flow.

## Notes
- New (unsaved) media: widget does not appear — nothing to replace.
- Translations: the widget is suppressed in cases where a replacement would clobber the
  default-language file (translatable source field synced on the `file` column, or the
  translation references the same file id as the default language).
- Implemented in `media_entity_file_replace.module` via `hook_form_media_form_alter()` plus
  `_media_entity_file_replace_validate()` / `_media_entity_file_replace_submit()`.
