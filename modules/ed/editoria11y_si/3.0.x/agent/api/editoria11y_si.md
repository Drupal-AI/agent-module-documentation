<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Editoria11y si (SiteImprove) — API & data model

## Importer service
`editoria11y_si.importer` → `Drupal\editoria11y_si\Editoria11ySiImporter`. Constructor args: `logger.factory`, `config.factory`, `database`, `messenger`, `entity_type.manager`, `state`, `key.repository`, `queue`.

Public methods (each: reads the Key + `domain` config, skips with an error message if its check is disabled, pages the SiteImprove v2 API 100 items at a time, strips `domain` from URLs, deletes stored rows no longer in the API, clears prior queue items of that type, then queues one item per page):
- `generateImportQueueItemsForBrokenLinks()` — endpoint `.../quality_assurance/links/pages_with_broken_links`
- `generateImportQueueItemsForMisspellings()` — endpoint `.../quality_assurance/spelling/misspellings`
- `generateImportQueueItemsForReadingScores()` — endpoint `.../quality_assurance/readability/tests/flesch_kincaid_grade_level/pages`

API calls use `curl` with HTTP basic auth (`CURLOPT_USERPWD = username:api_key`) and `Accept: application/json`. Optional `group` becomes `&group_id=`.

## Procedural helper
`editoria11y_si_queue_cronjob()` (in `.module`): calls all three importer methods, then claims & processes every item in the `editoria11y_si_import_processor` queue, deleting on success and releasing + logging on `SuspendQueueException`/`\Exception`. Records `state` `editoria11y_si_broken_links.import.last_update` when the queue is empty.

## Queue worker
Plugin `editoria11y_si_import_processor` (`@QueueWorker`, cron time/lease 60s) → `Editoria11ySiImportCronEventProcessor::processItem($page)`. Builds field values, computes `Crypt::hashBase64` content hash, looks up an existing `editoria11y_si` entity by (`url`, `siteimprove_type`); updates it only if the hash differs, else creates a new one. Updates the per-type `state` last-update timestamp when one item remains. (Injects Purge services — see the dependency gotcha in configure doc.)

## Content entity `editoria11y_si`
`Drupal\editoria11y_si\Entity\Editoria11ySi` (`@ContentEntityType`, base table `editoria11y_si`, admin_permission `administer editoria11y_si`, views_data handler). Base fields:
- `url` (string) — page path from SiteImprove (domain stripped)
- `siteimprove_url` (string) — link to the SiteImprove page report
- `content_hash` (string) — hash for change detection
- `siteimprove_type` (string) — `broken_links` | `misspellings` | `reading_score`
- `raw_data` (string_long) — JSON payload for that page/type
- plus `status`, `created`, `changed`

Interface `Editoria11ySiInterface` extends `ContentEntityInterface`, `EntityChangedInterface`.

## Display path (frontend)
- `hook_preprocess_node` (full view mode, requires `view editoria11y checker`): queries stored entities for the node's path per type, builds an `a[href$="…"]` selector string for broken links, collects misspelling JSON and the reading score, and attaches them under `drupalSettings.editoria11y.editoria11y_si`.
- `hook_page_attachments`: attaches library `editoria11y_si/editoria11y-custom-tests` (JS depending on `editoria11y/editoria11y-library`).
- The JS registers Editoria11y custom tests `ed11ySiBrokenLinks`, `ed11ySiMisspellings`, `ed11ySiReadingScore` on the `ed11yRunCustomTests` event and dispatches `ed11yResume` when done.
- `hook_views_query_alter` on view `editoria11y_si_reading_score` casts `raw_data` to `DECIMAL(10,2)` so reading scores sort numerically.
