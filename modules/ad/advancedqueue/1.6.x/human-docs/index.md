# Advanced Queue — manual setup guide

**Advanced Queue** (`advancedqueue`) is a better background‑job system for Drupal.
It replaces core's bare‑bones Queue API with configurable **queues** you manage in
the admin UI, real **job states** (queued, processing, success, failure), stored
result messages, automatic **retries**, delayed jobs, duplicate detection and a
Views‑powered admin screen where you can see, retry, release and delete individual
jobs. It is the queue system used by Drupal Commerce, and it is a solid choice any
time you need to move slow work out of the web request.

Instead of the "fire and forget, and hope it worked" feel of the core queue, every
job here carries a state, a message explaining *why* it failed, a retry counter and
timestamps. A queue is a configuration entity you create at **Configuration →
System → Queues**, each with its own storage backend (a database backend ships in
the box) and a choice of how it gets processed: on **cron**, or by a long‑running
**Drush daemon** you run yourself. Jobs are pushed from code with a couple of lines,
processed by matching **job type plugins** that return success or failure, and — on
failure — retried up to a limit you set, with a delay between attempts.

Beyond the basics it can auto‑prune finished jobs (keep the last N items, or N days,
for all jobs or only successful ones), lock a queue so nobody can delete it, reject
or merge duplicate jobs via a fingerprint, and process queues from the command line
with graceful shutdown so it is safe to run as a supervised worker process. Writing
your own job types and storage backends is a plugin exercise, documented in the
[`agent/`](../agent/start.md) reference.

This guide is written for a **human** setting the module up and creating queues
through the admin UI. If you want the terse, token‑cheap reference for an AI coding
agent — the exact config entity shape, the `Job`/`JobResult` API, the events, the
Drush commands and the plugin base classes — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create and tune queues at
   *Configuration → System → Queues*, and use the per‑queue job listing.

## Where it lives in the admin menu

The queue administration screen is at **Configuration → System → Queues**
(`/admin/config/system/queues`). From there you add, edit and delete queues, and
open each queue's **job list** to release, retry or delete individual jobs. Access
to all of this is gated by the single **Administer queues** permission
(`administer advancedqueue`), which is marked security‑sensitive.

## How to use it

At a high level:

1. **Create a queue** at *Configuration → System → Queues* (see
   [Configuration](configuration/index.md)). The module ships one queue named
   `default` to get you started.
2. **Write a job type plugin** in your own module — a class with a
   `process(Job $job): JobResult` method that does the work and returns success or
   failure. See the [`agent/`](../agent/start.md) plugin reference.
3. **Push jobs** onto the queue from your code:

   ```php
   use Drupal\advancedqueue\Job;
   use Drupal\advancedqueue\Entity\Queue;

   Queue::load('default')->enqueueJob(Job::create('my_job_type', ['id' => 42]));
   ```
4. **Let it process.** Queues set to the `cron` processor drain on every cron run.
   Queues set to `daemon` are processed by a Drush command you run yourself:

   ```bash
   drush advancedqueue:queue:process default --timeout=60
   ```
5. **Watch the results** in the per‑queue job list under *Configuration → System →
   Queues*, where you can read failure messages and retry, release or delete jobs.
