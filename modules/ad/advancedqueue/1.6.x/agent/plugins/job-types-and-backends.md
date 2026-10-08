<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins — job types and backends

Two plugin types, both declared in `advancedqueue.plugin_type.yml`:

| Plugin type id | Manager service | Directory | Attribute | Interface |
|---|---|---|---|---|
| `advancedqueue.job_type` | `plugin.manager.advancedqueue_job_type` | `src/Plugin/AdvancedQueue/JobType` | `Drupal\advancedqueue\Attribute\AdvancedQueueJobType` | `JobTypeInterface` |
| `advancedqueue.backend` | `plugin.manager.advancedqueue_backend` | `src/Plugin/AdvancedQueue/Backend` | `Drupal\advancedqueue\Attribute\AdvancedQueueBackend` | `BackendInterface` |

Both managers still accept the legacy `@AdvancedQueueJobType` / `@AdvancedQueueBackend`
annotations (`src/Annotation/`), but **PHP attributes are the current form**.
Alter hooks: `hook_advancedqueue_job_type_info_alter()`,
`hook_advancedqueue_backend_info_alter()`.

## Job type plugin

Attribute properties (`AdvancedQueueJobType`):

| Property | Type | Default | Meaning |
|---|---|---|---|
| `id` | string | — | the value passed to `Job::create($id, …)` |
| `label` | `TranslatableMarkup` | — | shown in the job listing |
| `max_retries` | int | `0` | retries after a failure (0 = none) |
| `retry_delay` | int | `10` | seconds before a retried job becomes available |
| `allow_duplicates` | bool | `TRUE` | `FALSE` turns on fingerprint-based duplicate detection |

```php
// modules/custom/mymodule/src/Plugin/AdvancedQueue/JobType/SendReport.php
namespace Drupal\mymodule\Plugin\AdvancedQueue\JobType;

use Drupal\advancedqueue\Attribute\AdvancedQueueJobType;
use Drupal\advancedqueue\Job;
use Drupal\advancedqueue\JobResult;
use Drupal\advancedqueue\Plugin\AdvancedQueue\JobType\JobTypeBase;
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[AdvancedQueueJobType(
  id: 'mymodule_send_report',
  label: new TranslatableMarkup('Send report'),
  max_retries: 3,
  retry_delay: 60,
)]
final class SendReport extends JobTypeBase {

  public function process(Job $job): JobResult {
    $payload = $job->getPayload();          // whatever you enqueued
    try {
      // …do the work…
      return JobResult::success('Sent report ' . $payload['report_id']);
    }
    catch (\Exception $e) {
      // Optionally override the plugin's retry policy for this one failure:
      return JobResult::failure($e->getMessage(), max_retries: 5, retry_delay: 300);
    }
  }

}
```

`JobTypeBase` (extends `PluginBase`) already implements `getLabel()`, `getMaxRetries()`,
`getRetryDelay()`, `createJobFingerprint()` and `handleDuplicateJobs()`. **`process()` is
the only abstract method.** It must return a `JobResult`; anything thrown is caught by the
processor, logged to the `cron` logger channel and turned into a *non-retried* failure.

For dependency injection implement `ContainerFactoryPluginInterface` and a `create()`
method as usual — `JobTypeBase` does not do it for you.

### Duplicate detection

Set `allow_duplicates: FALSE`. On `enqueueJob()` the queue then:

1. requires the backend to implement `SupportsDetectingDuplicateJobsInterface`
   (otherwise `InvalidBackendException`);
2. calls `createJobFingerprint($job)` if the job has no fingerprint — the base
   implementation is `hash('tiger128,3', queue_id . type . serialize(payload))`;
3. calls `$backend->getDuplicateJobs($job)`, and if any are found hands them to
   `handleDuplicateJobs($job, $duplicates, $backend)`.

`JobTypeBase::handleDuplicateJobs()` throws `DuplicateJobException`. Override it to
implement a different strategy — return the job to enqueue anyway, return `NULL` to discard
the new job, or delete the duplicates (backend must implement
`SupportsDeletingJobsInterface`) and return a job with a merged payload.

## Backend plugin

`BackendInterface extends ConfigurableInterface, PluginFormInterface, PluginInspectionInterface`
and requires: `getLabel()`, `createQueue()`, `deleteQueue()`, `cleanupQueue()`,
`countJobs()`, `enqueueJob(Job $job, $delay = 0)`, `enqueueJobs(array $jobs, $delay = 0)`,
`retryJob(Job $job, $delay = 0)`, `claimJob()`, `onSuccess(Job $job)`, `onFailure(Job $job)`.

Extend `BackendBase`, which supplies the `lease_time` configuration (default `300`), its
configuration form, `getLabel()`, an empty `cleanupQueue()` and a `create()` that injects
`datetime.time`. `BackendBase::__construct()` reads the special `_entity_id` key out of the
configuration array into `$this->queueId` — that is how a backend instance knows which queue
it belongs to (injected by `BackendPluginCollection`).

```php
#[AdvancedQueueBackend(
  id: 'redis',
  label: new TranslatableMarkup('Redis'),
)]
final class Redis extends BackendBase implements SupportsListingJobsInterface, SupportsDeletingJobsInterface {
  // …
}
```

Optional capability interfaces (all in the same namespace) — implement only what your
storage can do; the admin UI checks for them:

| Interface | Adds |
|---|---|
| `SupportsListingJobsInterface` | job listing views integration |
| `SupportsLoadingJobsInterface` | `loadJob($job_id)` |
| `SupportsDeletingJobsInterface` | `deleteJob($job_id)` |
| `SupportsReleasingJobsInterface` | `releaseJob($job_id)` |
| `SupportsDetectingDuplicateJobsInterface` | `getDuplicateJobs(Job $job): array` |

The shipped `database` backend implements all five; `null` implements none.
`BackendManager::processDefinition()` throws a `PluginException` if `id` or `label` is
missing.

### Config schema for a backend

Backend configuration is typed as `advancedqueue.backend.[%parent.backend]`. Declare yours
in `config/schema/mymodule.schema.yml`:

```yaml
advancedqueue.backend.redis:
  type: advancedqueue_backend_configuration   # gives you lease_time
  mapping:
    host:
      type: string
      label: 'Host'
```

Without a schema entry the generic `advancedqueue.backend.*` fallback applies, which only
knows `lease_time`.
