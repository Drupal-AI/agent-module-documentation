<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File Cache provides a `cache.backend.file_system` cache backend that stores Drupal cache bins as files on disk (or a RAM disk) instead of in the database, configured entirely through `settings.php`.

---

Enabling the module registers the `cache.backend.file_system` service (factory `FileSystemBackendFactory`, backend `FileSystemBackend`); it has no admin UI, permissions, config entities, or Drush commands. You opt bins into it in `settings.php` via `$settings['cache']['default']` or `$settings['cache']['bins'][<bin>]`, and you MUST tell it where to write files with `$settings['filecache']['directory']['default']` (and/or per-bin), using an absolute path or a stream wrapper such as `private://filecache`. For security the directory must live outside the webroot and be owner-only (0700); File Cache auto-creates per-bin subdirectories. Cache entries are serialized with core's `phpserialize` serializer by default; you can swap in a compressing serializer (e.g. `igbinary_gz`) by overriding the service's constructor argument. A per-bin "strategy" (`FileSystemBackend::STANDARD` vs `::PERSIST`) controls whether a general cache clear deletes the files — `PERSIST` keeps externally-sourced cached data across `drush cr`, at the cost of not fully conforming to the cache API. RAM-disk (tmpfs) storage is supported for speed. The status report includes File Cache self-checks. When running CLI cache commands, run them as the web-server user so file ownership stays correct.

---

- Move the `render`, `entity`, or `page` cache bin off the database onto the file system.
- Make File Cache the default backend for all bins with `$settings['cache']['default']`.
- Store selected cache bins on a tmpfs/RAM disk for faster reads.
- Keep cache files in a `private://` directory outside the webroot for security.
- Reduce database load and table size on high-traffic sites by offloading big cache bins.
- Cache data from slow external services and persist it across `drush cr` using the PERSIST strategy.
- Configure a different storage directory per cache bin.
- Compress cache files on disk by swapping in the `igbinary_gz` serializer.
- Use an absolute path (e.g. `/var/cache/filecache`) as the cache location.
- Avoid a Redis/Memcached dependency while still getting the DB out of the caching path.
- Share a cache directory strategy across a multisite by setting defaults in shared settings.
- Keep the `discovery` or `bootstrap` bins on disk for containers with ephemeral DB.
- Persist long-lived cached computations that should survive routine cache clears.
- Verify cache health through the Status report self-checks.
- Point a bin at a stream wrapper backed by fast SSD storage.
- Run CLI cache rebuilds as the web-server user to preserve correct file ownership.
- Cleanly remove File Cache by deleting its `$settings['filecache']` entries before uninstalling.
