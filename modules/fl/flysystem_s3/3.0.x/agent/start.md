<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Flysystem Amazon S3 — agent index

Adds a Flysystem `s3` adapter so Drupal can store/serve files on Amazon S3 (or S3-compatible
services), plus optional direct browser→S3 CORS uploads. Configured in **settings.php**, not a
Drupal admin form. Requires the `flysystem` module + AWS SDK. No config entity, no config schema,
no Drush.

- **Define an S3 scheme in settings.php (all config keys, IAM vs key/secret, region ids)** →
  [configure/scheme.md](configure/scheme.md)
- **Direct browser-to-S3 CORS upload (permission, `cors` flag, routes, element props, JS)** →
  [configure/cors-upload.md](configure/cors-upload.md)
- **Permission `use S3 CORS upload`** → [permissions/permissions.md](permissions/permissions.md)
- **Architecture (plugin, adapter, file_system decorator, credential cache, element alter)** →
  [api/architecture.md](api/architecture.md)

Key facts:
- Flysystem plugin id **`s3`** (`@Adapter(id = "s3")`), class `Flysystem\S3`. Schemes declared
  under `$settings['flysystem']` with `driver: s3` and a `config` array.
- Credentials: provide `key` + `secret`, or omit both to use an AWS **IAM role** (cached via
  `AwsCacheAdapter` in `cache.default`).
- CORS upload needs: scheme `config.cors: TRUE` + bucket CORS rules + permission
  `use S3 CORS upload`; POST routes `/flysystem-s3/cors-upload-sign` and
  `/flysystem-s3/cors-upload-save`; JS library `flysystem_s3/drupal.s3_cors_upload`.
- Decorates core `file_system` service (`FlysystemS3FileSystem`) to preserve private ACLs.
