# Scheduler for Symfony Messenger — manual setup guide

**Scheduler for Symfony Messenger** (`sm_scheduler`) integrates the **Symfony
Scheduler** component with Drupal, so you can have Symfony Messenger messages
dispatched on a recurring, cron-like schedule. In other words, a message (a unit
of background work) can be set to fire at a future time or repeatedly on a
schedule, all through the message bus.

The maintainers describe the Scheduler component as "a cron replacement on
steroids" — a clean, modern alternative to `hook_cron` for triggering recurring
work. It is used in combination with the **Symfony Messenger + Drupal** project
(`sm`), which provides the message bus this scheduler drives.

One clarification worth making: this is **not** content scheduling. It has
nothing to do with publishing or unpublishing nodes (that's what modules like
Scheduler and Scheduled Transitions do). This is developer/infrastructure
tooling for scheduling *message dispatch*.

It provides its own permissions, works on **Drupal 10.1+**, and is covered by
Drupal's security advisory policy. Extensive documentation lives in the module's
README.

This guide is written for a **human** installing the module. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Scheduler for Symfony Messenger is developer infrastructure used together with
the `sm` message bus. Once enabled, you define recurring schedules so that
Messenger messages are dispatched cron-like — at a future time or on a repeating
interval — rather than only when Drupal's cron happens to run. See the module's
README for the developer setup and scheduling details.
