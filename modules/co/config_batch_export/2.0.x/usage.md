<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Configuration Batch Export adds an "Export in batch" button to Drupal's full configuration export page that builds the config tarball incrementally through the Batch API, so very large config sets export without hitting PHP time or HTTP proxy/CDN timeouts.

---

On a big site, core's single-request "Export all" can exceed PHP's max execution time or be cut off by a CDN/reverse-proxy response timeout while the whole `config.tar.gz` is assembled in one shot. Configuration Batch Export instead chunks the work: it lists every active config object (plus every config collection), then in batch operations of ten items each appends them as YAML into an uncompressed tar via `ArchiveTar::addString()`, and only gzips the finished tar at the very end — keeping memory low and progress steady. The finished archive is written to `private://configs.tar.gz` (never a public path), and the download route is gated by the core `export configuration` permission; a persistent lock prevents overlapping runs, and the file is marked stale so cron's file garbage collection removes it after download. It requires no configuration of its own — it only needs the private filesystem to be configured — and depends solely on core `config`, `file`, and `datetime`.

---

- Export a large site's full configuration without a PHP execution-timeout.
- Export config through a CDN or reverse proxy that caps response time (e.g. 30s).
- Generate `config.tar.gz` on a slow or memory-constrained VPS.
- Keep memory usage low while exporting thousands of config objects.
- Add a batch "Export in batch" button next to core's synchronous Export all.
- Download a full config archive from the browser without shell/Drush access.
- Include config from non-default config collections (e.g. language overrides) in the export.
- Store the generated archive in the private filesystem rather than the temporary directory.
- Have the export file auto-removed by cron file garbage collection after first download.
- Prevent two administrators from launching overlapping exports via the operation lock.
- Restrict who can trigger and download exports to holders of `export configuration`.
- Produce a plain `.tar` archive automatically when the PHP zlib extension is unavailable.
- Take a point-in-time snapshot of a site's active configuration for backup.
- Move configuration between environments when CLI `drush config:export` is not an option.
- Diff a downloaded archive against version-controlled config to audit drift.
- Hand a config snapshot to another developer for local review.
- Enable only when a large export is needed and disable it afterward.
- Pair with a private-file-path setup as a prerequisite for the download.
- Review the exported archive before committing, since config can hold sensitive data.
- Keep exported archives out of public or web-accessible directories.
- Test the batch export on staging before relying on it in production.
- Confirm the private filesystem is configured before enabling the module.
