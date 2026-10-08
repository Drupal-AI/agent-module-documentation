Upload Size Per Role overrides the maximum file-upload size on file fields per user role, so different roles can be granted larger or smaller upload limits.

---

Drupal file/image fields carry a single "Maximum upload size" setting that applies to everyone regardless of role. Upload Size Per Role replaces that one-size-fits-all limit with a per-role, per-field matrix: on the settings page (`/admin/config/media/upload-size-per-role`, `administer site configuration`) every `file`-type field on every fieldable entity type/bundle is listed, with a numeric MB cell for each user role. At form-build time `hook_form_alter()` reads the saved `upload_size_per_role.settings` mapping, picks the value configured for the current user's roles, caps it at PHP's `upload_max_filesize`, rewrites the widget description, and — importantly — sets the widget's real server-side upload validators (`FileSizeLimit`/`file_validate_size`) so the limit is enforced on submit, not merely displayed. Note the project's own guidance: leave the field's own "Maximum upload size" empty for any field you override, or the description rewrite can misbehave. The module governs upload size only, not file extension or type, so pair it with core's field-level extension restrictions for complete upload safety.

---

- Give trusted editor roles a larger upload limit than ordinary users on a specific file field.
- Keep the anonymous/authenticated upload limit small while allowing staff bigger files.
- Set a different max upload size per role for each `file`-type field and bundle independently.
- Raise the effective upload limit on a field above its stored default for privileged roles (capped at PHP's `upload_max_filesize`).
- Lower the effective upload limit for a role below the field's default to conserve storage.
- Configure the whole per-role/per-field matrix from one admin screen at `/admin/config/media/upload-size-per-role`.
- Differentiate limits across custom roles (e.g. "contributor" vs "editor" vs "administrator").
- Apply per-role sizing to file fields on nodes, media entities, users, taxonomy terms, or any fieldable entity.
- Enforce the limit server-side via the widget's upload validators, not just as a displayed hint.
- Automatically clamp any per-role value to what PHP's `upload_max_filesize` actually permits.
- Restrict administration of these limits to site administrators (`administer site configuration`).
- Manage upload allowances by role without writing custom form-alter code.
- Support sites with diverse roles that each need different file-size budgets.
- Reduce large-upload resource abuse from lower-trust roles.
- Tailor the upload experience so each role sees a description reflecting its own limit.
- Combine with core "Allowed file extensions" settings for both size and type control.
- Reconfigure limits at any time from the config form; changes take effect on the next form build.
- Reach the settings form from the Media section of the admin config page (menu link under `system.admin_config_media`).
- Leave a field unmapped for a role to fall back to that field's own default max size.
- Audit which roles get which upload budget across the whole site from a single table.
