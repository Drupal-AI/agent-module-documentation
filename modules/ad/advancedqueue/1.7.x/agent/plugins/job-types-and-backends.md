<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Job type & backend plugins

Two plugin types are declared in `advancedqueue.plugin_type.yml`.

## Job type plugins (`advancedqueue_job_type`)
- Manager: `plugin.manager.advancedqueue_job_type` (`JobTypeManager`), discovers plugins in
  `Plugin/AdvancedQueue/JobType/`.
- Define with the `#[AdvancedQueueJobType]` attribute (`src/Attribute/AdvancedQueueJobType.php`)
  or the legacy `@AdvancedQueueJobType` annotation. Definition fields: `id`, `label`,
  `max_retries` (default 0), `retry_delay` (seconds), `allow_duplicates` (bool).
- Extend `JobTypeBase` (`src/Plugin/AdvancedQueue/JobType/JobTypeBase.php`) and implement
  `process(Job $job): JobResult` (from `JobTypeInterface`). Return `JobResult::success()` /
  `JobResult::failure()`.
- `getMaxRetries()` / `getRetryDelay()` read from the plugin definition; the `Processor`
  consults them when a job fails (unless the `JobResult` overrides them).
- Duplicate handling: `createJobFingerprint(Job)` builds a `tiger128,3` hash of
  queue+type+payload; override `handleDuplicateJobs(Job, array $duplicates, BackendInterface)`
  to change the default behaviour (base throws `DuplicateJobException`).

Example skeleton:
```
#[AdvancedQueueJobType(id: 'my_job_type', label: new TranslatableMarkup('My job'), max_retries: 3, retry_delay: 60)]
class MyJobType extends JobTypeBase {
  public function process(Job $job): JobResult {
    $data = $job->getPayload();
    // ... do work ...
    return JobResult::success('Done');
  }
}
```
Test-module examples live under `tests/modules/advancedqueue_test/src/Plugin/AdvancedQueue/JobType/`
(`Simple`, `Retry`, `Sleepy`, `Flexible`, `AvoidDuplicates`).

## Backend plugins (`advancedqueue_backend`)
- Manager: `plugin.manager.advancedqueue_backend` (`BackendManager`), discovers plugins in
  `Plugin/AdvancedQueue/Backend/`.
- Define with `#[AdvancedQueueBackend]` (id, label). Extend `BackendBase` (config +
  `lease_time` form) and implement `BackendInterface`: `createQueue()`, `deleteQueue()`,
  `cleanupQueue()`, `countJobs()`, `enqueueJob()/enqueueJobs()`, `claimJob()`, `onSuccess()`,
  `onFailure()`, `getLabel()`.
- Optional capability interfaces (implement only what you support), all in
  `Plugin/AdvancedQueue/Backend/`:
  - `SupportsListingJobsInterface`, `SupportsLoadingJobsInterface` (`loadJob()`),
  - `SupportsReleasingJobsInterface` (`releaseJob()`),
  - `SupportsDeletingJobsInterface` (`deleteJob()`),
  - `SupportsDetectingDuplicateJobsInterface` (`getDuplicateJobs()`, `retryJob()`).
- Shipped backends: `Database` (implements all five optional interfaces) and `NullBackend`
  (discards everything).

The queue entity resolves its backend through `BackendPluginCollection`; `Queue::getBackend()`
returns the configured instance, passing the entity id as `_entity_id` so the backend knows its
`queueId`.
