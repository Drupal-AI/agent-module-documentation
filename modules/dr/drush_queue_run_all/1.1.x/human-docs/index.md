# Drush Queue Run All — manual setup guide

**Drush Queue Run All** (`drush_queue_run_all`) adds a single Drush command,
`queue:run-all`, that processes **every** queue on the site in one go — instead
of naming each queue and running `drush queue:run` for it individually. It can
also run as a **daemon**, staying alive and continuously processing queue items
in the background.

This is handy in two situations. For cron-style batch processing, one command
drains all queues rather than a script listing them by name. And when you need
queue items handled as quickly as possible — not just once per cron run — the
`--daemon` mode lets you run it permanently under a process manager such as
systemd, Supervisord or RoadRunner, which restarts it automatically if it fails.

The command takes the same options as core's `queue:run`, but without the queue
name argument. Its `--time-limit` and `--items-limit` options count across *all*
queues, and it adds a `--memory-limit` option (a size like `200M` or a percentage
like `60%`) so the process stops before it exhausts memory. It's a developer /
DevOps automation tool: queue items run with the site's own privileges, so make
sure only trusted code enqueues work. It has no access-control role and nothing
to configure. This `1.1.x` release requires PHP 8.1 and Drupal 10.1+ or 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — it ships no settings form.
It is used entirely through its Drush command.

## How to use it

Drush Queue Run All adds no admin page. After enabling it, run the command from
cron or the CLI:

```bash
# Drain every queue once.
drush queue:run-all

# Keep running as a daemon, stopping before 60% of memory is used.
drush queue:run-all --daemon --memory-limit=60%
```

Key options:

- **`--daemon`** — keep running until `--items-limit`, `--lease-limit` or
  `--memory-limit` is reached, or indefinitely if none is set.
- **`--memory-limit`** — a number ending in `g`/`m`/`k` (same format as PHP's
  `memory_limit`) or a percentage; the command stops once that much memory is
  consumed.
- **`--time-limit`** / **`--items-limit`** — as in core's `queue:run`, but
  counted across all queues at once.

### Running it under a process manager

For continuous processing, run the daemon under a supervisor that restarts it on
failure. A systemd unit, for example:

```ini
[Unit]
Description=Queue runner
After=mysqld.service
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=always
RestartSec=1
ExecStart=/usr/bin/php %h/deploy/current/vendor/bin/drush queue:run-all --daemon --memory-limit=60%

[Install]
WantedBy=default.target
```

Or a Supervisord program:

```ini
[program:queue_runner]
command=/usr/bin/php vendor/bin/drush queue:run-all --daemon --memory-limit=200M
redirect_stderr=true
autostart=true
autorestart=true
numprocs=1
directory=/home/deploy/current
process_name=%(program_name)s_%(process_num)s
```

Adjust the paths to PHP and Drush and the command options to match your setup.

> **Important:** restart your queue runners after every deployment. A long-running
> daemon keeps the *old* code in memory until it restarts, which can cause very
> hard-to-debug issues. Under heavy concurrency you may also see occasional
> `SQLSTATE[40001] … Deadlock found` errors on the queue table — that's a Drupal
> core matter, not this module; see core issue #3555806 for a patch.
