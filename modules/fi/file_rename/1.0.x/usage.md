File Rename adds the ability to rename an already-uploaded managed file (its filename on disk and on the file entity) without re-uploading it.

---

The module registers a `rename` entity form and route (`entity.file.rename_form`, path `admin/content/files/rename/{file}`) for core `file` entities, gated by the `rename files` permission and a custom access check that also requires the file to be permanent. From that form the user edits the base filename (the extension is fixed and shown as a suffix); on save the module moves the physical file with `FileSystem::move()`, updates the file entity's filename and URI, and invokes the `hook_file_prerename` / `hook_file_rename` hooks. It ships its own `hook_file_prerename` implementation that flushes all image-style derivatives for image files so stale cached derivatives are regenerated. A "Rename" link is added to file entities' operation links and, optionally, directly beside uploaded files on file/image field widgets — controlled globally by the `file_rename.settings:always_show_widget_link` config flag or per widget via a `show_rename_link` third-party setting on the widget in Manage form display. There is no Drush command and no plugin type; all persistent state is the single settings flag plus per-widget third-party settings.

---

- Rename a managed file's real filename after it was uploaded, without deleting and re-uploading it.
- Fix a typo or unfriendly filename (e.g. `IMG_2931.jpg` → `team-photo.jpg`) on an existing file entity.
- Give downloadable documents human-readable names so the browser's "Save as" suggests a sensible filename.
- Rename an image and have all its image-style derivatives automatically flushed and regenerated.
- Add a "Rename" operation link to the admin file listing (`admin/content/files`) for every permanent file.
- Let content editors rename a file directly from a node edit form's file/image upload widget.
- Enable the inline widget "Rename" link globally for every file field on the site with one settings toggle.
- Enable the "Rename" link for just one specific file field by ticking it in that field's Manage form display widget settings.
- Restrict who can rename files by granting the `rename files` permission only to trusted roles.
- Prevent renaming of temporary (not-yet-saved) files by relying on the built-in permanent-file access check.
- Standardise media/file naming conventions across a site by renaming legacy uploads.
- Rename a PDF/asset that is referenced from several nodes and see file usages before changing it.
- Improve SEO of file URLs by renaming files to keyword-rich, hyphenated names.
- Correct filenames that contain characters or casing your organisation's policy forbids.
- Rebrand downloadable assets (e.g. after a company name change) by renaming the underlying files.
- Provide editors a safe rename UI that reuses core's filename sanitisation (via `FileUploadSanitizeNameEvent`).
- Validate against overwriting: block a rename when a file with the target name already exists in the same directory.
- Trigger custom post-processing when a file is renamed by implementing `hook_file_rename()` in your own module.
- Flush caches or notify external systems on rename by implementing `hook_file_prerename()`.
- Clean up filenames imported from a migration that produced machine-generated names.
- Keep the file entity's stored filename in sync with the on-disk filename after a manual correction.
- Offer a rename link only on the admin theme (the route is an admin route) to keep it out of the front end.
