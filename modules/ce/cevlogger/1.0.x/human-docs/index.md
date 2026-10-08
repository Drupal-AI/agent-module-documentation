# Custom Event Logger — manual setup guide

**Custom Event Logger** (`cevlogger`) is a lightweight, developer-controlled
logging system that is completely separate from Drupal's core logging. Instead of
capturing every watchdog event the way Database Logging (dblog) does, it writes
**only the messages your own code explicitly sends** to a dedicated database table
(`cevlogger_logs`), which you review in a simple paginated admin report. That makes
it well suited to production sites where dblog is switched off for performance or
policy reasons but you still need targeted visibility into specific events —
failed API responses, third-party integration problems, custom validation errors,
or business-critical workflows.

Each entry records a **source module name**, a **log type** (`error`, `warning`,
`info`, and so on), the **message body**, and a Unix **timestamp**, with database
indexes on module name, timestamp, and type for fast lookups. Because nothing is
logged automatically, there's no noise — you see exactly what you chose to record.
The module has no external dependencies and requires no third-party libraries or
APIs. It supports Drupal 10, 11, and 12.

This is a developer tool: you drive it from code by calling its logging service.
There is no configuration UI — the only setup step after enabling is running the
database updates so the log table is created.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and run the database update that creates the log table.

There is **no configuration page** for this module. It is developer-driven; setup
is code, not a settings form.

## Where it lives in the admin menu

Logged entries are shown at **Reports → Custom Event Logger**
(`/admin/reports/cevlogger`), 50 per page, newest first. The report is gated by
the **Administer site configuration** permission, so restrict access to site
administrators.

## How to use it

Custom Event Logger does nothing on its own — you call its service from your code
to record events. The service is `cevlogger.logger` and its method signature is:

```php
log(string $module_name, string $type, string $message): void
```

The recommended approach is **dependency injection** — inject the
`@cevlogger.logger` service into your own service class and call `->log(...)`. From
a `.module` hook where injection isn't convenient, you can call it statically:

```php
\Drupal::service('cevlogger.logger')->log('my_module', 'error', 'Payment API returned 503');
```

Then review what you've captured at `/admin/reports/cevlogger`. Uninstalling the
module drops the `cevlogger_logs` table cleanly.
