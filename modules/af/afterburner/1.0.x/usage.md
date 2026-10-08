<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Afterburner runs deferred/background work in parallel PHP workers using Spatie Async, driven from Drush and the kernel terminate event.

---

Afterburner is a developer performance framework that brings concurrency to Drupal background processing.
Drupal's terminate hooks and default queue runners are sequential; Afterburner integrates Spatie's Async library
to fan work out across multiple PHP worker processes. It ships an abstract `TaskBase` (a Spatie async task that
re-boots Drupal inside each child process) and an abstract event-subscriber base that, on the `kernel.terminate`
event, spawns the Drush command `afterburner:process-tasks` to run a batch of tasks across a worker pool with
configurable concurrency, timeout and sleep time. The bundled `afterburner_queue` submodule adds a
`queue:run-async` Drush command that processes a named Drupal queue in parallel. You use Afterburner by
subclassing its bases in your own module — there is no admin UI or config.

---

- Offload heavy post-response work to parallel PHP workers.
- Run expensive `kernel.terminate` work without blocking the user request.
- Fan a set of tasks out across a worker pool with bounded concurrency.
- Cap each worker with a timeout to contain runaway tasks.
- Tune the pool's sleep interval between process checks.
- Re-boot Drupal inside each worker so tasks run with a full container.
- Define custom tasks by subclassing `TaskBase`.
- Trigger a task batch from an event subscriber subclassing the base.
- Run the `afterburner:process-tasks` Drush command directly for a callback class.
- Process a Drupal queue concurrently via the `afterburner_queue` submodule.
- Speed up bulk imports by parallelising per-item work.
- Parallelise cache warming or derivative generation jobs.
- Spread notification/webhook fan-out across workers.
- Keep the PHP binary configurable via the `php_binary` setting.
- Pass the site URI through to spawned workers for multisite correctness.
- Build a concurrency layer on top of existing queue workers without rewriting them.
- Use it as a foundation for a custom async processing pipeline.
