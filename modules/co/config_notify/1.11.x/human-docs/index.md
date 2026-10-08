# Config Notify — manual setup guide

**Config Notify** (`config_notify`) watches whether your site's *active* configuration
still matches the configuration you have exported to code, and sends a notification when
the two drift apart. On a site that manages configuration in Git, someone tweaking a
setting through the admin UI on production quietly creates "drift": the live config no
longer matches the exported files, and the next `drush config:import` will either
overwrite that change or fail outright. The usual failure mode is that nobody notices
until deploy day. Config Notify makes the divergence visible early, so a person or a team
can react before it becomes a broken release.

It sends **email and Slack notifications**, either immediately or on cron, and it depends
only on Drupal core's **Configuration Manager** (`config`) module. It works across a wide
range of core versions (`^8.8 || ^9 || ^10 || ^11`).

Two things are worth understanding before you rely on it. First, the check **needs a
trigger** — the natural place to run it is cron, because drift that is only discovered
when someone remembers to look is drift discovered on deploy day. Second, expect some
*baseline* noise: many sites always have a little expected drift (modules that write
configuration at runtime, or config you deliberately exclude with `config_ignore` /
`config_split`), so the check is worth tuning until the alerts it sends are ones you
actually care about.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.
2. [Configuration](configuration/index.md) — set up the email/Slack notifications and how
   the check is triggered.

## Where it lives in the admin menu

Once enabled, the settings form sits under **Configuration → Development → Configuration
synchronization → Notify** at
`/admin/config/development/configuration/notify`. Access is gated by core's
**Synchronize configuration** permission — a sensible reuse, since that is already the
permission that governs importing and exporting configuration.
