<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — enqueueing, processing, events

## Enqueue

```php
use Drupal\advancedqueue\Job;
use Drupal\advancedqueue\Entity\Queue;

$queue = Queue::load('default');

// One job, available immediately.
$job = Job::create('mymodule_send_report', ['report_id' => 42]);
$queue->enqueueJob($job);

// Available in one hour.
$queue->enqueueJob(Job::create('mymodule_send_report', ['report_id' => 43]), 3600);

// Bulk (one backend call).
$queue->enqueueJobs([$job_a, $job_b, $job_c]);
```

`enqueueJob()` / `enqueueJobs()` are convenience passthroughs on `QueueInterface`; the real
work is in `$queue->getBackend()`. They **mutate the passed `Job`** — after the call it has
`id`, `queue_id`, `available` and (when duplicate detection is on) `fingerprint` set. They
throw `Drupal\advancedqueue\Exception\DuplicateJobException` when the job type disallows
duplicates and one is found, and `InvalidBackendException` when the backend cannot detect
duplicates at all.

`Job::create($type, array $payload, array $definition = [])` always starts in
`Job::STATE_QUEUED`. The payload is stored as JSON by the `database` backend, so it must be
JSON-serialisable — put entity IDs in it, not entity objects.

## The `Job` value object

Constants: `Job::STATE_QUEUED`, `STATE_PROCESSING`, `STATE_SUCCESS`, `STATE_FAILURE`
(an invalid state throws `\InvalidArgumentException`; `type`, `payload` and `state` are
required in the constructor definition array).

Getters/setters: `getId()`, `getQueueId()`, `getType()`, `getPayload()`, `getState()`,
`getMessage()`, `getNumRetries()`, `getAvailableTime()`, `getProcessedTime()`,
`getExpiresTime()`, `getFingerprint()`, plus the matching setters and `toArray()`.
`setState()` to anything other than `processing` also resets `expires` to `0`.

## `JobResult`

```php
JobResult::success('optional message');
JobResult::failure('why it failed');                 // uses the job type's retry policy
JobResult::failure('rate limited', 5, 300);          // override max_retries / retry_delay
```

Accessors: `getState()`, `getMessage()`, `getMaxRetries()`, `getRetryDelay()` (the last two
return `NULL` to mean "use the job type default").

## Processing

Service `advancedqueue.processor` (`Drupal\advancedqueue\ProcessorInterface`, also aliased
to the interface FQCN so it can be autowired):

```php
$processor = \Drupal::service('advancedqueue.processor');
$num = $processor->processQueue($queue);     // returns the number of jobs processed
$result = $processor->processJob($job, $queue);
$processor->stop();                          // graceful stop between jobs
```

`processQueue()`:

1. calls `$queue->getBackend()->cleanupQueue()` (threshold pruning) first;
2. computes a deadline from `$queue->getProcessingTime()` — `0` means unlimited **only** when
   `PHP_SAPI == 'cli'`, otherwise it is forced to `90`;
3. loops `claimJob()` → `processJob()` until the deadline, until `stop()` is called, or —
   when `stop_when_empty` is `TRUE` — until the queue is empty.

`processJob()` dispatches `PRE_PROCESS`, instantiates the job type plugin and calls
`process()`, copies the result's state and message onto the job, dispatches `POST_PROCESS`,
then hands the job back to the backend:

- success → `$backend->onSuccess($job)` + `JOB_SUCCESS`
- failure **because the plugin threw** → `$backend->onFailure($job)` + `JOB_FAILURE`
  (no retry; the exception is logged to the `cron` logger channel)
- failure returned by the plugin, `num_retries < max_retries` →
  `$backend->retryJob($job, $retry_delay)` + `JOB_RETRY`
- failure returned by the plugin, retries exhausted → `onFailure()` + `JOB_FAILURE`

Cron: `advancedqueue_cron()` loads every queue with `processor === 'cron'` and calls
`processQueue()` on each.

## Events

`Drupal\advancedqueue\Event\AdvancedQueueEvents` constants, all carrying a
`Drupal\advancedqueue\Event\JobEvent` with `getJob()`:

| Constant | Event name |
|---|---|
| `PRE_PROCESS` | `advancedqueue.pre_process` |
| `POST_PROCESS` | `advancedqueue.post_process` |
| `JOB_SUCCESS` | `advancedqueue.job.success` |
| `JOB_RETRY` | `advancedqueue.job.retry` |
| `JOB_FAILURE` | `advancedqueue.job.failure` |

`POST_PROCESS` fires **before** the job is passed back to the backend, so a subscriber can
still change the job's state or message.

## Counting and inspecting

```php
// ['queued' => n, 'processing' => n, 'success' => n, 'failure' => n]
$counts = $queue->getBackend()->countJobs();

// Only when the backend implements SupportsLoadingJobsInterface (database does):
$job = $queue->getBackend()->loadJob($job_id);
```

Raw storage for the `database` backend is the `advancedqueue` table
(`job_id, queue_id, type, payload, state, message, num_retries, available, processed,
expires, fingerprint`), so a quick check is:

```bash
drush sql:query "SELECT queue_id, type, state, message FROM advancedqueue ORDER BY job_id DESC LIMIT 10"
```
