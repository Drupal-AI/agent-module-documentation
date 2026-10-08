<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# S3 File System (s3fs) — agent index

`s3://` stream wrapper over Amazon S3 / S3-compatible storage, with optional takeover of Drupal's
`public://` and `private://` schemes. No module dependencies; requires `aws/aws-sdk-php ^3.18`.
Admin UI `/admin/config/media/s3fs` (`configure` → `s3fs.admin_settings`, permission
`administer s3fs`, `restrict access: TRUE`).

- **Settings, the settings.php takeover switches, credentials, buckets/folders** →
  [configure/setup.md](configure/setup.md)
- **Drush commands (`s3fs:refresh-cache`, `s3fs:copy-local`) and the metadata cache** →
  [drush/commands.md](drush/commands.md)
- **Services, stream wrappers, image-style routing, decorated `file_system`** →
  [api/architecture.md](api/architecture.md)
- **The five alter hooks for AWS parameters** → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- **Core version constraint is unusually narrow**:
  `>=8.8 < 10.7 || >=11.0 < 11.2 || >=11.2.3 < 11.4.0 || >=11.4.3 < 11.5`. Drupal 11.4.0–11.4.2
  and 10.7+ are deliberately excluded — check the constraint before upgrading core, this module
  will block the update.
- **Takeover is a `settings.php` decision, not config**:
  `$settings['s3fs.use_s3_for_public'] = TRUE;` / `['s3fs.use_s3_for_private'] = TRUE;`.
  `S3fsServiceProvider` swaps `stream_wrapper.public` / `stream_wrapper.private` at container
  build; `hook_requirements()` reports the takeover state on the status report.
- Services: `stream_wrapper.s3` (scheme `s3`), `s3fs` (`S3fsService` — client factory + cache),
  `s3fs.file_migration_batch`, `s3fs.refresh_cache_batch`, `s3fs.path_processor.image_styles`
  (inbound path processor, priority 310), `s3fs.route_subscriber_core_image_style`,
  `logger.channel.s3fs`, and **`s3fsfileservice` which decorates core `file_system`**
  (`decoration_priority: 5`).
- **Credential order** (`S3fsService::getAmazonS3Client()`): `Settings::get('s3fs.access_key')` /
  `('s3fs.secret_key')` → Key entities named in `s3fs.settings:keymodule.access_key_name` /
  `.secret_key_name` (only when the `key` module is enabled) → the AWS SDK default chain
  (instance profile, env vars, shared config files, unless `disable_shared_config_files`).
- Config `s3fs.settings` (schema shipped) covers bucket/region/folders, `use_cname` +
  `domain`/`domain_root`, `use_customhost` + `hostname`, `use_path_style_endpoint`, `use_https`,
  `encryption`, `cache_control_header`, `presigned_urls`, `saveas`, `torrents`,
  `redirect_styles_ttl`, `read_only`, `ignore_cache`, `disable_version_sync`,
  `disable_cert_verify`, `use_cssjs_host` + `cssjs_host`, credential caching, and `keymodule`.
- Extra `settings.php` switches beyond the takeovers: `s3fs.upload_as_private`,
  `s3fs.access_key`, `s3fs.secret_key`.
- Metadata cache: S3 has no cheap stat, so object metadata lives in a database table refreshed by
  `drush s3fs:refresh-cache`. `ignore_cache` bypasses it (slow, for debugging).
- Five alter hooks in `s3fs.api.php`; D7 migrations in `migrations/` (`d7_s3fs_config`,
  `d7_s3fs_public_migrate`, `d7_s3fs_private_migrate`, `d7_s3fs_s3_migrate`).
