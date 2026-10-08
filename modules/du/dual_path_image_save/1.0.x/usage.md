<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dual Path Image Save copies selected image-field files to an extra custom directory (in addition to their normal upload location) whenever a node is saved.
---
An administrator lists the target image field names (one per line) at `/admin/config/media/dual-path-image-save` (route `dual_path_image_save.admin_settings`, permission `administer site configuration`), storing them in `dual_path_image_save.settings:fields`. For each listed field the field's config edit form gains a "Dual Path Settings" third-party setting where an admin sets the custom destination path (default `public://`). On `hook_entity_presave` for nodes, `dual_path_image_save_entity_presave()` reads each configured field's file, prepares the custom directory (`CREATE_DIRECTORY | MODIFY_PERMISSIONS`), and copies the file there with `basename($original_path)` as the filename (`EXISTS_REPLACE`).

The destination path is derived entirely from admin-set config/third-party settings, not from request input, and the filename is reduced with `basename()`, so there is no user-controlled path traversal here. A bundled Views field plugin (`DualPathImage`) exposes the dual-path image in views. Setup: enable (depends on `image`, `views`, `field`), list the field names, then set each field's custom path on its field settings form.
---
- Mirror uploaded article images into a second directory on save.
- Configure which image fields are dual-saved via a newline list.
- Set a per-field custom destination path in the field settings form.
- Default new custom paths to `public://`.
- Keep the original upload untouched while adding a copy elsewhere.
- Use a private-scheme custom path for an alternate copy.
- Create the destination directory automatically if missing.
- Overwrite an existing copy on re-save (EXISTS_REPLACE).
- Expose the dual-path image via a Views field handler.
- Feed an external process that watches the custom directory.
- Standardize asset locations across content types.
- Restrict configuration to `administer site configuration` holders.
- List multiple fields, one machine name per line.
- Copy only when the field is non-empty on the node.
- Preserve the original filename via `basename()`.
- Audit that destination paths come from admin config, not user input.
- Combine with image styles applied to the primary field.
- Export the `dual_path_image_save.settings` config between environments.
- Verify directory permissions are writable for the web user.
- Disable the module to stop mirroring without touching existing copies.
