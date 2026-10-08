# Ultimate Cron — manual setup guide

**Ultimate Cron** (`ultimate_cron`) replaces Drupal core's single, monolithic
cron run with **per-job scheduling**. Core Drupal runs every module's
`hook_cron()` implementation together in one shared window, so one slow task can
block or starve the others. Ultimate Cron turns each of those cron callbacks
into an **individually scheduled, individually runnable job** — with its own
timing rules, its own execution log, and the option to run jobs in parallel or
in the background instead of all at once.

Each job is built from three swappable parts: a **scheduler** that decides when
the job is due, a **launcher** that runs it, and a **logger** that records every
execution with its duration and status. Jobs are auto-discovered from the
`hook_cron()` implementations and queue workers already present on your site, so
after installation you will typically see one row per module, ready to schedule,
run, disable, or inspect on its own.

This guide is written for a **human** clicking through the admin UI. It walks you,
step by step and with screenshots, from installing the module to running and
scheduling individual jobs from the admin screens. If you are looking for terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

![The Cron jobs list, showing every cron job as its own row with scheduler, last run, and operations](images/jobs.png)

## Where it lives in the admin menu

Everything in this guide sits under **Configuration → System → Cron → Jobs**
(`/admin/config/system/cron/jobs`). That page is organised into tabs:

- **Cron Jobs** (`/admin/config/system/cron/jobs`) — the list of every cron job,
  with per-job operations (run, enable, disable, edit, view logs).
- **Run cron** — trigger a normal Drupal cron run from the browser.
- **Cron settings** — Drupal's core cron settings form.

## Contents

1. [Installation](installation/index.md) — install Ultimate Cron with Composer,
   enable it, and switch cron over to an external trigger.
2. [Configuration](configuration/index.md) — run jobs manually, give a job its
   own schedule, choose its launcher and logger, enable or disable jobs, and view
   the logs.
