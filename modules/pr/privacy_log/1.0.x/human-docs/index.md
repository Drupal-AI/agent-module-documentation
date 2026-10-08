# Privacy Log — manual setup guide

**Privacy Log** (`privacy_log`) is a data‑minimisation module for Drupal's logging
layer. It does two things to reduce the personal data your site keeps in its logs:

1. **It strips the client IP address from every log entry.** Drupal's Logger API
   normally records the visitor's IP with each log message — personal data many
   sites shouldn't retain. Privacy Log removes it *universally*: it wraps the logger
   channel factory so that no logger downstream — database log (dblog), syslog,
   Monolog, remote log shippers — ever receives the real IP. The IP is **blanked
   entirely** (not hashed), across all channels and backends, the moment the module
   is enabled. No configuration is needed for this part.

2. **It reliably time‑expires database log rows.** If database logging is enabled,
   the module adds a **"Database log messages expiry"** setting to Drupal's *Logging
   and errors* form (default **1 week**). On each cron run it deletes `watchdog` rows
   older than that window — so old log data is removed on schedule even on
   low‑traffic sites where core's row‑count cap never triggers.

Together these help you log less personal data and support data‑protection
compliance. The module has no dependencies outside core, defines no routes or
permissions of its own, and reuses core's existing logging settings form for its one
adjustable option.

> **Note on what's stored:** the point of the module is to *stop* storing the client
> IP in logs — after enabling it, new log entries carry an empty IP field. Other,
> non‑IP log fields are kept intact. For time‑based cleanup to actually run, make
> sure **cron runs regularly**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

The one setting it adds lives on **core's** Logging and errors form (it doesn't
register a settings page of its own), so it's covered under "How to use it" below
rather than a separate configuration page.

## Where it lives in the admin menu

IP stripping is automatic and has no UI. The retention setting is added to the
existing core form at **Configuration → Development → Logging and errors**
(`system.logging_settings`).

## How to use it

- **IP stripping** works immediately once the module is enabled — there's nothing to
  switch on.
- **Retention:** to adjust how long database log messages are kept, go to
  **Configuration → Development → Logging and errors** and set **Database log
  messages expiry** (shown only when database logging is enabled):
  - the default is **1 week** (168 hours);
  - shorter values (e.g. 1 hour, or 1/2/3 days) minimise logs more aggressively;
  - **Never** disables time‑based purging (falling back to core's row‑count cap).
- Ensure **cron runs regularly** so old rows are actually deleted; you can force an
  immediate purge with `drush cron`.

**To verify:** after enabling, confirm new `watchdog` entries have an empty IP field,
and that cron deletes rows older than your configured window.
