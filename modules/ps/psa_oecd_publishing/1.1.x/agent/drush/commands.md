<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OECD GlobalRecalls API — programmatic publishing

## HTTP client service
`oecd_api.recall` → `Drupal\psa_oecd_publishing\Api\OecdApi`:
- `ping(): array` — `['isSuccess' => bool, 'error' => string]`; validates key/connection.
- `post(string $filePath): bool` — POSTs a ZIP (`Content-Type: application/zip`) to
  `https://{host}/ws/import.xqy?apikey={key}`; TRUE on HTTP 200.
- `get(OecdApiRecall $recall): mixed` — GET a recall's JSON; NULL on 404.
- `getPostUrl()` / `getRecallUrl()` build the TLS URLs; `OECD_API_URL_RECALL_URI`
  (`http://PoliciesApplications.oecd.org/GlobalRecalls/Recall`) is only a path
  identifier, not a request target.

## Queue
`OecdPublisherQueueWorker` (`queue` worker) publishes queued recalls asynchronously —
drain via `drush queue:run` or cron.

## Drush
Commands are registered via `drush.services.yml` → `OecdPublishingCommands`
(`src/Commands/OecdPublishingCommands.php`) for headless/cron publishing runs.
Inspect available commands with `drush list | grep oecd`.

All entry points require the `administer`/`use psa_oecd_publishing` permission on the
web side; Drush runs with full CLI privileges.
