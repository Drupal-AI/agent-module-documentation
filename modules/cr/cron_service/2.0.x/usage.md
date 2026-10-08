Cron Service Manager lets you move `hook_cron()` logic into tagged service classes that the module collects and runs on each cron run, with optional per-service scheduling and run gating.

---

Cron Service Manager is a developer framework, not an end-user feature. Instead of scattering cron logic across `hook_cron()` implementations in `.module` files (hard to unit-test, no per-task scheduling), you write a service class implementing `\Drupal\cron_service\CronServiceInterface` and give it the container tag `cron_service`. A `service_collector` gathers all such services into `CronServiceManager`, and the module's own `hook_cron()` calls `CronServiceManager::execute()`, which runs each collected service's `execute()` method. Two optional interfaces refine behavior: `ScheduledCronServiceInterface::getNextExecutionTime()` returns the Unix timestamp before which the job must not run (the manager stores it in State and skips the job until then), and `TimeControllingCronServiceInterface::shouldRunNow()` is a boolean pre-check called on every run so a job can veto its own execution. The interfaces combine freely and a job runs only when all applicable checks pass. Per-service last-run, next-run and a `forced` flag live in Drupal State (`cron_service.cron.<id>.*`). The manager API also lets other code run a single job (`executeHandler($id, $force)`), force a job to bypass its schedule on the next cron run (`forceNextExecution($id)`), and read scheduling state. Any exception thrown by a job is logged and dispatched as a `CronServiceErrorEvent` so one failing job does not abort the rest of cron. The module ships no routes, permissions, config or UI; the optional `cron_service_ui` submodule adds an admin listing and a force action.

---

- Replace an existing `hook_cron()` implementation with a testable, injectable service class.
- Run a periodic maintenance task (cleanup, sync, cache warming) as a tagged `cron_service`.
- Schedule a job to run at most once per interval via `getNextExecutionTime()` (e.g. daily = `time() + 86400`).
- Gate a job on runtime conditions (time of day, environment, feature flag) via `shouldRunNow()`.
- Combine scheduling and gating by implementing both `ScheduledCronServiceInterface` and `TimeControllingCronServiceInterface`.
- Have multiple independent cron jobs, each with its own schedule, collected automatically by tag.
- Run one specific job on demand from custom code with `CronServiceManager::executeHandler($id)`.
- Force a specific job to bypass its schedule on the next cron run with `forceNextExecution($id)`.
- Immediately run a job regardless of schedule from a Drush script or controller with `executeHandler($id, TRUE)`.
- Read when a job is next due with `getScheduledCronRunTime($id)` for reporting.
- Read when a job last ran with `getLastExecutionTime($id)`.
- Check whether a job is currently flagged to be forced with `isForced($id)`.
- Enumerate all registered cron services with `getHandlerIds()` (used to build admin listings).
- Send an email or alert when a cron job fails by subscribing to `CronServiceErrorEvent` (`cron_service_error_event`).
- Keep cron resilient: isolate failures so one broken job does not stop the others from running.
- Unit-test cron logic directly against the service class without bootstrapping `hook_cron()`.
- Migrate legacy queue-worker-style periodic tasks that needed finer run control than core cron offers.
- Trigger a job's next run manually from the admin UI (with the `cron_service_ui` submodule installed).
- Build a custom dashboard of cron jobs and their next-run times using the manager's read methods.
- Stagger heavy jobs across cron runs by returning future timestamps from `getNextExecutionTime()`.
