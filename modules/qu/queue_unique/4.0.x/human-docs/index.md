# Queue unique — manual setup guide

**Queue unique** (`queue_unique`) provides a Drupal queue backend that silently
rejects duplicate items. If you try to add an item that's already sitting in the
queue, nothing is added and the insert simply reports that no item was created —
so a queue never fills up with identical copies of the same job.

That's exactly what you want for background work that can be triggered many times
for the same thing: a "reindex this entity" task that should run once per cron
run, an outbound webhook or API sync that shouldn't fire repeatedly when content
is saved several times in a row, or a cache-warm, digest-email, or sitemap-
regeneration job that must never hold duplicates. Instead of writing your own
dedup logic in PHP, uniqueness is enforced at the **database level** — the queue
keeps a hash of the queue name plus the item's data with a unique key, so
duplicates can't be inserted in the first place.

This is a developer's building block: there's no settings page, no permissions,
and no admin UI. You opt a queue into it in one of three ways — point a specific
named queue at the module's service in `settings.php`, fetch the queue directly
from the service in code, or replace core's queue factory and use a `queue_unique/`
name prefix (which also lets a cron queue worker be processed uniquely). You
process the queue with core's own `drush queue:run`. The module has no
dependencies beyond Drupal core.

This guide is written for a **human**, though the audience here is really a
developer. If you want terse, token-cheap references for an AI coding agent, read
the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — there is no admin UI. You use Queue unique from `settings.php`, a
`services.yml`, or your module's code.

## How to use it

Pick whichever fits your case (full code examples are in the sibling
[`agent/`](../agent/start.md) docs):

1. **Route one named queue to it** — in `settings.php`:

   ```php
   $settings['queue_service_your_queue_name'] = 'queue_unique.database';
   ```

   Now `\Drupal::service('queue')->get('your_queue_name')` returns a unique queue.

2. **Fetch it directly** — no settings change needed:

   ```php
   $queue = \Drupal::service('queue_unique.database')->get('your_queue_name');
   $queue->createItem($data);
   ```

3. **Prefix-based queues** — override core's `queue` service with the module's
   factory, then any queue whose name starts with `queue_unique/` is served
   uniquely (the prefix is stripped for the real queue name). This is what lets a
   `@QueueWorker` plugin whose ID starts with `queue_unique/` be pulled uniquely
   by cron.

Whichever you choose, detect a rejected duplicate by checking whether
`createItem()` returned `FALSE`, and process the queue with the core command
`drush queue:run <queue_name>`.
