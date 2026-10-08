# Cron Service — manual setup guide

**Cron Service** (`cron_service`) is a developer tool that lets you move your
`hook_cron()` logic out of `.module` files and into proper **service classes**.
Procedural cron hooks are awkward: they can't cleanly use dependency injection,
they're hard to unit-test, and there's no built-in way to control ordering or how
often a given task runs. Cron Service solves that with a service collector that
runs your tagged services on every `hook_cron()`, so each cron task becomes an
ordinary, injectable, testable class.

There is nothing to click here — this is infrastructure for developers, and it has
**no configuration form of its own**. You use it by writing a class that implements
one of its interfaces and registering it as a service tagged `cron_service`:

- **`CronTaskInterface`** declares a single `execute()` method — the entry point
  that runs on every cron.
- **`ScheduledCronTaskInterface`** adds `getNextExecutionTime(): int`, returning the
  timestamp when `execute()` should next run — so a task can space itself out.
- **`TimeControllingCronTaskInterface`** adds `shouldRunNow(): bool`, called before
  each `execute()`, which can skip the run based on the current time or environment.

An optional submodule, **Cron Service UI** (`cron_service_ui`), adds an admin
interface for managing the registered cron services. The base module has no UI.

Because cron tasks run with your site's privileges, whatever a cron service does is
exactly as trusted as the code you put in it — there's no separate security surface.
It supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally the Cron Service UI submodule.

There is no configuration page for the base module — cron tasks are defined in code,
as described under "How to use it" below.

## How to use it

1. Create a class implementing `\Drupal\cron_service\CronTaskInterface` (or one of
   its descendants) and put your cron logic in `execute()`.
2. Register that class as a service in your module's `*.services.yml` and give it
   the tag `cron_service`.
3. On the next cron run, the service collector invokes your task. For scheduled or
   conditional behavior, implement `ScheduledCronTaskInterface` or
   `TimeControllingCronTaskInterface` instead.
4. If you want to see and manage the registered cron services from the admin UI,
   enable the **Cron Service UI** submodule.
