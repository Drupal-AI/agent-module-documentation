<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tasks, the terminate subscriber & the Drush command

## Install & enable

```bash
composer require drupal/afterburner
drush en afterburner -y
```

Pulls in `spatie/async ^1.8` (parallel PHP process pool). No config UI — Afterburner is used by subclassing its
bases in your own module. Spawned workers require a CLI `php` and a reachable Drush binary.

## `Task\TaskBase` (abstract)

Extends `Spatie\Async\Task`. A task is an object that runs in a forked PHP process:

- Constructor captures `context = { host: \Drupal::request()->getHost(), site_path: <site.path param>,
  app_root: DRUPAL_ROOT }`.
- `configure()` (called in the child before `run()`): sets `$_SERVER['HTTP_HOST']`, builds a request from
  globals, requires `autoload.php`, and boots a `DrupalKernel` (`prod`, from the captured app root/site path)
  with `->boot()->preHandle($request)` — so the task has a full Drupal container in the worker.
- `__invoke()` calls `parent::__invoke()` then `kernel->terminate($request, new Response())`.

Implement your own task by extending `TaskBase` and defining `run(): void` (see `afterburner_queue`'s
`QueueItemTask` for a concrete example).

## `EventSubscriber\AfterburnerTasksSubscriberBase` (abstract)

An event subscriber on `KernelEvents::TERMINATE` (`getSubscribedEvents()` → `terminate`). Fields with setters:
`uri` (''), `concurrency` (20), `timeout` (300), `sleepTime` (50000), plus `callbackClass` and `id`. Also
`private const DRUSH_BINARY = DRUPAL_ROOT . '/../vendor/bin/drush'` and `COMMAND = 'afterburner:process-tasks'`.

- `processTasksOnTerminate(Event $event)` sets an internal flag (call it to arm the subscriber for the current
  request).
- `terminate()`: returns unless armed. Builds a shell command from `php_binary` (Settings or `PHP_BINARY`), the
  Drush binary, the command, an optional `--uri=`, and `callbackClass` / `id` / `concurrency` / `timeout` /
  `sleepTime` — every value passed through `escapeshellarg()` — then runs it via
  `Process::fromShellCommandline($command)->run()`.
- Subclasses must implement `static getTasks(int $id): array` returning the `TaskBase` instances to run.

Typical use: your subclass calls `processTasksOnTerminate()` / setters during the request (e.g. from another
event or service) so that, after the response is sent, `terminate()` launches the Drush worker command.

## Drush command `afterburner:process-tasks`

`Commands\AfterburnerCommands::processTasks(string $callbackClass, int $id, int $concurrency, int $timeout,
int $sleepTime)` (registered via `drush.services.yml`, tag `drush.command`):

```bash
drush afterburner:process-tasks '\Drupal\my_module\MySubscriber' 42 20 300 50000
```

Creates a Spatie `Pool` (`concurrency` / `timeout` / `sleepTime`, `withBinary(php_binary)`), calls
`call_user_func([$callbackClass, 'getTasks'], $id)`, `$pool->add($task)` for each, and `$pool->wait()`. This is a
CLI entry point — the `callbackClass` is your own subscriber/task-provider class name.

## Notes

- Everything runs from CLI (Drush) or after the response on `kernel.terminate`; there is no HTTP route.
- Each task re-boots Drupal, so per-task overhead is a full bootstrap — batch work accordingly and tune
  `concurrency`/`timeout` to the host.
