<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
S3 File System adds an `s3://` stream wrapper backed by Amazon S3 (or any S3-compatible service) and can take over Drupal's public and/or private file systems entirely, so uploads land in a bucket and are served from S3 or a CDN instead of the web server's disk.

---

At its core the module registers a `stream_wrapper` service for the `s3` scheme built on `aws/aws-sdk-php`, plus two variants (`PublicS3fsStream`, `PrivateS3fsStream`) that are swapped in for core's `public`/`private` wrappers when `$settings['s3fs.use_s3_for_public']` / `['s3fs.use_s3_for_private']` are enabled in `settings.php` — the takeover is a settings decision, not a config one, and `S3fsServiceProvider` performs the substitution at container build. Because S3 has no cheap `stat()`, the module keeps a **metadata cache** of every object in a database table, refreshed by `drush s3fs:refresh-cache` (alias `s3fs-rc`) or the actions form; `drush s3fs:copy-local` moves existing local files into the bucket. Credentials resolve in a fixed order: `$settings['s3fs.access_key']`/`['s3fs.secret_key']` first, then Key module entities named in `s3fs.settings:keymodule`, then the AWS SDK's own chain (instance profile / env / shared config), so an EC2/ECS role needs no keys at all. `s3fs.settings` carries the rest: bucket, region, root/public/private folders, HTTPS, custom hostname or CNAME (for CloudFront and S3-compatible providers), path-style endpoints, server-side `encryption`, `cache_control_header`, and per-path lists for **presigned URLs**, forced **save-as** downloads and torrents. Image styles get special handling — a route subscriber and path processor rewrite core's image-style download routes so derivatives are generated once and then served from S3 (optionally as a redirect with a configurable TTL), and a decorated `file_system` service plus a MIME-type guesser compiler pass keep core APIs working against remote files. Five alter hooks (`hook_s3fs_url_settings_alter`, `_stream_open_params_alter`, `_upload_params_alter`, `_copy_params_alter`, `_command_params_alter`) let modules adjust the AWS parameters for every request, and D7 migrations are provided for config and file entities.

---

- Store all user uploads in an S3 bucket instead of the web server disk.
- Serve public files through CloudFront with a CNAME.
- Run Drupal on autoscaling/ephemeral containers with no shared filesystem.
- Keep private files in S3 while still enforcing Drupal's access checks.
- Point the site at a non-AWS S3-compatible service (MinIO, Ceph, DigitalOcean Spaces).
- Use an EC2/ECS instance role so no AWS keys exist in the codebase.
- Store AWS keys as Key entities rather than in `settings.php`.
- Enable server-side encryption on every object written.
- Set `Cache-Control` headers on uploaded objects for CDN efficiency.
- Force certain paths to download rather than display via save-as rules.
- Serve sensitive assets through time-limited presigned URLs.
- Generate image style derivatives once and serve them from S3 afterwards.
- Redirect image-style requests to S3 with a configurable TTL.
- Migrate an existing local `public://` tree into a bucket with one Drush command.
- Refresh the file metadata cache after files change outside Drupal.
- Use a root folder to share one bucket between several sites.
- Separate public and private prefixes inside the same bucket.
- Use path-style endpoints for providers that do not support virtual-host style.
- Disable certificate verification when testing against a local S3 emulator.
- Keep CSS/JS aggregates on a separate host from the rest of the files.
- Migrate a Drupal 7 s3fs site's configuration and files.
- Alter upload parameters (ACL, storage class, tags) from a custom module.
- Run read-only against a bucket populated by another system.
- Survive a rebuild of the web tier without losing uploaded media.
