<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Flysystem exposes third-party filesystem backends (local, FTP, and contrib adapters like S3/SFTP/GCS) to Drupal as ordinary stream wrappers, so files can live on a remote store while code keeps using `scheme://path` URIs.

---

Flysystem bridges the PHP League **Flysystem** library into Drupal's stream-wrapper system. Each backend is a **scheme** you declare in `settings.php` under `$settings['flysystem']`, keyed by the stream-wrapper name (e.g. `myfiles`), with a `driver` (the Flysystem adapter plugin id) and a `config` array passed to that adapter. On rebuild/cron the `flysystem_factory` service reads those settings, validates each scheme, registers a `FlysystemBridge` stream wrapper for it, and writes a protective `.htaccess` for local roots. Adapters are Drupal plugins discovered via the `plugin.manager.flysystem` manager using the `@Adapter` annotation; core ships `local` and `ftp` (plus internal `missing`/DrupalCache adapters), and contrib modules add `s3v2`, `sftp`, `dropbox`, `gcs`, etc. A scheme marked `'public' => TRUE` gets file-serving and image-style routes registered so browsers can reach its files; non-public schemes are proxied through Drupal's file-download controller (`/_flysystem/{scheme}/{filepath}`). Beyond declaration, the module adds a **Sync** form at `/admin/config/media/file-system/flysystem` (route `flysystem.config`) to copy every file from one scheme to another, and a **Field migration** form to move existing file/image field uploads onto a Flysystem scheme. The single permission `administer flysystem` gates those forms. There is no exported Drupal config and no `configure` route in `.info.yml` — configuration is entirely `settings.php`. The status report (`/admin/reports/status`) runs each scheme's `ensure()` check.

---

- Store uploaded files on a remote backend (S3, SFTP, GCS…) while Drupal keeps using `scheme://` URIs.
- Define a `local` Flysystem scheme rooted at a directory outside the webroot for private-style storage.
- Point Drupal's default file storage at a Flysystem scheme so all new uploads go there.
- Add an FTP-backed stream wrapper via the built-in `ftp` driver.
- Serve files from a public Flysystem scheme at browser-accessible URLs.
- Proxy non-public scheme files through Drupal access control at `/_flysystem/{scheme}/{filepath}`.
- Replicate every write to a backup endpoint using the `replicate` config option.
- One-off synchronize all files from one scheme to another via the Sync form.
- Migrate an existing site's file/image field uploads onto a remote scheme with the Field migration form.
- Swap a filesystem backend without changing code, reducing vendor lock-in.
- Cache remote filesystem metadata by wrapping an adapter with the Drupal cache adapter.
- Register image-style derivative routes for a public local Flysystem scheme.
- Write a custom Flysystem adapter plugin (`@Adapter`) to integrate a new backend.
- Gate the sync / field-migration admin forms with the `administer flysystem` permission.
- Validate scheme names (letters, numbers, `+ . -` only, no underscores) at install time.
- Diagnose backend connectivity from the Status report, which runs each scheme's `ensure()`.
- Give a scheme a friendly display `name` and `description` shown in the file-system UI.
- Keep CSS/JS on a remote store by overriding core's `assets://` wrapper to a Flysystem backend.
- Add a `.htaccess` guard automatically to local roots to block arbitrary code execution.
- Use a scheme as a Drupal cache-backed filesystem via the bundled Drupal cache adapter.
- Provide per-scheme public/private behavior through the `config.public` flag.
- Consume a scheme from code with the standard file API (`file_save_data('data', 'myfiles://x.txt')`).
- List all registered schemes programmatically via `flysystem_factory`.
