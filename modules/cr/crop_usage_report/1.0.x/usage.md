<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Crop Usage Report is an admin reporting tool that lists the image **media** entities whose files are missing one or more of the site's manually-applied **crop types**, so editors can find and finish cropping work before publication.

---

The module scans image media and cross-references them against the [Crop API](https://www.drupal.org/project/crop) `crop` entities to find gaps. Its service `CropAuditService::runAudit()` queries every media entity in the audited bundles (only media types whose source is core's `Image` plugin qualify), loads each source file, keeps only files with a croppable raster MIME type (`avif`, `bmp`, `gif`, `jpeg`, `png`, `tiff`, `webp` — vectors like SVG/ICO are skipped so they aren't false positives), and then does one bulk `crop` lookup per batch keyed by file URI. Any audited crop type with no matching `crop` entity for that file's URI is reported as "missing." Results carry the media id, label, bundle, filename, URI, the list of missing crop types, and a link to the media edit form. The audit is driven by a config object `crop_usage_report.settings` with three keys: `crop_types` (empty = all crop types), `media_bundles` (empty = all image bundles), and `batch_size` (default 50, chunk size for `array_chunk` processing to bound memory). Results are cached permanently under cache tag `crop_usage_report`; the report page, the Drush command, and CSV export all serve the cached data, and a "Refresh report" action invalidates the tag. Surfaces: an admin report table at `/admin/reports/crop-usage` (paginated 50/page, with a truncated preview of missing types and an Edit button per row), a streamed CSV export at `/admin/reports/crop-usage/export`, a cache-refresh redirect at `/admin/reports/crop-usage/refresh`, a settings form at `/admin/config/media/crop-report`, and a `drush crop:audit` command with `--crop-types`, `--bundles`, and `--format` (table/csv/ids) options. Two permissions gate it: `view crop usage report` (report, export, refresh) and `administer crop usage report` (settings). Requires core Media and File plus the contrib Crop module, and is designed to complement [Image Widget Crop](https://www.drupal.org/project/image_widget_crop).

---

- Find every image media entity that still needs one or more crops applied before a launch or content freeze.
- Audit a large media library after adding a new crop type, to see which existing images lack it.
- Restrict the audit to a specific crop type (e.g. only `hero_banner`) via the settings form or `--crop-types`.
- Restrict the audit to specific image media bundles when only some bundles require cropping.
- Export the full list of images missing crops as a CSV spreadsheet for triage or handoff to editors.
- Give content editors a one-click Edit link that jumps straight to each media entity to apply the missing crops.
- Run the audit headlessly in CI or a cron job with `drush crop:audit` and act on the exit output.
- Pipe a plain list of media IDs to another command with `drush crop:audit --format=ids`.
- Produce a machine-readable CSV from the CLI with `drush crop:audit --format=csv > missing.csv`.
- Track cropping progress over time by re-running the report and refreshing its cache after crops are applied.
- Reduce database load on large sites by relying on the permanent result cache instead of re-querying every visit.
- Refresh stale results on demand with the "Refresh report" button after bulk crop edits.
- Lower `batch_size` on memory-constrained environments so the audit processes fewer media entities at a time.
- Avoid false positives from non-croppable formats (SVG, ICO) that Image Widget Crop can never crop.
- Give editors a paginated, sortable-at-a-glance overview under Administration → Reports.
- Delegate report viewing to editors while keeping audit configuration limited to administrators via separate permissions.
- Confirm a migration or bulk media import left images uncropped and needs a follow-up cropping pass.
- Quickly answer "which images still need cropping?" without hand-inspecting each media entity.
- Complement Image Widget Crop, which does not provide a usage/coverage report out of the box.
