# WebProfiler — manual setup guide

**WebProfiler** (`webprofiler`) brings the Symfony Profiler experience to Drupal.
Once enabled it collects a detailed picture of *every* request — the database
queries that ran (with timings), which services and event subscribers were
involved, the matched route, request time and memory, cache activity, forms,
rendered Views and blocks, mail that would have been sent, calls made to AI
providers, and much more — and presents it two ways: a **toolbar** at the bottom
of every HTML page, and a full **dashboard** under Reports.

It's the tool you reach for when you want to understand *why* a page is slow or
what a request is actually doing. From the database panel you can see and even run
`EXPLAIN` on slow queries; from any file reference you can jump straight into your
IDE. It's part of the Devel family and depends on the **Devel** and **Tracer**
modules.

One thing to be crystal clear about: WebProfiler is a **development tool and must
not be run in production**. To collect its data it replaces and instruments
several Drupal subsystems, which adds overhead and exposes internal details. Use
it on local and staging environments only, and gate access with its permissions.

The module works as soon as it's enabled — the toolbar appears immediately — but a
settings form lets you tune what's collected and shown, and a few extra features
(time metrics, disabling the custom error page) are opt-in via `settings.php`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Devel/Tracer dependencies.
2. [Configuration](configuration/index.md) — the settings form plus the optional
   `settings.php` switches.

## Where it lives in the admin menu

The settings form is at **Configuration → Development → Devel → WebProfiler**
(`/admin/config/development/devel/webprofiler`), config object
`webprofiler.settings`. The per-request dashboard is at **Reports → Profiler**
(`/admin/reports/profiler`), which also lists previously saved profiles by token.

## How to use it

Browse your site as normal while logged in as a developer. A toolbar appears at
the bottom of each HTML page summarizing the request; click any segment to open
that request's full profile in the dashboard, where each collector (Database,
Services, Routing, Time, Memory, Cache, Forms, Views, Blocks, Mail, AI, and so on)
has its own panel. Which segments show in the toolbar is controlled by the
`active_toolbar_items` setting. Some collectors only appear when their host module
is present — the **AI** panel when the `ai` module is enabled, **Messenger** when
`sm` is enabled, **Logs** when `monolog` is enabled, **Views** when `views` is on,
and **Blocks** when `block` is on. Access is gated by two permissions:
`access webprofiler` (the dashboards, reports and settings — keep this restricted)
and `view webprofiler toolbar`.
