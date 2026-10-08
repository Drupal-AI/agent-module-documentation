Digital Asset Inventory scans a Drupal site for all digital assets (managed files, media, orphaned files, and external/embedded links), maps where each is used, resolves human-readable titles, evaluates alt-text/caption accessibility signals, and provides exportable reports plus an ADA Title II–oriented archiving workflow.

---

The module discovers assets across content, menus, and configuration via a batchable `DigitalAssetScanner` service (Drush `dai:scan` or the Scan form), recording each as a `digital_asset_item` with its usages, orphan references, and detected type (documents, images, A/V, plus dozens of external providers matched by URL pattern — Google Workspace, YouTube/Vimeo, SharePoint, Qualtrics, etc.). A `TitleResolverService` resolves display titles from media names, link/anchor text, and image alt text, and for external URLs performs guarded HTTP/oEmbed fetches (cron or the Resolve Titles form) to read remote `<title>`s. Results are browsable through Views-based inventory, usage, and dashboard pages (Chart.js dashboard with accessible fallbacks), filterable with Better Exposed Filters, and exportable to CSV via views_data_export/csv_serialization. An optional Archival Management System (disabled by default: `enable_archive`, `enable_manual_archive`) adds `digital_asset_archive` / `digital_asset_archive_note` entities, an attestation workflow, a public `/archive-registry/{archive}` reference page, and per-status visibility (public/admin/queued/deleted) enforced in the archive detail controller. The module defines seven permissions (view/scan/delete/archive/administer, plus archive-view and orphan-reference), custom access checks that also honor feature-flag config (`_dai_archive_enabled`, `_dai_manual_archive_enabled`, `_dai_archive_view_access`), Views field/filter/area plugins, a queue worker for external title resolution, Drush `dai:scan`/`dai:status`, and a hook to override title resolution. Settings live at `/admin/config/accessibility/digital-asset-inventory` (scanner, archive, registry sub-forms). External title fetches are SSRF-guarded (private/reserved IPs rejected, redirects re-validated).

---

- Inventory every file and media item on a site in one scan.
- Find orphaned files no longer referenced by any content.
- Identify unused or missing assets to plan cleanup and remediation.
- Map exactly where a given file/image is used across nodes, blocks, menus, and config.
- Track external/embedded assets (Google Docs, YouTube, Vimeo, SharePoint, Qualtrics, etc.) by URL pattern.
- Resolve friendly display titles for assets from media names, anchor text, and image alt text.
- Fetch remote page titles for external links via cron or an on-demand batch form.
- Evaluate per-usage alt text status (detected / not detected / decorative / not applicable).
- Detect audio/video accessibility signals (controls, captions, subtitles).
- Export a filtered inventory report to CSV for remediation planning.
- View an at-a-glance dashboard of inventory health with charts and accessible table fallbacks.
- Run scheduled/scripted scans from the CLI with `drush dai:scan` (and `--force` to clear stuck locks).
- Check inventory status for monitoring with `drush dai:status --format=json`.
- Delete unused assets individually with a dedicated permission.
- Support ADA Title II archiving of pre-deadline (legacy) content.
- Queue assets for archiving and execute an archive with an attestation of the content date.
- Maintain a public archive registry page describing retained/archived materials.
- Control archive visibility per item (public vs. admin-only disclosure) without moving files.
- Add internal notes to archive entries for audit context.
- Manually add archive entries for assets not auto-discovered.
- Restrict scanning, deletion, and archiving to specific roles via granular permissions.
- Exclude directories or filenames from scans via scanner settings.
- Give a dedicated "Digital Asset Manager" role read/manage access via the shipped optional role.
- Audit scan and archive actions through dblog entries with session IDs.
- Tune scan batch time budget and stale-lock thresholds for large sites.
- Override title resolution with institution-specific APIs via `hook_digital_asset_inventory_title_resolve_alter()`.
- Produce accessibility-focused reports for compliance reviews.
