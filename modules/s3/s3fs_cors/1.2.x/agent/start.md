# S3 File System CORS Upload — agent index

Supplements `s3fs` with direct browser→S3 uploads (CORS POST + presigned V4 policy) plus managed
file registration. Depends on `file`, `s3fs`, `token`. Admin form at `/admin/config/media/s3fs/cors`
(no `configure` route in info.yml). Provides two field widgets, a form element, config schema, and
permissions; no Drush, no plugin types.

- **Admin CORS settings, the two widgets, ACL, STS, bucket CORS wiring** → [configure/settings.md](configure/settings.md)
- **The upload flow end-to-end: element, presigned policy, JS, and the two AJAX routes** → [api/upload.md](api/upload.md)

Key facts:
- Widgets `s3fs_cors_file_widget`, `s3fs_cors_image_widget`; form element `s3fs_cors_file` (`S3fsCorsFile` extends core `ManagedFile`).
- Presigned POST policy built in `S3fsCorsFile::processManagedFile()`, emitted via `drupalSettings.s3fs_cors[<field>]`; JS `s3fs_cors.js`.
- Routes: `s3fs_cors.cors_key` → `AjaxController::getKey` (object key); `s3fs_cors.cors_save` → `AjaxController::saveFile` (creates File entity). Both use `access content`.
- Config `s3fs_cors.settings`: `s3fs_cors_origin`, `s3fs_https`, `s3fs_access_type`, `s3fs_sts_policy_resource`. Credentials/bucket/region come from `s3fs.settings`.
- Permissions: `administer s3fs CORS`, `generate s3fs CORS upload parameters`.
