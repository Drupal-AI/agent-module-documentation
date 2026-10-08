# Configuration

Advanced Queue is configured by creating and editing **queues** — one queue per
kind of background work. Everything lives at **Configuration → System → Queues**
(`/admin/config/system/queues`), and access requires the **Administer queues**
permission.

## Managing queues

- **List:** *Configuration → System → Queues* shows every queue with its label and
  a count of jobs in each state (queued, processing, success, failure).
- **Add:** click *Add queue* (`/admin/config/system/queues/add`).
- **Edit / delete:** use the operations links next to each queue. A **locked** queue
  hides its delete link — locking is how a module protects a queue it depends on.

The module ships one queue named **Default** so you have something to enqueue into
immediately.

## The queue settings, field by field

When you add or edit a queue you'll set the following:

### Label and machine name

A human‑readable **Label** and a machine name (the queue's `id`). The machine name
is what your code passes to `Queue::load('…')`.

### Backend

The **storage backend** — where this queue's jobs are kept. The **Database**
backend ships in the box and stores jobs in the `advancedqueue` table; that is the
right choice for almost everyone. A `null` backend (a "black hole" that discards
jobs) also ships, mostly for testing. Other backends (Redis, SQS, …) can be added
by installing or writing a backend plugin.

The database backend has one setting, **Lease time** (default **300** seconds):
how long a claimed job is reserved for a worker before it is considered stuck and
can be released back to the queue.

### Processor

How the queue gets drained. Two choices:

- **Cron** — the queue is processed automatically on every cron run. Good for
  routine, steady work.
- **Daemon** — cron ignores the queue; instead you run a long‑lived worker with
  `drush advancedqueue:queue:process <queue_id>`. Good for high‑volume or
  continuous processing.

### Processing time

The number of seconds a single processing run may keep working before it stops
(default **90**). This keeps cron itself from timing out. A value of **0** means
"unlimited", but that only takes effect on the command line — during a normal
(web) cron run, `0` is treated as `90` to protect the request.

### Stop when empty

When **on** (the default), a processing run returns as soon as the queue drains.
When **off**, the run keeps polling for new jobs until its time budget runs out —
useful for a daemon that should sit and wait for work.

### Threshold (automatic cleanup of finished jobs)

Optionally prune old finished jobs so the table does not grow forever. You choose:

- a **type** — keep everything, keep a number of **items**, or keep a number of
  **days**;
- a **limit** — the count of items (100 / 1,000 / 10,000 / …) or days
  (7 / 30 / 60 / 180 / 365);
- a **state** — apply the cleanup to **all** finished jobs, or only to
  **successful** ones (so you keep every failure for auditing).

Cleanup runs at the start of each processing run.

### Locked

A **locked** queue cannot be deleted from the UI, even by someone holding
*Administer queues*. Set this on queues your site depends on. (Locking is usually
set from code by the module that owns the queue, but it appears here too.)

## Processing and monitoring jobs

Open a queue and you get its **job list** (built with Views): every job with its
type, state, message and a set of operations. From here you can:

- **Retry** a failed job, **release** a stuck `processing` job whose lease expired,
  or **delete** a job;
- use the **bulk form** to retry, release or delete many jobs at once.

For queues on the **daemon** processor (and to drain a cron queue on demand), run:

```bash
drush advancedqueue:queue:process default            # process the default queue
drush advancedqueue:queue:process reports --timeout=60
```

For a quick machine‑readable overview of every queue and its job counts:

```bash
drush advancedqueue:queue:list
drush advancedqueue:queue:list --format=json
```

## Creating a queue from the command line

You do not have to use the UI. To script a queue:

```bash
drush php:eval '
  use Drupal\advancedqueue\Entity\Queue;
  Queue::create([
    "id" => "reports",
    "label" => "Reports",
    "backend" => "database",
    "backend_configuration" => ["lease_time" => 600],
    "processor" => "cron",
    "processing_time" => 120,
    "locked" => FALSE,
    "stop_when_empty" => TRUE,
    "threshold" => ["type" => 1, "limit" => 1000, "state" => "success"],
  ])->save();
'
```

The full config entity shape, the exact threshold constants, the job routes and the
Drush command details are documented in the [`agent/`](../agent/start.md) reference.
