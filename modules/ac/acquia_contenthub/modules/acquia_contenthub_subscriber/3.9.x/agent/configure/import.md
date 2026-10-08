# Subscriber import & queue

## How import works
A validated webhook enqueues referenced entities to the import queue. Processing (cron or
Drush) pulls each CDF document, creates dependency stubs then real entities (resolved via
`depcalc`), saves them locally, and records each in the **subscriber tracker**
(`acquia_contenthub_subscriber.tracker`) with origin + auto-update status.

## Admin forms
- Import Queue — `\Drupal\acquia_contenthub_subscriber\Form\ContentHubImportQueueForm` at
  `/admin/config/services/acquia-contenthub/import-queue` (route
  `acquia_contenthub_subscriber.import_queue`, Content Hub UI access). Inspect / run the queue.
- Purge confirmation — `ContentHubPurgeQueueConfirmForm` at
  `/admin/config/services/acquia-contenthub/import-queue/purge-queue-confirm`
  (route `acquia_contenthub_subscriber.purge_queue_confirm`).

## What content arrives — interests & filters
Subscribers only receive content matching their **webhook interests** / **syndication
filters**. Manage via base-module Drush (`acquia:contenthub-filters`,
`acquia:contenthub-filters:attach|detach`, `acquia:contenthub-webhook-interests-*`) and
subscriber `acquia:contenthub-enqueue-by-filters`.

## Drush
- `acquia:contenthub-import-queue-run` — process the import queue now.
- `acquia:contenthub-enqueue-by-filters` — enqueue everything matching attached filters.
- `acquia:contenthub:enable-syndication` / `:disable-syndication` — global on/off.
- `acquia:contenthub:entity-scan:filter` — scan entities against a filter.
- `acquia:contenthub-import-local-cdf <file>` — import a CDF document from disk (testing).
- `acquia:contenthub-audit-subscriber` — reconcile tracker vs actual entities.
- `acquia:contenthub-subscriber-upgrade` — upgrade tracker data between versions.
- `acquia:contenthub-webhook-interests-purge` — clear stale interests.

## Programmatic
Import queue inspector: `acquia_contenthub_subscriber.import_queue_inspector`; requeue:
`acquia_contenthub_subscriber.requeuer`; tracking: `acquia_contenthub_subscriber.tracker`
(`isTracked($uuid)`, `getStatusByTypeId($type, $id)`).
