# Botlog — manual setup guide

**Botlog** (`botlog`) is a small bot-logging toolkit. It does not watch traffic
by itself; instead it gives your own code a central place to record that a
particular IP address is behaving like a bot, and it gives administrators a set
of screens to review, ban, white-list, and clean up those records. Think of it
as an IP reputation table plus a handful of report pages, wired up so several
custom modules can feed into the same log.

The heart of the module is a service (`botlog.helper`) that other code calls to
record an event against a client IP at one of four levels: white-listed,
warning, temporary ban, and permanent ban. So a firewall rule, a honeypot, or a
rate check you have written decides an IP looks suspicious, and it calls Botlog
to log and act on that decision. There is no public page that writes to the log —
writing only happens from code — which keeps the logging surface closed to
anonymous visitors.

Botlog expects a working Solr-backed Search API: it declares dependencies on the
`search_api` and `search_api_solr` modules, which the logged events are indexed
into. A Drush command is also provided so you can drive bans from cron or CI.

This guide is written for a **human** setting the module up through the admin UI
and calling its service from code. If you want a terse, token-cheap reference for
an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements (including Search API and
   Solr), installing with Composer, and enabling the module.

## Where it lives in the admin menu

All of Botlog's screens live under **Reports → Botlog** at
`/admin/reports/botlog/*`, and every one is gated by the core **Administer site
configuration** permission — so they are administrator-only. The main screen is
the monitor at `/admin/reports/botlog/monitor`. The module defines no permissions
of its own.

## How to use it

Botlog is driven from two places: your own code, and the admin screens.

**From code**, call the helper service to record events:

```php
\Drupal::service('botlog.helper')->banIp($ip, $data);      // permanent ban
\Drupal::service('botlog.helper')->warnIp($ip, $data);     // warning
\Drupal::service('botlog.helper')->whiteListIp($ip, $data); // trust an IP
```

The service can also redirect a flagged bot to an error page
(`redirectBadBot()`), check whether the current request IP is white-listed, and
expire old warning entries over time (`deleteByTime()`).

**From the admin screens** under Reports → Botlog you can list and search logged
events by full or partial IP, view a raw dump of a single event for debugging,
permanently or temporarily ban an IP, white-list a trusted IP so it is never
treated as a bot, and delete individual entries or purge everything for one IP.

Because logging is a code-only service, the value of the module comes from wiring
your own bot-detection logic to call it — a honeypot that calls `warnIp()`, a
rate check that escalates to `banIp()`, and so on — so that several modules all
report into one place.
