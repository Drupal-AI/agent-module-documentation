<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Advanced File Destination adds a "Destination folder" selector to file and image upload widgets so editors can choose (or create on the fly) the directory an uploaded file lands in, instead of always using the field's fixed upload path.

---

Advanced File Destination extends Drupal's core file and image upload widgets — and the Media Library / media add forms — with a destination-directory dropdown. Editors pick from a list of configured directories (the `afd_directory` content entity), from folders discovered on the filesystem, or create a new subfolder in a modal without leaving the content form. The chosen path is remembered per user + per upload-widget instance in Drupal's `State`, and the module moves the saved file into that directory during `hook_ENTITY_TYPE_presave()`. Which entity types show the selector is configurable (default: node, media), and available stream wrappers (`public://`, `private://`, `assets://`, `temporary://`) are toggled in settings. The module also re-points Focal Point image-style renditions to the custom directory when that integration is present. Directories are full content entities with revisions, weight ordering, an owner, and optional per-directory role targeting; they are managed at `/admin/content/directories`. A granular permission set governs who can access the selector, create directories, delete/enable/disable them, and target the private filesystem.

---

- Let editors pick the upload folder per file on any file or image field.
- Create a new subfolder during upload via an AJAX modal (`NewDirectoryModalForm`).
- Override a file field's fixed `file_directory` at upload time.
- Offer a curated list of destinations as `afd_directory` entities managed in the admin UI.
- Sort destinations in the dropdown by weight, then name.
- Add the selector to the Media Library add form and media image form.
- Enable the feature only for chosen entity types (node, media, …) in settings.
- Set a site-wide default upload directory.
- Toggle which stream wrappers (`public://`, `private://`, `assets://`, `temporary://`) are selectable.
- Optionally scan the filesystem to expose existing subfolders as choices.
- Save uploaded files into the selected directory automatically on entity presave.
- Keep Focal Point renditions alongside the file in its custom directory.
- Track directory changes with revisions and revision log messages.
- Assign an owner and optional target roles to each directory entity.
- Bulk enable, disable, or delete directories from the admin list.
- Provide the `advanced_file_destination` field widget for file and image fields.
- Organize media into user-specific or project-specific folders.
- Give content teams predictable, structured file organization.
- Manage directories at `/admin/content/directories` and settings at `/admin/config/media/advanced-file-destination`.
- Support both Drupal 10 and 11.
- Separate permissions for access, create, delete, enable, and disable actions.
