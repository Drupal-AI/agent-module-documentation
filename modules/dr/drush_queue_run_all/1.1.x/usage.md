<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drush Queue Run All adds a `queue:run-all` Drush command that processes every queue on the site in one run, optionally as a long-running daemon.

---

Drush Queue Run All is a Drush-command-only module (package `Drush`, no HTTP routes, controllers, permissions, entities or config UI). It provides a single command, `queue:run-all` (alias `queue-run-all`), implemented by `QueueRunAllCommands::runAll()`. The command enumerates every registered queue worker via the `QueueWorkerManager` plugin manager and processes each queue's items with its worker, honoring the same worker exceptions core's `queue:run` does (requeue, delayed requeue, and suspend, including per-queue delays capped by a `suspendMaximumWait` of 30s). Its `--time-limit` and `--items-limit` count across all queues combined; it adds a `--memory-limit` (size like `200M` or a percentage like `60%`) and a `--daemon` mode that keeps running until a limit is hit or indefinitely. `--queues` / `--exclude-queues` restrict which queues run (mutually exclusive), and `--progress` shows a progress bar. Requires PHP 8.1, Drush `^12.5 || ^13.0`, and Drupal `^10.1 || ^11`. It is a DevOps/automation tool: queue items run with the site's own privileges, exactly as cron-driven queue processing does.

---

- Drain every queue once from the CLI: `drush queue:run-all`.
- Replace a cron job that ran `drush queue:run <name>` for each queue with a single command.
- Run queues continuously as a daemon: `drush queue:run-all --daemon`.
- Process queue items as fast as possible instead of only on each cron run.
- Cap a run to a wall-clock budget across all queues with `--time-limit=60`.
- Cap a run to a total item count across all queues with `--items-limit=500`.
- Stop before exhausting memory with `--memory-limit=200M`.
- Stop before consuming a share of the PHP memory limit with `--memory-limit=60%`.
- Set how long a claimed item stays leased with `--lease-time=120`.
- Restrict a run to specific queues with `--queues=cron_example,my_worker`.
- Exclude noisy or slow queues with `--exclude-queues=aggregator_feeds`.
- Show a progress bar during a run with `--progress`.
- Run a bounded daemon that exits after N items so a supervisor restarts it fresh: `--daemon --items-limit=1000`.
- Deploy the daemon under systemd so it restarts automatically on failure.
- Deploy the daemon under Supervisord (or RoadRunner) as an always-on process.
- Recycle daemon workers after a deploy so new code is picked up (old code lingers in memory).
- Let per-queue `SuspendQueueException` delays skip a temporarily unavailable queue and move on to the next.
- Let workers requeue or delay items (RequeueException / DelayedRequeueException) without aborting the whole run.
- Keep processing other queues even when one worker throws, logging the error and leaving that item for later.
- Run garbage collection on queues that support it before processing them.
- Combine limits, e.g. `--daemon --memory-limit=60% --time-limit=3600`, for a self-terminating background runner.
- Use in local/CI scripting to flush all pending background work before assertions or a snapshot.
