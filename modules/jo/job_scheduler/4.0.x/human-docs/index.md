# Job Scheduler — manual setup guide

**Job Scheduler** (`job_scheduler`) is a developer‑facing **scheduling API** for
Drupal. It lets other modules register tasks to run once at a future time, or
repeatedly at a fixed interval or on a crontab expression, and it runs those tasks
during Drupal's normal cron process. Classic uses include unpublishing a node at a
set date, re‑importing an external feed every hour, sending a reminder email a few
days after signup, or expiring memberships nightly.

Most sites install Job Scheduler not for its own sake but because **another module
depends on it** — the Feeds module's periodic import is a well‑known example. On its
own it has no content‑facing UI; it just provides the plumbing (a service to add and
remove jobs, and cron handling to run them). If you're a developer, you declare a
named scheduler and then add jobs to it via the `job_scheduler.manager` service; the
agent docs cover that in detail.

The only end‑user screen is a small settings form that tunes how much work each cron
run does and whether run statistics are logged. Beyond that, "using" the module
means running cron regularly — every due job is dispatched on the next cron run.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent — including the service methods and
the hook you use to declare a scheduler — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Job Scheduler**
(`/admin/config/system/job-scheduler`), gated by the core **Administer site
configuration** permission. There is no other admin UI.

## How to use it

### Make sure cron runs

Job Scheduler does its work during cron. Due jobs are dispatched to their worker (or
a queue) each time cron runs, and periodic jobs are automatically rescheduled. Make
sure your site runs cron regularly (via the core cron settings, a system crontab, or
`drush cron`).

### The settings form

At **Configuration → System → Job Scheduler** you can adjust:

- **Logging** *(on by default)* — write per‑run statistics to Drupal's log, useful
  for monitoring how scheduled jobs behave.
- **Limit** *(default 200)* — the maximum number of jobs processed in a single cron
  run.
- **Time** *(default 30)* — the maximum number of seconds spent processing jobs per
  cron run.

Raise the limit and time on a busy site with many scheduled jobs; lower them to keep
individual cron runs short. The form also has a **Rebuild** button that reconstructs
the schedule information from the modules that declare schedulers — use it after
changing or adding scheduler declarations.

You can also set these with Drush:

```bash
drush cset job_scheduler.settings limit 500 -y
drush cset job_scheduler.settings time 60 -y
```

### For developers

To schedule your own jobs, declare a scheduler with
`hook_cron_job_scheduler_info()` and add jobs through the `job_scheduler.manager`
service. The [`agent/`](../agent/start.md) docs describe the service methods, the
job array shape, and the worker callback signature.
