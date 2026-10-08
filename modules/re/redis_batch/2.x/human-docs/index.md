# Redis Batch — manual setup guide

**Redis Batch** (`redis_batch`) provides a **Redis‑backed storage backend for
Drupal's Batch API**. Normally Drupal stores the progress and data of a batch
operation — the long‑running jobs behind bulk actions, migrations, and update
scripts — in the database. On a busy site, or one running large or frequent
batches, that puts avoidable load on the database. This module moves that batch
storage into **Redis** instead, so batches don't hammer the DB and scale better
on infrastructure that already runs Redis.

It's a performance/infrastructure module with no content or editorial role of its
own and no admin screen to click through. The work is in wiring it to your Redis
server, which it does through the contributed
[Redis](https://www.drupal.org/project/redis) module (a hard dependency) and your
site's `settings.php`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside the Redis module.
2. [Configuration](configuration/index.md) — point the site at your Redis server
   in `settings.php`.

## Where it lives in the admin menu

Redis Batch adds no admin page. Its configuration is the Redis connection you
define in `settings.php` (via the Redis module) — see
[Configuration](configuration/index.md).
