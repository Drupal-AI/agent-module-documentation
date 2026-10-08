# Configuration

Migrate retry's configuration is deliberately simple: it is where you tell the
module **which migrations should use the retry system**. Everything else — how
rows are marked as needing a retry, and the enqueuing — is handled in code (see
[How it works](../index.md#how-it-works)).

## Before you start

Make sure you have completed both installation steps first: the module is
enabled, and you have added the required line to `settings.php`:

```php
$settings['queue_service_migrate_retry'] = 'queue.migrate_retry';
```

See [Installation](../installation/index.md) if you haven't done this yet.

## Open the settings form

1. Log in as a user with permission to administer the module's settings (an
   administrator by default).
2. Navigate to the Migrate retry settings form (config route
   `migrate_retry.settings`).

## Choose which migrations retry

The form presents your available migrations. **Check each migration** you want to
participate in the retry system. Only the migrations you enable here will have
their failed‑but‑retryable rows re‑queued; migrations you leave unchecked behave
exactly as they do without the module.

This is the main decision to make: enable retry for migrations that pull from or
push to unreliable or external systems (where transient failures are expected),
and leave it off for migrations against local, reliable sources where a failure
almost always means a real data problem you'd rather see immediately.

## Save

Save the form. From then on, rows in the enabled migrations that are marked with
the "needs retry" status will be enqueued by cron and re‑migrated by the queue
worker, up to the built‑in maximum of five attempts per row.
