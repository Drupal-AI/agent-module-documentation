S3 File System CORS Upload supplements `s3fs` by letting the browser upload files **directly** to an AWS S3 bucket (via a CORS POST) instead of routing bytes through the Drupal/PHP server, then registering the uploaded file as a managed file entity.

---

The module provides two field widgets — `s3fs_cors_file_widget` and `s3fs_cors_image_widget` — and the `s3fs_cors_file` form element (`S3fsCorsFile`, extending core `ManagedFile`) used to render them. When a form containing the widget is built, `S3fsCorsFile::processManagedFile()` computes the S3 object key from the field's upload destination and generates a **Signature V4 presigned POST policy** server-side (6-hour expiry) using the credentials from `s3fs.settings` (or an STS `getFederationToken` session when running without static keys), then emits the policy, signature, ACL, and form action into `drupalSettings.s3fs_cors[<field>]`. `s3fs_cors.js` intercepts the file input and POSTs the file straight to S3. Two AJAX controller routes support the flow: `s3fs_cors.cors_key` (`AjaxController::getKey`) returns/deduplicates the object key, and `s3fs_cors.cors_save` (`AjaxController::saveFile`) writes the URI into the s3fs metadata cache and creates a `File` entity (status 0) for it. An admin form at `/admin/config/media/s3fs/cors` (`s3fs_cors.admin_form`, permission `administer s3fs CORS`) stores the CORS origin, HTTP/HTTPS choice, upload ACL (`public-read`/`private`), and STS policy resource in `s3fs_cors.settings`, and on save calls `putBucketCors()`/`deleteBucketCors()` to configure the bucket's CORS rules directly at AWS. The ACL applied to uploads follows the `s3fs_access_type` setting.

---

- Upload large files directly from the browser to S3 without passing through PHP memory/time limits.
- Bypass `post_max_size` / `upload_max_filesize` limits for big media uploads.
- Attach a "direct to S3" file field to a content type.
- Attach a "direct to S3" image field to a content type.
- Offload video/asset uploads to S3 to reduce web-server load.
- Configure the bucket's CORS rules from Drupal (allowed origin, methods) via the admin form.
- Choose whether uploaded objects are `public-read` or `private`.
- Use HTTPS (or HTTP) for the direct upload POST endpoint.
- Generate short-lived STS federation credentials for uploads when no static keys are set.
- Reuse the site's existing `s3fs` bucket, region, and credential configuration.
- Respect an s3fs root folder / public / private folder prefixes when building object keys.
- Deduplicate object keys (rename) when a file of the same name already exists on S3.
- Register browser-uploaded objects as Drupal managed file entities.
- Set an allowed extension list and max file size, enforced client-side before upload.
- Provide direct S3 upload inside inline entity / nested forms.
- Support multi-value file/image fields with direct upload.
- Keep an S3-backed media pipeline where editors upload originals straight to the bucket.
- Wildcard a CORS origin (e.g. `*.example.com`) for multi-subdomain sites.
- Remove the bucket's CORS config by clearing the origin field.
- Serve uploaded public files back through the s3fs stream wrapper.
