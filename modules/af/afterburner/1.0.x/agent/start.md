<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Afterburner (afterburner) — agent index

A developer framework that runs deferred/background work in **parallel PHP workers** via **Spatie Async**
(`spatie/async ^1.8`). Drives work from the `kernel.terminate` event and from Drush. No dependencies on other
modules. Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.2.

## What it provides

- **Abstract `Task\TaskBase`** — extends `Spatie\Async\Task`. In the parent it captures `host` / `site.path` /
  `app_root`; `configure()` re-boots Drupal inside the worker (`DrupalKernel::createFromRequest(...)->boot()
  ->preHandle()`); `__invoke()` runs the task then `kernel->terminate()`. Subclass and implement `run()`.
- **Abstract `EventSubscriber\AfterburnerTasksSubscriberBase`** — an `event_subscriber` on
  `KernelEvents::TERMINATE`. Setters for `uri`, `concurrency` (default 20), `timeout` (300), `sleepTime` (50000),
  `callbackClass`, `id`; `processTasksOnTerminate()` arms it; `terminate()` (when armed) shells out to the Drush
  command with all args `escapeshellarg()`-escaped. Subclasses implement `static getTasks(int $id): array`.
- **Drush command** `afterburner:process-tasks <callbackClass> <id> <concurrency> <timeout> <sleepTime>`
  (`Commands\AfterburnerCommands`, `drush.services.yml`) — creates a Spatie `Pool`, calls
  `<callbackClass>::getTasks($id)`, adds each task, and waits. PHP binary from `Settings::get('php_binary')` or
  `PHP_BINARY`.
- **Submodule** `afterburner_queue` — a `queue:run-async` Drush command that processes a Drupal queue in
  parallel. Documented under `modules/afterburner_queue/`.

No routes, permissions, config, config schema or services beyond the Drush command class. It is CLI/terminate
driven only — no web endpoint.

## Solution docs

- `TaskBase`, the terminate subscriber, the Drush command, and how to build/trigger tasks →
  [api/tasks.md](api/tasks.md)
