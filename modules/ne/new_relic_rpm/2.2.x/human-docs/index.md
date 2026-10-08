# New Relic RPM — manual setup guide

**New Relic RPM** (`new_relic_rpm`) connects a Drupal site to the New Relic
application performance monitoring (APM) service. Out of the box New Relic sees
every Drupal request as `index.php`, which makes its dashboards nearly useless for
finding slow pages. This module fixes that and adds a lot more: it names each web
transaction after its Drupal route, lets you ignore or "background" noisy paths
(cron, health checks, admin URLs) so they don't distort your throughput stats,
can forward uncaught exceptions and watchdog log messages to New Relic, records
slow Views renders as custom Insights events, and marks deployments on your New
Relic timeline so you can correlate releases with performance changes.

The module talks to New Relic two ways. Transaction naming, ignoring, and
backgrounding go through the **New Relic PHP extension** (the `newrelic` C
extension). If that extension isn't installed, the module quietly falls back to a
no-op adapter, so your site keeps running normally — it just won't send APM data.
Deployment markers instead use New Relic's **REST API**, which needs an API key
you store in the module's settings. All behavior is driven by one settings form,
and everything is exportable configuration you can deploy across environments.

There is a companion Drush command, `drush nrd` (mark a deployment from the
command line, ideal for a release script), and two permissions: one to reach the
settings form and one to create deployments. The module requires PHP 8.0+ and
works on Drupal 10.1+ and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   the New Relic PHP extension note.
2. [Configuration](configuration/index.md) — the settings form, field by field,
   plus deployment markers and the Drush command.

## Where it lives in the admin menu

The settings form sits at **Configuration → Development → New Relic**
(`/admin/config/development/new-relic`), with a second **Deploy** tab at
`/admin/config/development/new-relic/deploy` for creating a deployment from the
UI. Access is gated by the module's *Administer New Relic RPM* and *Create New
Relic RPM deployments* permissions.

## How to use it

Install the New Relic PHP extension on your servers, enable the module, then open
the settings form to tune transaction naming, ignored/background URLs, error
forwarding, and slow-view logging. Add your REST API key if you want to create
deployment markers from Drupal or Drush. See
[Configuration](configuration/index.md).
