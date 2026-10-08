<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a Views field handler that renders a thumbnail preview for image files listed from the `file_managed` table.

The module solves the small but common need of showing an actual image preview inside a File-based View (e.g. an admin file listing) instead of only a filename or link. It implements `hook_views_data_alter()` to register a virtual field `image_file_preview` on the `file_managed` base table with the Views field id `image_file_preview`; the field renders a thumbnail for image files. There is no configuration UI, no routes, no permissions, and no dependencies beyond Drupal core.

Setup is: enable the module, edit or create a View based on Files, and add the "Image File Preview" field to display thumbnails. Because it only reads existing file data and adds a display-only Views field, there are no mutating endpoints or security-sensitive surfaces.
---
Provides a display-only thumbnail column for File-based Views.
---
- Enable the module to expose the "Image File Preview" Views field.
- Add a thumbnail preview column to an existing files listing View.
- Build an admin media/file overview View that shows image thumbnails.
- Give editors a visual file browser View instead of a filename list.
- Show previews alongside file size and upload date columns in a View.
- Create a View of unused files with visible thumbnails for cleanup.
- Add the field to a View exposed to reviewers for quick visual scanning.
- Display thumbnails in a View filtered to a specific file directory.
- Combine the preview field with a "delete" bulk action View.
- Present image previews in a modal/attachment display of a View.
- Use the field id `image_file_preview` when building Views in code/config.
- Add previews to a View grouped by file MIME type.
- Show image previews in a dashboard block built from a File View.
- Provide content teams a searchable image library View with thumbnails.
- Add the preview column next to a "used in" entity-reference tracking View.
- Render thumbnails in a View of files owned by the current user.
- Include previews in an exported/attached data View for auditing.
- Add the field to a paged View of all managed image files.
- Verify uploaded images visually via a preview-enabled File View.
- Troubleshoot broken image files by scanning a preview View.