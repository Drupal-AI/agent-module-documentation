# New Relic Transactions — manual setup guide

**New Relic Transactions** (`newrelic_transactions`) renames the transactions that
New Relic records for your Drupal site, so its dashboards actually tell you
something. Out of the box New Relic sees `index.php` for every request, so a whole
Drupal site's traffic collapses into a single bucket and the dashboard reports one
average response time — true, and useless. This module names each transaction by
the request's **route**, the **entity bundle**, and the visitor's
**highest-weight role** instead.

Those three dimensions are deliberately chosen. **Route** separates pages from each
other. **Bundle** separates node pages by content type — where the real
performance differences live, because one type may have forty fields and another
three. And **highest-weight role** separates the anonymous request served from
cache from the editor's request that rebuilds everything, which is the single most
common reason an average misleads. For entity routes, the id placeholder is
replaced with the entity type, keeping the transaction names low-cardinality — an
important detail, since APM tools charge and aggregate by distinct transaction
name, and a scheme that included raw entity ids would bury the signal in noise.

Two things are worth knowing. This module requires the **New Relic PHP extension**
to be installed and active — it feeds names to New Relic through that extension, so
without it there is nothing to name. And putting the role in a transaction name is a
small disclosure to whoever reads the APM: it reveals which roles exist and how
traffic distributes across them. That is unremarkable for most sites, but worth a
moment's thought where the role names themselves are sensitive.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, make
   sure the New Relic PHP extension is present, and enable it.

The module has a small settings form (see below), but it works sensibly once
enabled — the naming scheme is applied automatically.

## Where it lives in the admin menu

Its settings form is at **Configuration → Development → New Relic Transactions**
(`/admin/config/development/newrelic-transactions`). After enabling and
configuring it, check the **Status report** (`/admin/reports/status`) to confirm the
module reports that it is functioning correctly — this is also where you will see a
warning if the New Relic PHP extension is missing.

## How to use it

1. Confirm the **New Relic PHP extension** is installed and active on your server
   (see [Installation](installation/index.md)).
2. Enable the module, then visit **Configuration → Development → New Relic
   Transactions** (`/admin/config/development/newrelic-transactions`) to review its
   settings.
3. Open the **Status report** (`/admin/reports/status`) to verify the module is
   healthy and the extension is detected.
4. Generate some traffic, then open your New Relic APM dashboard. Transactions
   should now be named by route, bundle, and role instead of `index.php`.
