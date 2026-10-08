<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Flysystem Amazon S3 provides an `s3` adapter for the Flysystem module, letting Drupal store and serve files on Amazon S3 (or any S3-compatible service) via a stream wrapper, with optional direct browser-to-S3 CORS uploads.

---

The module registers a Flysystem `@Adapter(id = "s3")` plugin backed by the AWS SDK
(`aws/aws-sdk-php`) and `league/flysystem-aws-s3-v3`. You do not configure it through a Drupal
admin form — instead you declare one or more schemes in **`settings.php`** under
`$settings['flysystem']`, each with `driver: s3` and a `config` block giving `region`, `bucket`,
credentials (`key`/`secret`, or omit them to use an **IAM role**), and optional `prefix`,
`cname`, `endpoint` (for S3-compatible providers), `public`, `options` (e.g. `ACL`,
`StorageClass`) and `cors`. Flysystem then exposes that scheme as a stream wrapper (e.g.
`s3://`) you can set as the default or per-field file storage. The plugin builds the URL prefix
for public files (bucket URL or a custom CNAME) and can generate image styles on demand; IAM
credentials are cached through a Drupal cache backend (`AwsCacheAdapter`). The module decorates
core's `file_system` service (`FlysystemS3FileSystem`) so `chmod()` preserves private-file ACLs
on S3. Its second feature is **direct CORS upload**: when a scheme sets `cors: TRUE`, the user
holds the `use S3 CORS upload` permission, and a `managed_file` element targets that scheme, the
module attaches JS that uploads the file straight from the browser to S3 (signing the POST via
`/flysystem-s3/cors-upload-sign` and registering the resulting File entity via
`/flysystem-s3/cors-upload-save`), bypassing the PHP/web server for large files. There is no
config entity or config schema; everything lives in settings.php plus the one permission.

---

- Offload a site's public files to Amazon S3 to reduce local disk usage.
- Store private files in S3 while keeping Drupal access control.
- Serve user uploads from an S3 bucket via an `s3://` stream wrapper.
- Use IAM instance roles (no hardcoded keys) for S3 access on AWS-hosted sites.
- Point Drupal at an S3-compatible service (MinIO, DigitalOcean Spaces, Wasabi) via `endpoint`.
- Serve files through a custom CNAME/CDN domain that fronts the bucket.
- Prefix all uploaded objects with a directory inside the bucket (`prefix`).
- Generate and store image styles (derivatives) directly on S3.
- Set a default object ACL (e.g. `public-read`) or storage class (`REDUCED_REDUNDANCY`) via `options`.
- Enable direct browser-to-S3 uploads for large media, bypassing PHP upload limits.
- Grant only trusted roles the `use S3 CORS upload` permission for direct uploads.
- Configure bucket CORS rules from the shipped `s3-cors-example.json` template.
- Use multiple S3 schemes (e.g. one public, one private) in the same site.
- Migrate an existing site's files to S3 by pointing the scheme at the bucket.
- Cache AWS IAM credentials in Drupal's cache to reduce metadata-endpoint calls.
- Serve accelerated uploads/downloads via S3 Transfer Acceleration (`use_accelerate_endpoint`).
- Use path-style endpoints for providers that require them (`use_path_style_endpoint`).
- Keep private S3 files private by preserving restrictive ACLs through the decorated file system.
- Set the region as a region id (e.g. `eu-west-1`) as required by the AWS SDK.
- Provide a resilient fallback (MissingAdapter) that logs errors when the bucket is unreachable.
- Autodetect the request scheme (http/https) for generated file URLs.
- Reduce origin bandwidth by linking directly to public S3 objects (`public: TRUE`).
- Store backups or generated exports on S3 by targeting the scheme.
- Combine with the Flysystem module's tooling to manage and verify the S3 scheme.
