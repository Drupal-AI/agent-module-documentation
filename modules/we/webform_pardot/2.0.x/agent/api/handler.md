<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Pardot — programmatic API

## Service `webform_pardot.pardot_handler` (`PardotHandler`)

Class `Drupal\webform_pardot\PardotHandler` implements `PardotHandlerInterface`. Constructor args:
`@http_client` (Guzzle), `@entity_type.manager`.

```php
$ok = \Drupal::service('webform_pardot.pardot_handler')
  ->submitDataToPardot($pardot_submission_id);
```

`submitDataToPardot($pardot_submission_id)`:
- Loads the `pardot_submission` entity (returns FALSE if missing) and its linked webform submission.
- Resolves `pardot_url` and `pardot_fields_mapping` by scanning the webform's handlers for the one whose
  plugin `provider === 'webform_pardot'`.
- Maps the submission data (`mapData()`), POSTs it, processes the response, updates and saves the
  `pardot_submission` entity, and returns it (or FALSE on early exit).

Status constants (`PardotHandlerInterface`): `PARDOT_QUEUED`, `PARDOT_PROCESSED`, `PARDOT_ERROR`.

## Enqueue a submission yourself

The normal path is automatic (the handler's `postSave()` enqueues to `pardot_submission_queue`). To
trigger processing, run cron, or process the queue worker directly:

```php
$queue = \Drupal::queue('pardot_submission_queue');
$queue->createItem(['pardot_submission_id' => $entity->id()]);
// on cron: PardotSubmissionQueue::processItem() calls submitDataToPardot().
```

## Mapping helpers

- `mapData($mapping, array $data)` — parses `webform_key|pardot_key` lines and renames keys; unmapped
  keys pass through. Second pass handles dotted/bracket paths into nested values.
- `combinedKeyAdd(array $data, array $flat_key_array, $mapped_key)` — resolves a `key.key1.key2` path
  (checkbox arrays handled) and writes the resolved value under `$mapped_key`.
