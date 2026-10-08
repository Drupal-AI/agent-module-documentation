File (Field) Paths lets each File/Image (file-based) field build its upload directory and stored filename from entity tokens (e.g. the node's title, id, or author), so uploads are automatically sorted and renamed into a clean, predictable filesystem.

---

File (Field) Paths extends Drupal core's File and Image field settings with a "File (Field) Path settings" section, added by a `hook_form_field_config_edit_form_alter` on any field whose class is `FileFieldItemList` (or a subclass). For each field you set a **File path** and a **File name** pattern using entity, `file` and `date` tokens; each has cleanup **options** — remove slashes from tokens, clean up via Pathauto's alias cleaner, and transliterate to US-ASCII. Because full token values are often unknown at upload time, uploads first go to a **temporary location** (per-field or the global `temp_location`, default `public://filefield_paths`) and are then moved into place when the entity is saved, via `hook_entity_insert`/`hook_entity_update` and `hook_file_presave`. A per-field **Create Redirect** option (requires the Redirect module) creates a redirect from the old file URL when a file moves; **Retroactive update** reprocesses every existing entity of the bundle once; and **Active updating** re-moves/renames files each time their entity is saved. A global settings form (`filefield_paths.admin_settings`, at `/admin/config/media/file-system/filefield-paths`, gated by `administer site configuration`) sets the default temporary location. All per-field options are stored as third-party settings on the field config (`third_party.filefield_paths`). The module adds tokens (via `hook_token_info`/`hook_tokens`), and a Drush command `filefield_paths:update` (`ffpu`) runs retroactive updates for chosen entity type/bundle/field instances. Recommended companion modules are Pathauto, Redirect and Token. This is a release-candidate (`8.x-1.0-rc1`) for Drupal 10.3+/11.

---

- Store an article's uploaded images under a path built from the node title, e.g. `articles/[node:title]/`.
- Rename uploaded files using tokens so filenames are meaningful (e.g. `[node:nid]-[file:name]`).
- Organize user-uploaded files into per-user folders using the account token.
- Sort files by date with `[date:custom:Y]/[date:custom:m]` style path patterns.
- Keep a clean filesystem without editors having to name or foldering files manually.
- Use entity tokens (id, title, author, created date) that core's File module cannot use in paths.
- Remove slashes from token values so a multi-part token doesn't create unwanted subfolders.
- Transliterate non-Latin filenames/paths into safe US-ASCII on upload.
- Clean up path/filename segments with Pathauto's alias cleaner rules.
- Upload files to a temporary location first, then move them once token values are known on save.
- Set a per-field temporary upload location, or fall back to the global `temp_location`.
- Automatically create a redirect from a file's old URL to its new URL when it is moved (with Redirect).
- Retroactively move/rename all previously uploaded files of a field after changing its pattern.
- Actively re-move/rename a file whenever its parent entity is re-saved (Active updating).
- Run retroactive updates from the CLI with `drush filefield_paths:update` (alias `ffpu`).
- Bulk-update paths for every file field on the site with `drush ffpu --all`.
- Migrate an existing site's flat upload folder into a token-structured layout in one batch.
- Apply the same naming scheme across File, Image, and other file-based field types.
- Prevent filename collisions by embedding the entity id in the stored filename.
- Configure the global default temporary file location at the module settings form.
- Enable or disable advanced path handling per field via the "Enable File (Field) Paths?" checkbox.
- Deploy per-field path/filename settings between environments as field config (third-party settings).
- Browse available replacement tokens inline via the token tree link on the field settings form.
- Add custom processing of uploaded files by implementing `hook_filefield_paths_process_file()`.
- Add extra settings fields to the form by implementing `hook_filefield_paths_field_settings()`.
- Clean token-bearing strings programmatically with the `PathProcessorInterface::processString()` service.
