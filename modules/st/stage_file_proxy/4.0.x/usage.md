Stage File Proxy fetches missing files on demand from a production/origin server, so a development or staging site never needs a full copy of the files directory. It saves time and disk space by proxying requests for absent files to the origin and caching a local copy.

---

Stage File Proxy watches incoming requests to the public files directory (via a `KernelEvents::REQUEST` subscriber at priority 240). When a requested file is missing locally, it downloads that file from the configured `origin` website and either saves a local copy (default) or, in **hotlink** mode, serves a `301` redirect straight to the origin so nothing is stored locally. It understands image styles: when `use_imagecache_root` is on it requests the original image from the origin and lets Drupal's image module regenerate the derivative, speeding up later requests for other styles of the same original. The origin URL, SSL `verify`, remote files path (`origin_dir`, for multisite), excluded extensions, and extra proxy HTTP headers are all configurable — either through the settings form at `/admin/config/system/stage_file_proxy` or, preferably, in `settings.php`/`settings.local.php` as `$config['stage_file_proxy.settings'][...]`. A Drush command (`stage_file_proxy:dl`, alias `sfdl`) bulk-downloads every managed file from the origin to warm the local files directory. The module depends only on core `image`, gates its settings form behind the `administer stage_file_proxy settings` permission, and is explicitly intended for non-production sites only — it should not be enabled on production.

---

- Run a dev site against production images/files without copying the whole files directory.
- Save local disk space by fetching only the files you actually view.
- Point a staging environment at the live site's `origin` and let assets stream in on demand.
- Serve missing files as `301` redirects to production (hotlink mode) so nothing is stored locally.
- Cache a local copy of each requested production file for faster repeat access.
- Fetch the original image and let Drupal regenerate image-style derivatives locally (`use_imagecache_root`).
- Speed up later requests for other styles of the same image by caching the original once.
- Configure the origin website URL entirely in `settings.php` for code-managed, environment-specific setup.
- Embed HTTP Basic Auth credentials in the origin URL to proxy from a password-protected site.
- Disable SSL verification (`verify`) when proxying from an origin with a self-signed certificate.
- Point at a different remote files path via `origin_dir` for multisite installations.
- Exclude large or licensed file types (e.g. `mp3,ogg`) from being fetched with `excluded_extensions`.
- Send custom proxy request headers (e.g. a `Referer`) to satisfy origin hotlink protection.
- Bulk pre-download all managed files with `drush stage_file_proxy:dl` to warm the cache.
- Download just one file by id with `drush sfdl --fid=123`.
- Run the warm-up download without a progress bar in CI via `--skip-progress-bar`.
- Automatically enable the module on a dev alias right after a `drush sql-sync`.
- Keep the settings out of production config sync using Config Split (dev-only module).
- Exclude arbitrary request paths from proxying via the `stage_file_proxy.alter_excluded_paths` event.
- Avoid manually rsync-ing gigabytes of user uploads to every developer's machine.
- Reproduce a production-only display bug locally by pulling the exact live assets on demand.
- Let the image module handle mime type and derivative generation after a proxied fetch.
- Preserve query parameters through the proxied request to the origin.
- Restrict who can change proxy settings with the `administer stage_file_proxy settings` permission.
