<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — Google Trace

## Service `google_trace.helper` (`\Drupal\google_trace\TraceHelper`)
- `getTrace(): ?Trace` — returns a new `Trace` from the `TraceClient`, or NULL (logs critical) if the client failed to initialise.
- `insertTrace(Trace $trace): bool` — synchronously inserts into Cloud Trace; FALSE if the client is uninitialised.
- `queueTrace(Trace $trace): void` — enqueues `['trace' => $trace]` onto `google_trace_queue` for deferred delivery.

The `TraceClient` is built in the constructor and catches init exceptions (logged as critical) so a mis-configured environment degrades gracefully.

## Queue worker
Plugin id `google_trace_queue` (`\Drupal\google_trace\Plugin\QueueWorker\TraceQueue`) processes each item by calling `insertTrace()`; failures are caught and logged with the API error code/message. Run cron (or `drush queue:run google_trace_queue`) to flush.

## Credentials
`TraceClient` uses Google Application Default Credentials — set `GOOGLE_APPLICATION_CREDENTIALS` (or use workload identity on GCP). No key is stored in Drupal config.
