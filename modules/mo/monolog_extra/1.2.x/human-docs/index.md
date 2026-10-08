# Monolog Extra — manual setup guide

**Monolog Extra** (`monolog_extra`) adds a handful of extra **handlers and
processors** to the [Monolog](https://www.drupal.org/project/monolog) logging
module. Monolog itself is a framework for routing Drupal's log records to
different destinations (files, syslog, chat services, and so on) and for
enriching each record with extra context. Monolog Extra fills a specific gap:
it provides handlers and processors aimed at particular use cases that are too
narrow to live in the generic Monolog module.

In practice you reach for this module when the handlers and processors that ship
with Monolog aren't quite enough — you want to route log records in a new way,
or attach extra context to each entry. It is a **developer/logging tool**: it
adds no content, no pages, and plays no access-control role. Its only dependency
is the Monolog module.

There is **no settings form and no admin page**. Everything Monolog Extra
provides is wired up the same way you configure Monolog itself — in your
Monolog channel/handler configuration (typically a `monolog.services.yml` file
and settings in `settings.php`). See the Monolog module's own README for how
that file is structured; Monolog Extra simply makes additional handler and
processor services available to name there.

One word of caution that applies to all logging: processors that add request or
context data to a log record can inadvertently capture **sensitive information**
(user data, tokens, request details). Scrub or avoid logging anything sensitive.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Monolog.

There is **no configuration page** for this module — it has no settings form. You
enable the extra handlers and processors from your Monolog channel configuration,
described above.

## Where it lives in the admin menu

Monolog Extra adds no admin page. It is configured entirely in your Monolog
service/handler configuration files, exactly like the base Monolog module.
