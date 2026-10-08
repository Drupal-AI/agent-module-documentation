# Migrate Cron — manual setup guide

**Migrate Cron** (`migrate_cron`) runs your Drupal migrations automatically on
**cron**, so a migration you would otherwise trigger by hand (or via a Drush
command) keeps running on a schedule. It is a thin scheduler layered on top of core
**Migrate** and **Migrate Plus** — the migrations themselves are defined elsewhere
(for example as Migrate Plus config entities or module-provided plugins), and this
module just decides which of them run, and how often.

From one settings form you get, for every migration on your site, an on/off "Run at
cron" toggle and a per-migration interval in seconds. Enable a couple of feed
imports, give one an hourly interval and another a daily one, and Migrate Cron takes
care of running each when it is due. It also resets a stuck migration to idle before
running it, so a migration left mid-run gets restarted on its next due tick.

Typical uses: keep content in sync with an external JSON/XML/CSV feed, periodically
re-import price or inventory lists, or refresh a dataset that backs a search index —
all without writing a custom cron hook.

This guide is written for a **human** clicking through the admin UI. If you want a
terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it requires
   Migrate and Migrate Plus) and enable the module.
2. [Configuration](configuration/index.md) — the per-migration settings form and
   how the cron run works.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Migrate Cron**
(`/admin/config/system/migrate-cron`). It uses the core **Administer site
configuration** permission.
