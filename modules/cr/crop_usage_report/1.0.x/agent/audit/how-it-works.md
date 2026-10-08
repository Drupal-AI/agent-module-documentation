<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The crop audit: service, config, caching, and the report UI

## Install & enable

```bash
composer require drupal/crop_usage_report
drush en crop_usage_report -y
```

Requires core `media` + `file` and contrib `crop`. `composer.json` requires `drupal/crop:*`
and `php >=8.3`. To actually apply crops you also want
[Image Widget Crop](https://www.drupal.org/project/image_widget_crop) configured on your image
media, but it is not a code dependency.

## Configuration — `crop_usage_report.settings`

Settings form `CropAuditSettingsForm` at `/admin/config/media/crop-report` (permission
`administer crop usage report`, marked `restrict access: true`). Config object
`crop_usage_report.settings` (schema `config/schema/crop_usage_report.schema.yml`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `crop_types` | sequence of string | `[]` | Crop type machine names to audit. **Empty = audit every crop type.** |
| `media_bundles` | sequence of string | `[]` | Image media bundle machine names to audit. **Empty = audit every image bundle.** |
| `batch_size` | integer | `50` | Media entities processed per `array_chunk` batch. Form clamps `#min` 10 / `#max` 500. |

The form builds crop-type checkboxes from all `crop_type` entities, and bundle checkboxes only
from media types whose `getSource() instanceof \Drupal\media\Plugin\media\Source\Image`.
`submitForm()` runs `array_filter()` over the checkbox values before saving (so only checked
boxes persist).

Config-export example:

```yaml
# crop_usage_report.settings
crop_types:
  - hero_banner
  - focal_point
media_bundles:
  - image
batch_size: 100
```

## How the audit runs — `CropAuditService` (`src/CropAuditService.php`)

`runAudit(array $crop_type_ids = [], array $bundles = [])`:

1. Empty args fall back to `getAuditCropTypes()` / `getImageMediaBundles()` (which apply the
   config filters). If either resolves to empty, returns `[]`.
2. Builds a cache id `crop_usage_report:results:` + `md5(types|bundles)`. On a cache hit,
   returns `$cached->data` immediately.
3. `media` entity query filters `bundle IN $bundles` with `accessCheck(FALSE)` (an admin audit
   that counts all matching media regardless of the query builder's grants).
4. `array_chunk` over the media ids by `batch_size`. For each batch it loads the media, reads
   the source field (`getSource()->getConfiguration()['source_field']`), skips empty fields and
   any file whose MIME is not in `CROPPABLE_MIME_TYPES`
   (`avif, bmp, gif, jpeg, png, tiff, webp` — vectors excluded to avoid false positives), and
   maps file URI → `{mid, name, bundle, filename, edit_url}`.
5. One bulk `crop` `loadByProperties(['uri' => array_keys($uri_to_data)])` per batch builds
   `applied_by_uri[uri][] = crop bundle`. `array_diff($crop_type_ids, applied[uri])` yields the
   missing types; non-empty rows are appended with `uri` and `missing_types`.
6. Results are stored with `CACHE_PERMANENT` under tag `['crop_usage_report']` and returned.

`invalidateCache()` calls `Cache::invalidateTags(['crop_usage_report'])`.
`NO_ISSUES_MESSAGE` = `'Everything is cropped. No images are missing crops.'`.

## The report UI — `CropAuditReportController`

- **`report()`** (route `crop_usage_report.report`, `/admin/reports/crop-usage`): runs the
  audit; if empty renders the no-issues message. Otherwise paginates with
  `pager.manager->createPager($total, 50)` (50/page), a summary line naming the audited types
  and linking to the settings page, an **Export CSV** and a **Refresh report** action button,
  and a `#type => table` with `table-layout: fixed`. The "Missing crop types" cell shows a
  truncated preview (`formatMissingCrops()` → first two names, `(+N more)`, `[T total]`) with the
  full list in the `title` attribute. Each row has an **Edit** link (`button--extrasmall`) to
  `entity.media.edit_form`. Cell values (name, bundle, filename) are placed in table `data` keys
  and thus escaped by the table theme.
- **`export()`** (route `crop_usage_report.export`, `/admin/reports/crop-usage/export`): a
  `StreamedResponse` writing `fputcsv` rows (`Media ID, Name, Bundle, Filename,
  Missing Crop Types, Edit URL`); `Content-Type: text/csv`, attachment
  `crop-usage-report.csv`.
- **`refresh()`** (route `crop_usage_report.refresh`, `/admin/reports/crop-usage/refresh`):
  calls `invalidateCache()`, adds a status message, and redirects back to the report. (A plain
  GET that clears only this report's cache tag; gated by `view crop usage report`.)

## Permissions (`crop_usage_report.permissions.yml`)

| Permission | Grants |
|---|---|
| `view crop usage report` | Report page, CSV export, cache refresh. |
| `administer crop usage report` | Settings form (`restrict access: true`). |

## Operating notes

- Results are cached **permanently** — after applying crops, hit **Refresh report** (or run the
  Drush refresh path / `drush cache:rebuild`) to regenerate. All three read surfaces (page,
  export, Drush) share the same per-`types|bundles` cache entry.
- Only media types with a core **Image** source are audited; other media (video, audio, remote)
  are ignored.
- Lower `batch_size` if the audit exhausts memory on very large libraries; raise it (up to 500)
  to reduce query round-trips.
