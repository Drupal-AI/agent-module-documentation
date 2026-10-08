# Cron Timing — manual setup guide

**Cron Timing** (`cron_timing`) lets an administrator add extra cron run-interval
options to Drupal's core Cron settings. Core ships with a fixed set of choices in
the "Run cron every" dropdown; if none of them fit — perhaps you want cron to be
eligible to run every minute, or every two or five minutes for a time-sensitive
queue — Cron Timing lets you define your own intervals (in seconds) that then
appear as additional choices in that dropdown.

You enter the intervals you want on a small admin form as a comma-separated list of
seconds (for example `60,120,360,900`). The module validates the input to make sure
it is only digits and commas, stores it, and merges the values into the core Cron
settings dropdown — converting each one into a human-readable label (minutes, hours,
days). You then pick the interval you added on the normal Cron settings page. The
module ships with `300,900` (5 and 15 minutes) as defaults.

This is purely a small configuration convenience. The admin form is gated by the
**Administer administration pages** permission, the interval list is stored in
exportable configuration, and there are no other endpoints — so the attack surface
is minimal. It supports Drupal 8, 9, and 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add your custom intervals and then
   select one on the core Cron settings page.

## Where it lives in the admin menu

The module's own form is at **Configuration → System → Cron Timing**
(`/admin/config/system/cron_timing`, route `cron_timing.cron_timing`). The intervals
you add there appear in the core Cron settings dropdown at **Configuration → System
→ Cron** (`/admin/config/system/cron`).
