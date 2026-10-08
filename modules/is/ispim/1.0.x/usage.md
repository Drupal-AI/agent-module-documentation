<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Image Style Preview Image Manager (ISPIM) lets site builders curate the sample images shown when previewing image styles in the Drupal admin UI.

---

Core only previews image styles against a single hard-coded sample. ISPIM adds a custom `ispim_preview_image` content entity (revisionable, translatable, with its own storage, list builder, add/edit/delete forms, access-control handler and route provider) so administrators can maintain a managed list of preview images at `/admin/config/media/ispim-preview-image`. A settings form chooses which preview image applies, and a JavaScript behaviour (`ispim.preview-image.js`, driven by `drupalSettings.ispim`) swaps the previewed image live on the image-style pages. A Drush command (`PreviewImageCommands`) can create preview-image entities from files on disk.

All routes are permission-gated: the entity's admin permission plus the dedicated `ispim.ispim_preview_image.settings.admin` permission (both `restrict access: true`), and a `PermissionProvider` supplies per-operation permissions. There are no anonymous or mutating public endpoints and no external service calls. The Drush `createFile` helper reads a local file path with `file_get_contents()` and writes it via `file.repository` — a CLI-only, operator-supplied path, not request input.

---
- Curate a list of sample images for image-style previews.
- Preview an image style against a chosen real image instead of the core default.
- Add a preview image through the admin collection UI.
- Edit or delete an existing preview image entity.
- Translate preview-image labels via config translation.
- Keep revisions of preview-image entities and revert them.
- Set the default preview image via the settings form.
- Grant only trusted roles the ISPIM admin permissions.
- Bulk-create preview images from files using the Drush command.
- Switch the previewed image live on the image-style admin page (JS).
- Provide consistent preview imagery across a multisite's image styles.
- Use a brand-representative image to judge crop/scale effects.
- Test how an image style renders faces or text before deploying it.
- Expose preview images to editors without granting broader media rights.
- Integrate preview-image selection into an image-style workflow.
- List all managed preview images via the entity collection.
- Reference the preview-image entity from custom code by its storage.
- Restrict preview-image management with the dedicated settings permission.
