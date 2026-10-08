Makes the Media *Name* field non-mandatory when it is shown on the media create/edit form, and preserves a custom media name when the underlying file is replaced.

---

Via `hook_entity_base_field_info_alter` and `hook_entity_bundle_field_info_alter` the module
sets the `media.name` field to not-required (validation still handles the empty case, falling
back to core's behaviour of naming the media after the file). When the name field is exposed on
the media form, a `hook_form_media_form_alter` records the original media name and file name in
the form build info and adds a submit handler: on save, if the file has changed, the module
restores the author's custom media name instead of letting core overwrite it with the new file
name. A single configuration flag, `file_name_override` (default off), opts back into the core
behaviour of updating the media name to the new file name — but only when the media name still
equals the original file name and was not edited in the same operation. The name↔file logic
lives in the `media_name` service (`MediaName`), which locates the media's `file`/`image` field
to compare filenames. A settings form at `/admin/config/media/media-name/settings` (permission
`administer media`) exposes the one flag. Typical use: Document media where you want a stable
human name ("User manual") even after replacing `user_manual_v1.pdf` with `user_manual_v2.pdf`.

---

- Make the Media *Name* field optional on media types where it is exposed on the form.
- Let a media item be created with no name, falling back to the file name (core behaviour).
- Preserve a custom media name ("User manual") when the file is replaced.
- Keep document titles stable across file version updates.
- Avoid the media name silently changing to the new uploaded file's name.
- Opt back into "name follows file name" per-site via the `file_name_override` flag.
- Combine with Media Entity File Replace to swap files without losing the media title.
- Reduce editor friction by not forcing a name on every media upload.
- Retain manually edited names even when the same save also replaces the file.
- Apply consistent naming behaviour across all media bundles that show the name field.
- Support image media where the display title should differ from the filename.
- Prevent accidental renaming of curated media library items.
- Let the file name populate the media name only when the editor left it blank.
- Configure the behaviour once at `/admin/config/media/media-name/settings`.
- Keep core's auto-naming for bundles where the name field is hidden (module only acts when it is shown).
- Simplify DAM workflows where human-readable names must persist.
