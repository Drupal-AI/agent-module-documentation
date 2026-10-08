Purge File automatically invalidates the URLs/paths of file entities in an external cache (Varnish, CloudFront, Acquia, or any CDN) through the Purge module whenever a file is inserted, updated, or deleted.

---

The module hooks into file entity lifecycle events (`hook_file_insert`, `hook_file_update`, `hook_file_delete`) and, when a file changes, hands its URL(s) to Purge for invalidation. It is only useful when your site replaces file contents while keeping the same URL and serves those files through an external/anonymous cache. Purge File requires the Purge module plus at least one enabled purger that supports one of the URL-oriented invalidation types (`url`, `wildcardurl`, `path`, `wildcardpath`), and at least one purge processor. On update it only purges when the file's URI or size actually changed, and it purges the original URL too when it differs. Invalidations can be executed immediately (via the module's own immediate processor) or added to the Purge queue (via the module's queuer) to be processed later, e.g. on cron. A single settings form controls the workflow, the invalidation type, optional comma-separated base URLs (for split front/back-office domains), and a debug logging toggle. Temporary-stream files are skipped, and a `hook_requirements` check warns on the status report if no URL-capable purger is enabled. A `hook_purge_file_base_urls_alter` hook lets other modules add or change the base URLs that get purged per file.

---

- Invalidate a file's URL in Varnish automatically when an editor replaces the file but keeps the same filename/URL.
- Purge CloudFront (or any CDN) cache entries for updated media so anonymous visitors see the new file.
- Clear Acquia Purge external caches for files on change without writing custom code.
- Bust cache for a logo or PDF that is overwritten in place during a rebrand.
- Purge both the old and new file URL when a file's URI changes on update.
- Remove a deleted file's URL from the external cache so it stops being served from the edge.
- Queue file invalidations in bulk and process them later on cron via `purge_processor_cron`.
- Process file invalidations immediately at the moment of the file change for time-sensitive updates.
- Use wildcard invalidation (`wildcardurl`/`wildcardpath`) to purge all query-string variants (e.g. tracking codes) of a file URL.
- Use path-based invalidation instead of full URLs when your purger works on paths.
- Purge files across multiple front-end domains by listing several base URLs in the settings form.
- Handle a decoupled/split architecture where the back-office URL differs from the public front URL.
- Let another module inject extra domains to purge per file via `hook_purge_file_base_urls_alter`.
- Enable debug logging to record every file purge and the exact URLs sent to Purge while troubleshooting.
- Verify (via the status report) that at least one URL-capable purger is configured for file purging.
- Avoid serving stale images from a CDN after an image field's underlying file is swapped.
- Keep downloadable documents (PDFs, spreadsheets) fresh at the edge when re-uploaded with the same name.
- Integrate file cache invalidation into an existing Purge pipeline without touching your purger configuration.
- Skip purging temporary-stream files so only real, published files trigger invalidations.
- Trigger CDN invalidation on media library file replacements.
- Combine immediate file purging with cron-based bulk tag purging from other Purge queuers.
- Purge only when a file genuinely changed (URI or size), avoiding redundant invalidations on no-op saves.
- Configure per-site invalidation strategy (immediate vs queue) to balance edge freshness against purger load.
- Roll out edge cache invalidation for user-uploaded files on a high-traffic, mostly-anonymous site.
- Support Wildcard Path purgers that only accept relative paths for invalidation.
