<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# S3FS File Proxy to S3 (s3fs_file_proxy_to_s3) — agent index

**Rewires stage_file_proxy so a staging site fetches missing public files from the production S3 bucket and stores them in the staging S3 bucket instead of the local filesystem.**

- **Version:** 4.0.x
- **Core:** ^9.3 || ^10 || ^11
- **Depends on:** `s3fs`, `stage_file_proxy`
- **Activation:** only when `Settings::get('s3fs.use_s3_for_public')` is true (see `S3fsFileProxyToS3ServiceProvider`)
- **Overrides:** `stream_wrapper.public` → `PublicS3fsFileProxyToS3Stream`; `stage_file_proxy.fetch_manager` → `S3fsFileProxyToS3FetchManager`; `stage_file_proxy.subscriber` → `S3fsFileProxyToS3Subscriber`
- **Route:** repaths `s3fs.image_styles` to `/s3fs_to_s3/files/styles/{image_style}/{scheme}`
- **Security:** the fetch origin is the stage_file_proxy-configured production URL (not request-supplied), so there is no arbitrary-URL SSRF vector; requested paths are confined to the `public://` scheme; S3 credentials come from the s3fs module (settings.php) and are not logged. Note the subscriber issues a raw `header('Location: …'); exit;` redirect for already-present files, bypassing the Drupal response pipeline.

See [configure/setup.md](configure/setup.md) for enabling and settings.php configuration.