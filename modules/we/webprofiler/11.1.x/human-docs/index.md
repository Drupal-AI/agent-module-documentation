# WebProfiler — manual setup guide

**WebProfiler** (`webprofiler`) is a Symfony-style profiler for Drupal. For every
request it collects a wealth of detail — database queries and their timings,
which services and event subscribers ran, the matched route, request time and
memory use, cache and config activity, forms, rendered Views and blocks, mail
that would have been sent, and more — and presents it two ways: a **toolbar**
injected at the bottom of every HTML page, and a full **dashboard** under
Reports where you can drill into each request and revisit past profiles.

It is part of the Devel family and is a serious debugging companion: you can see
every query a page ran and highlight the slow ones, run EXPLAIN on a query, jump
from a file reference straight into your IDE, and diagnose performance
regressions locally before they reach production.

> **Development only.** To collect all this data, WebProfiler swaps in
> instrumented versions of several core services, which adds overhead and changes
> how subsystems behave. **Never enable it on a production site.** Keep it to
> local and development environments.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (several dependencies, PHP 8.3+, Drupal 11) and enable it.
2. [Configuration](configuration/index.md) — the settings form field by field,
   the two permissions, and the optional `settings.php` flags.

## Where it lives in the admin menu

The settings form is at **Configuration → Development → Devel → WebProfiler**
(`/admin/config/development/devel/webprofiler`). The profiler dashboard/reports
are under **Reports → Profiler** (`/admin/reports/profiler`). Access is guarded by
two permissions — see [Configuration](configuration/index.md).

## How to use it

Install and enable it in a development environment, grant yourself the profiler
permissions, and reload any page — the toolbar appears at the bottom. Click a
section of the toolbar, or open the Reports dashboard, to inspect the collected
data for that request. Then tune which panels appear and how queries are
displayed on the settings form.
