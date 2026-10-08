# Insta Queue — manual setup guide

**Insta Queue** (`insta_queue`) makes Drupal's queue system process items
**instantly**, in near-realtime, instead of waiting for the next cron run. When
new items are added to a queue, the module notifies an external **scheduler
daemon**, which triggers processing right away. It works with both Drupal core
queues and third-party module queues, uses the core database queue implementation
under the hood (no changes to Drupal's queue system), and can process several
queues in parallel. It's well suited to time-sensitive operations where "process
this now" matters more than "process this on the next cron tick."

Under the hood it decorates Drupal's queue worker manager and dispatches events
as queue items are created, claimed, released, delayed, or deleted; a client
notifies the scheduler process over a **TCP or Unix socket**. It includes
built-in timeout protection to guard against memory leaks during long-running
processing.

The important thing to understand before adopting it is that **Insta Queue needs
a companion program running alongside Drupal** — the *Insta Queue Scheduler* — and
it needs **Drush v12 or newer**. Whether you can run the scheduler at all depends
on your hosting environment; on restricted shared hosting you may not be able to
run a persistent daemon or open sockets. The module supports Drupal 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and understand what else must be running.

There is **no admin settings page** for this module. Its one setting — the
scheduler connection address — lives in `settings.php`, not in the UI, and the
scheduler itself is a separate program you run outside Drupal.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Install and run the **Insta Queue Scheduler** program alongside your Drupal
   site — this is what actually triggers realtime processing. Whether this is
   possible depends on your hosting.
3. Tell Drupal where to reach the scheduler by setting the
   `insta_queue.scheduler_connection` value in your **`settings.php`** (a TCP
   address or a Unix socket path). This value is read from trusted server
   configuration, not from web requests.
4. From then on, when items are added to any queue, the module notifies the
   scheduler and the items are processed almost immediately. Drush commands are
   provided for worker and scheduler operations.
