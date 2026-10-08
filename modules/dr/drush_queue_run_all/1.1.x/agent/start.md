<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush Queue Run All (drush_queue_run_all) — agent index

A **Drush-command-only** module. Adds one command, **`queue:run-all`** (alias `queue-run-all`), that
processes **all** registered queues in one run, optionally as a **daemon**. Package `Drush`. No routes,
controllers, permissions, entities, services, config UI or config schema. Requires PHP **8.1**, Drush
**`^12.5 || ^13.0`**, Drupal **`^10.1 || ^11`**. License GPL-2.0-or-later. Version dir 1.1.x.

- **The command: name/alias, options, how it enumerates and processes queues, exceptions, limits** →
  [commands/queue-run-all.md](commands/queue-run-all.md)

## What it actually is

- One class: `QueueRunAllCommands` (in `src/Drush/Commands/QueueRunAllCommands.php`), extending Drush's
  `DrushCommands`, using `AutowireTrait`. `const RUN_ALL = 'queue:run-all'`.
- Method `runAll()` is the command (`#[CLI\Command(name: 'queue:run-all', aliases: ['queue-run-all'])]`).
- Dependencies injected: `LoggerChannelFactoryInterface`, `QueueWorkerManagerInterface`,
  the `keyvalue` `KeyValueFactoryInterface`, the `ContainerInterface`, `QueueFactory`, `TimeInterface`.
- No `.routing.yml` / `.permissions.yml` / `.services.yml` / `.install` / `config/**` ship with the module;
  the only PHP is the command class. `composer.json` requires `drush/drush ^12.5 || ^13.0`.

## Mechanism (from source)

- Enumerates queues via `getQueues()` → `QueueWorkerManagerInterface::getDefinitions()` (static-cached).
- Per queue: `QueueFactory::get($name)` for the queue, `QueueWorkerManagerInterface::createInstance($name)`
  for the worker; runs `garbageCollection()` if the queue implements `QueueGarbageCollectionInterface`.
- Options `--time-limit`, `--items-limit`, `--memory-limit`, `--lease-time`, `--daemon`, `--queues`,
  `--exclude-queues`, `--progress`. Limits count **across all queues**; `hasReachedLimit()` checks them.
- Per-queue delays for suspended queues stored in the `queue_run_all_delays` keyvalue store, capped by
  `suspendMaximumWait` (default 30.0, overridable via the `queue.config` container parameter).
- Worker exceptions handled in `processItem()`: `RequeueException`, `SuspendQueueException` (skip/delay
  queue), `DelayedRequeueException` (delay if `DelayableQueueInterface`), other `\Exception` → log + leave item.

## Notes

- Operator-only CLI surface: anyone who can run Drush already has server access. No access-control role.
- `--queues` and `--exclude-queues` are mutually exclusive (validated in the POST_INITIALIZE hook).
