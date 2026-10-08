Advanced Queue replaces Drupal core's Queue API with configurable queue entities whose jobs carry states, results, retries, delays and duplicate detection.

---

Advanced Queue models each queue as an `advancedqueue_queue` config entity that pairs a pluggable backend (the default `database` backend stores jobs in the `advancedqueue` table) with a processor (cron or an external daemon). Work is expressed as `Job` objects: a job has a type (a `JobType` plugin that knows how to process it), an arbitrary JSON payload, a state (queued / processing / success / failure), an optional availability delay, a lease time, retry counters and an optional fingerprint for de-duplication. The `Processor` service claims jobs, runs the matching job-type plugin, records the returned `JobResult` (state + message + processing time) back onto the job, dispatches lifecycle events, and either retries failed jobs (up to the type's `max_retries` with a `retry_delay`) or marks them failed. Queues can be processed by core cron (`hook_cron`), the `advancedqueue:queue:process` Drush command, or a long-running daemon, and cleaned up automatically by an item-count or age threshold. A Views-powered admin UI at `admin/config/system/queues` lists queues and jobs and offers per-job and bulk release/retry/delete actions, all gated by the `administer advancedqueue` permission.

---

- Add a durable, database-backed replacement for core `QueueWorker` queues that survives beyond a single cron run.
- Define multiple named queues (e.g. high-priority vs low-priority) and route different job types to each.
- Enqueue a single job from code with `Queue::load('default')->enqueueJob(Job::create($type, $payload))`.
- Bulk-enqueue many jobs efficiently in one transaction via `enqueueJobs()`.
- Schedule a job to run in the future by passing a `$delay` (seconds) to `enqueueJob()`.
- Implement recurring background work for Commerce (e.g. recurring order renewal) or other contrib that depends on Advanced Queue.
- Retry transient failures automatically by returning `JobResult::failure()` and setting `max_retries` / `retry_delay` on a job type.
- Override retry count or delay per individual job result rather than per job type.
- Track each job's outcome: success/failure state plus a human-readable message stored on the row.
- Detect and reject duplicate jobs using a fingerprint hash of queue + type + payload.
- Customize duplicate handling per job type by overriding `handleDuplicateJobs()` (e.g. merge, skip, or throw `DuplicateJobException`).
- Process a queue on cron automatically for queues whose processor is set to `cron`.
- Process a queue continuously from the CLI with `drush advancedqueue:queue:process <queue_id> --timeout=60`.
- Run a queue as a long-lived daemon (processor set to `daemon`, `stop_when_empty` false) that sleeps and polls for new work.
- List all queues and their per-state job counts with `drush advancedqueue:queue:list`.
- Tune how long a claimed job is leased before it can be reclaimed via the backend `lease_time` setting.
- Automatically prune old processed/failed jobs by configuring a cleanup threshold (by item count or by age in days).
- Build custom job listings, filters and bulk operations with the shipped Views field/argument plugins.
- React to job lifecycle points (pre/post process, success, retry, failure) by subscribing to `AdvancedQueueEvents`.
- Write a custom queue backend (e.g. Redis, SQS) by implementing the backend plugin interfaces you need.
- Lock a queue so administrators cannot delete it from the UI while still allowing job management.
- Inspect, release, retry, or delete stuck/failed jobs individually from the admin UI.
- Perform the same release/retry/delete operations in bulk across many selected jobs.
- Stop processing gracefully on SIGTERM/SIGINT when running under Drush with the pcntl extension.
