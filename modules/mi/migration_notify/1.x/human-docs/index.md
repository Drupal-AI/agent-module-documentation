# Migration Notify — manual setup guide

**Migration Notify** (`migration_notify`) sends notifications based on the status
and outcome of your migrations, so your team learns how a migration went without
anyone having to log in and check. When a migration completes, fails, or has
errors, the module fires off a notification — currently over **email** or
**Slack**.

It's aimed at production and scheduled/automated migrations, where you want to be
alerted rather than babysitting. It can send notifications instantly, or check
migration status on **cron**. Because Drupal migrations have no built-in "stuck"
status, the module infers one: if the same migration is not idle between two
checks, it treats it as potentially stuck and can alert you. One consequence of
that heuristic is worth keeping in mind — if cron runs more often than a migration
can complete, or you check too frequently, you may get false-positive "stuck"
alerts.

You configure the recipients and triggers on a settings form (see
[Configuration](configuration/index.md)) — so it needs setup before it does
anything useful. It depends on Drupal core's **Migrate** module. Since
notifications can include migration status detail, make sure the recipients are
appropriate.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose the notification channels,
   recipients, and how the checks are triggered.

## Where it lives in the admin menu

Migration Notify's settings live at the `migration_notify.settings` configuration
form in the admin UI, where you set up the notification channels, recipients, and
triggers. See [Configuration](configuration/index.md) for the walkthrough.

## How to use it

1. Enable the module (core Migrate is required).
2. On the settings form, choose your notification channel(s) — email and/or Slack
   — and enter the recipients.
3. Decide whether notifications should be sent instantly or checked on cron.
4. Run your migrations as usual. When a migration finishes, fails, or (per the
   status heuristic) appears stuck, the configured recipients are notified.
