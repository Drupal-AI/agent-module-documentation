Routes file and image field uploads to a configured destination directory at entity save time, with per-field rules, a global fallback and token support in the path.

---

Advanced Filesystem: Upload Directory (machine name `advanced_filesystem_upload_directory`) relocates files uploaded through file/image fields to a directory you choose, rather than the location baked into each field. After a content entity is saved, the `UploadDirectoryManager` (called from `hook_entity_insert()` / `hook_entity_update()`) walks every file/image field on the entity, picks the target directory — the first matching enabled per-field rule for the entity type, bundle and field, or a global fallback — resolves any Drupal tokens in the directory against the saved entity, optionally creates the directory, and moves each file there with `FileRepository::move()`. Directories are stream-wrapper URIs and can include tokens like `[date:year]`. An admin settings form builds rules with cascading entity-type → bundle → field dropdowns and a scheme + subdirectory picker with a live preview, and a file-browser page lists what is currently stored in each configured directory. It depends on `file`, `user`, `field` and the parent `advanced_filesystem` module, and is administered through one restricted permission.

---

- Store all uploads for a content type in a dedicated folder instead of the field default.
- Organize files by year with a token path such as `public://uploads/[date:year]/`.
- Route article image-field uploads to `public://articles/` and document uploads elsewhere.
- Set a single global fallback directory applied to every file/image field without its own rule.
- Define per-field rules scoped precisely to an entity type, bundle and field name.
- Order rules so the first matching enabled rule wins, with the global fallback as a catch-all.
- Use any writable stream wrapper (public://, private://, or a remote wrapper like S3) as the destination.
- Auto-create destination directories on save, or require them to pre-exist.
- Move existing attachments to the new location when an entity is re-saved (update hook).
- Preview how a token-based directory resolves for the current date/user before saving the rule.
- Keep uploads out of the crowded top-level files directory by giving each field a tidy subfolder.
- Consolidate media into structured folders for easier backup, CDN or sync configuration.
- Browse the files currently stored in each configured directory from an admin page.
- Filter the file browser by stream-wrapper scheme when directories span several wrappers.
- Turn upload routing on or off globally without deleting the configured rules.
- Add or remove per-field rules interactively with AJAX add/remove buttons on the settings form.
- Choose destinations only from user-facing writable wrappers (temporary:// is excluded).
- Migrate a field's storage location by changing its rule; subsequent saves relocate the files.
- Combine date and content tokens to build descriptive, self-organizing upload paths.
