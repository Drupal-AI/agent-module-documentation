# Migrate Scheduler — manual setup guide

**Migrate Scheduler** (`migrate_scheduler`) runs your migrations automatically on a time
interval, driven by Drupal's cron. Instead of remembering to run `drush migrate:import`
by hand (or maintaining a separate crontab), you list the migrations you want to run and
how often, and the module fires each one when its interval has elapsed. It can optionally
apply the equivalent of Migrate's `--update` flag (re-process rows that were already
imported) and `--sync` flag (delete destination items that have disappeared from the
source) — so it's a good fit for keeping content in step with a feed or external API.

The module is intentionally tiny: it's a single cron hook with **no admin UI, no routes,
no permissions, and no services**. All of its behavior is driven by a small configuration
array you place in `settings.php` (or `settings.local.php`), which makes it easy to use
different schedules per environment — for example faster intervals in staging than in
production. It depends only on core's **Migrate** module, and plays nicely with
**Migrate Plus** if you have it (keeping that module's "last imported" timestamp current).

Because scheduling hangs off cron, the real cadence of a migration is however often cron
actually runs on your site: a migration set to every 60 seconds will only run that often if
cron itself runs at least that frequently.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.
2. [Configuration](configuration/index.md) — the `settings.php` schedule array and its
   per-migration options.

## Where it lives in the admin menu

Migrate Scheduler has **no admin page** — there is nothing to click. All configuration lives
in `settings.php`, and the module does its work quietly on each cron run. You can watch the
results with the usual migration tools (**Manage → Reports** logs, or `drush
migrate:status`).

## How to use it

1. Make sure the migrations you want to schedule already exist and run correctly on their
   own (test them with `drush migrate:import [id]`).
2. Add a `$config['migrate_scheduler']['migrations']` array to your `settings.php`, listing
   each migration by its id with a `time` interval (and optionally `update` / `sync`). See
   [Configuration](configuration/index.md) for the exact format.
3. Make sure Drupal cron runs at least as often as your shortest interval — ideally via an
   external `drush cron` on a system crontab rather than Drupal's built-in automated cron.

From then on, each migration runs whenever its interval has elapsed. If a migration ever gets
stuck in a non-idle state, the module resets it to idle before each scheduled run, so it
recovers on its own.
