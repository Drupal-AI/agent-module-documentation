<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enqueuing & processing jobs (API)

## Job (`src/Job.php`)
A value object, not an entity. States: `Job::STATE_QUEUED`, `STATE_PROCESSING`,
`STATE_SUCCESS`, `STATE_FAILURE`. Construct with `Job::create($type, array $payload, array $definition = [])`
— `type`, `payload`, `state` are required (constructor throws `\InvalidArgumentException` if
missing; `assertState()` validates the state). Key accessors: `getId()/setId()`,
`getQueueId()`, `getType()`, `getPayload()/setPayload()`, `getState()/setState()`
(`setState()` resets `expires` to 0 unless the new state is `processing`), `getMessage()`,
`getNumRetries()`, `getAvailableTime()/setAvailableTime()`, `getProcessedTime()`,
`getExpiresTime()`, `getFingerprint()/setFingerprint()` (any 32-char id), `toArray()`.

## Enqueuing
Load a queue and enqueue:
```
$queue = \Drupal\advancedqueue\Entity\Queue::load('default');
$queue->enqueueJob(\Drupal\advancedqueue\Job::create('my_job_type', ['id' => 42]));
$queue->enqueueJobs([$job1, $job2], $delay = 60); // delayed 60s, single transaction
```
`Queue::enqueueJob()/enqueueJobs()` call `prepareJob()` (sets queue id; if the job type does
not `allow_duplicates`, computes a fingerprint via the type plugin and asks the backend for
duplicates, then `handleDuplicateJobs()`), then delegate to the backend. `$delay` (seconds)
sets the job's availability time. The database backend stores the payload as JSON.

## Processing (`src/Processor.php`, service `advancedqueue.processor`)
`processQueue(QueueInterface $queue)`: runs `cleanupQueue()`, then loops claiming jobs
(`backend->claimJob()`) until stopped, the time budget (`processing_time`, forced to 90s
off-CLI) is exhausted, or — when `stop_when_empty` — the queue drains; sleeps 1s between
empty polls. Returns the processed count. `stop()` sets the stop flag (used by signal handlers).

`processJob(Job $job, QueueInterface $queue)`:
1. Dispatch `PRE_PROCESS`.
2. `jobTypeManager->createInstance($job->getType())->process($job)` → a `JobResult`. Any
   `\Throwable` is caught, logged to the `cron` channel, and turned into a failure result.
3. Write `state` + `message` from the result onto the job; dispatch `POST_PROCESS`.
4. Success → `backend->onSuccess()` + `JOB_SUCCESS`. Failure from an exception (no job type)
   → `onFailure()` + `JOB_FAILURE`. Failure with a job type → retry via `backend->retryJob()`
   + `JOB_RETRY` while `num_retries < max_retries`, else `onFailure()` + `JOB_FAILURE`.

## JobResult (`src/JobResult.php`)
`JobResult::success($message = '')` and
`JobResult::failure($message = '', $max_retries = NULL, $retry_delay = NULL)`. When
`max_retries`/`retry_delay` are non-null they override the job type's defaults for this run.

## Retries & delays
`Database::retryJob()` only accepts a failed job (throws otherwise); it increments
`num_retries`, sets availability to now+delay, and re-queues. Delay a first run with the
`$delay` argument to `enqueueJob()`.

## Duplicates / fingerprints
Job types with `allow_duplicates = false` get a fingerprint from
`JobTypeBase::createJobFingerprint()` (`hash('tiger128,3', queueId . type . serialize(payload))`).
`Database::getDuplicateJobs()` finds same-fingerprint jobs in `queued`/`processing` state.
Default `handleDuplicateJobs()` throws `DuplicateJobException`; override it to merge/skip.

## Events (`src/Event/AdvancedQueueEvents.php`)
Subscribe to `advancedqueue.pre_process`, `.post_process`, `.job.success`, `.job.retry`,
`.job.failure`; each handler receives a `JobEvent` exposing the `Job`.
