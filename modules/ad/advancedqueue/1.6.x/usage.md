<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Advanced Queue replaces core's Queue API with configurable **queue config entities**, pluggable storage backends and pluggable **job types**, adding job states, stored results, retries, delayed processing, duplicate detection and a Views-powered admin job listing.

---

A queue is an `advancedqueue_queue` config entity (`/admin/config/system/queues`) with a **backend plugin** (`database` ships in the box, `null` for a black hole) and a **processor** setting of either `cron` or `daemon`. `hook_cron()` processes every queue whose processor is `cron`; `drush advancedqueue:queue:process <queue_id> --timeout=N` processes any queue from the CLI and honours SIGTERM/SIGINT for graceful shutdown. Work is pushed with `Job::create($job_type_id, $payload)` followed by `$queue->enqueueJob($job, $delay)` (or `enqueueJobs()` for bulk); each job carries a state (`queued`, `processing`, `success`, `failure`), a message, a retry counter, availability/processed/expiry timestamps and an optional fingerprint. The `advancedqueue.processor` service claims jobs, dispatches the five `AdvancedQueueEvents` (`PRE_PROCESS`, `POST_PROCESS`, `JOB_SUCCESS`, `JOB_RETRY`, `JOB_FAILURE`), and calls the matching **job type plugin**'s `process(Job $job): JobResult`. Returning `JobResult::failure($message)` triggers a retry while `num_retries` is below the job type's `max_retries`, waiting `retry_delay` seconds each time; otherwise the job lands in the `failure` state with its message stored. The database backend stores everything in the `advancedqueue` table and implements the optional `SupportsDeletingJobsInterface`, `SupportsListingJobsInterface`, `SupportsReleasingJobsInterface`, `SupportsLoadingJobsInterface` and `SupportsDetectingDuplicateJobsInterface` capabilities, which drive the per-queue job view (`views.view.advancedqueue_jobs`), the release/retry/delete forms and the bulk action confirm form. Queues can auto-prune finished jobs via a `threshold` (keep N items, or N days, for all jobs or only successful ones), can be `locked` so they cannot be deleted, and can `stop_when_empty`. It is the queue system used by Drupal Commerce.

---

- Run long-running Commerce recurring-order renewals outside the request that triggered them.
- Send bulk transactional email in the background without blowing the PHP timeout.
- Give a nightly import job real retry semantics instead of "it silently disappeared".
- Split high-priority and low-priority work into two queues with different processing times.
- Process one queue on cron and another only via a long-running Drush daemon.
- Schedule a job to become available in 10 days with `enqueueJob($job, 864000)`.
- Retry a failing webhook delivery three times with an increasing delay before giving up.
- Store the failure message on the job so an admin can read *why* it failed at `/admin/config/system/queues`.
- Let an editor release a stuck `processing` job whose lease expired from the admin UI.
- Bulk-retry every failed job in a queue with the Views bulk form.
- Bulk-delete a queue's finished jobs after an incident.
- Keep only the last 1,000 jobs in a queue with the item-count threshold.
- Keep only 30 days of *successful* jobs while retaining all failures for audit.
- Prevent duplicate work by giving a job type a fingerprint and rejecting duplicates.
- Merge the payloads of duplicate jobs instead of rejecting them, via `handleDuplicateJobs()`.
- Enqueue thousands of jobs in one shot with `enqueueJobs()` to avoid per-job insert overhead.
- Write a job type that re-indexes a single entity, then fan out one job per entity.
- Add a Redis or SQS backend by implementing an `AdvancedQueueBackend` plugin.
- Route jobs to a `null` backend in a test environment so nothing is actually processed.
- Subscribe to `advancedqueue.job.failure` to page on-call when a critical job type exhausts its retries.
- Subscribe to `advancedqueue.pre_process` to set up per-job context (site language, current user).
- Lock a queue that other modules depend on so an admin cannot delete it.
- Get a machine-readable overview of every queue and its job counts with `drush advancedqueue:queue:list`.
- Cap a cron run's queue processing at 90 seconds so cron itself does not time out.
- Run a worker container that executes `drush advancedqueue:queue:process default --timeout=0` forever on the CLI.
- Convert an existing core `QueueWorker` to a job type plugin to gain retries and visibility.
- Give site builders a UI to add new queues without deploying code.
- Restrict queue administration to trusted staff with the `administer advancedqueue` permission.
