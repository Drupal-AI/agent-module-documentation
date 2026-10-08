# Automatic Updates — manual setup guide

**Automatic Updates** (`automatic_updates`) makes updating Drupal core safer and
easier. Instead of running Composer by hand and hoping nothing breaks, it stages the
update in a sandbox copy of your site, checks that the change is safe, and only then
syncs it into your live codebase — briefly entering maintenance mode for the final
step. You can drive it two ways: a push-button **"Update now"** flow in the admin UI,
or fully **unattended** background updates that run during cron.

Before any update runs, a suite of **validators** blocks unsafe operations — for
example downgrades, dev snapshots, updates that carry database schema changes, or
changes to files other than Drupal core. Separately, periodic **"Update readiness"**
checks look at your environment and warn you, on the status report and optionally by
email, when something would stop an update from succeeding — so you find out before
an update fails rather than after.

Automatic Updates is the contrib home of Drupal's Automatic Updates Initiative and is
slated to move into Drupal core. It builds on core's **Package Manager** module (a
required dependency) and only ever changes the `drupal/core` (or
`drupal/core-recommended`) constraint in your project's `composer.json`, so your site
stays Composer-compatible.

A note on scope: this release updates **Drupal core**. An older *Automatic Updates
Extensions* submodule once handled contrib module/theme updates, but that work has
been folded into the main module and the submodule is obsolete.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — the sandbox managers, the
individual validators, and the `StatusChecker` service — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Package Manager.
2. [Configuration](configuration/index.md) — the push-button flow, unattended cron
   updates, readiness checks, and the settings that control them.

## Where it lives in the admin menu

Automatic Updates has **no settings form of its own**. Instead it adds its options to
core's existing update screens:

- **Update settings** (unattended options) — **Reports → Available updates →
  Settings** (`update.settings`).
- **Run a push-button update** — **Reports → Available updates → Update**
  (`/admin/reports/updates/update`).
- **Readiness warnings** appear on the **Status report** (**Reports → Status report**).

Everything here is gated by core's **Administer software updates** permission — the
module defines no permissions of its own.
