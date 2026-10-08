# Dead Letter Queue — manual setup guide

**Dead Letter Queue** (`dead_letter_queue`) is a developer-oriented module that
gives Drupal a smarter queue backend: instead of retrying a broken job forever, it
sets aside items that keep failing so they stop clogging the queue and can be
inspected or replayed later.

The problem it solves is a familiar one. Drupal's core reliable queue will retry a
failed item indefinitely, which means a single "poison" item — one that can never
succeed — can wedge an entire queue behind it, blocking every job that comes
after. Dead Letter Queue supplies a drop-in database queue that tracks a **tries**
count for each item. Once an item's tries reach a configured **max tries**
threshold, it's treated as "dead": it's no longer counted or served to workers, so
cron simply moves past it and the rest of the queue keeps flowing.

Worker code gets fine control over what happens to a failing item. From a queue
worker, developers can throw a `DiscardDeadLetterException` to drop an item
permanently, or a `RestoreDeadLetterException` to send it back for another attempt;
otherwise an ordinary failure just increments the try count. A dead item can also
be revived by resetting its tries. Two optional submodules round it out: **Dead
Letter Queue UI** integrates with the Queue UI module so you can list and reset
dead letters from the admin screen, and **Dead Letter Queue Unique** provides a
deduplicating variant for the Queue Unique module.

This module is primarily wired up in code — you point a queue at its backend and
set the try limit in configuration; there is no general settings form in the admin
UI. It has no third-party dependencies, requires **PHP 8.1**, supports Drupal
10.3+ and 11, is actively maintained, and is covered by Drupal's security advisory
policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and choose the submodules you need.

There is **no site-wide configuration form** for this module. It's set up in code
by pointing a queue at its backend and setting the try limit in configuration —
see "How to use it" below.

## Where it lives in the admin menu

The base module adds no admin page. If you enable the **Dead Letter Queue UI**
submodule (which requires the Queue UI module), you can inspect and reset dead
letters at **`/admin/config/system/queue-ui/dead-letters/{queueName}`**, gated by
the **Administer Queue UI** (`admin queue_ui`) permission.

## How to use it

This is a developer tool, so most of the setup happens in code:

1. **Point a queue at the dead-letter backend.** The module provides a queue
   factory service (`dead_letter_queue.queue.database`) that returns a
   `DeadLetterDatabaseQueue`. Configure the queue names you want protected to use
   this backend instead of the core database queue. Its storage mirrors core's
   database queue, with one extra `tries` column.
2. **Set the try limit.** The `max_tries` value is read from configuration. Lower
   it to sideline flaky items sooner; raise it to be more forgiving of transient
   failures.
3. **Control disposition in your worker.** In your queue worker's
   `processItem()`, throw `DiscardDeadLetterException` to drop an item for good, or
   `RestoreDeadLetterException` to give it another chance. Any other failure simply
   increments the item's try count; once it reaches `max_tries`, the item becomes a
   dead letter and is skipped by future cron runs.
4. **Inspect and replay.** Enable the **Dead Letter Queue UI** submodule to browse
   dead letters per queue and reset an item's tries so it gets processed again —
   handy after you've deployed a fix for whatever was making the items fail.
