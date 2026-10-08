# Cron Last Run Manipulate — manual setup guide

**Cron Last Run Manipulate** (`cron_last_run_manipulate`) is a small development
helper that lets an administrator manually change the timestamp Drupal records for
"the last time cron ran". That single value governs when automatic (automated)
cron decides it is due again — so being able to reset or set it by hand is
invaluable when you are debugging or testing cron-dependent behavior and don't want
to sit and wait for the real schedule to come around.

Typical uses are during development: force automated cron to consider itself
overdue so it fires on the next request, or reset the timestamp to reproduce a
timing-related bug. The module gives you a simple admin interface to do this
without touching the database directly, and it defines a permission so only trusted
users can change the value.

This is a **developer/debugging tool and is not intended for production sites** —
manipulating the cron timestamp on a live site can cause scheduled work to run at
unexpected times. It depends on core's **Automated Cron** (`automated_cron`) module
and supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and core's Automated Cron).

There is no ongoing settings form to configure — the module simply provides an
admin action to update the last-cron-run time, described under "How to use it"
below.

## How to use it

Once the module is enabled and you hold its permission, open its admin interface
and set (or reset) the last cron run time to the value you need for your test. With
Automated Cron enabled, pushing the timestamp far enough into the past makes cron
consider itself due, so it runs on the next page request; setting it to "now"
effectively defers the next automatic run. Because this is a development aid,
remember to leave the module disabled on production.
