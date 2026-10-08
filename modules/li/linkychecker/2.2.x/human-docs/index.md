# Linkychecker — manual setup guide

**Linkychecker** (`linkychecker`) checks the links managed by the
[Linky](https://www.drupal.org/project/linky) module and records whether each one
still resolves — catching broken or dead URLs (like 404s) so editors can find and
fix them. It's the link-verification companion to Linky's link management: Linky
stores your links as *Managed Link* entities, and Linkychecker keeps an eye on
their health.

By default, a link is checked when it's first created and then re-checked on an
interval; you can also trigger a check **on demand**. The recorded status is
visible per link and is available as **Views fields**, so you can build your own
broken-links report or column in a listing. The module also provides **Drush
commands** for running checks from the command line or cron, which is the sensible
way to run them at scale.

A word on how link checkers behave in general: verifying a link means making an
**outbound HTTP request** to the linked URL from your server. That's normal, but
it is real traffic to other people's sites, so run checks on a reasonable schedule
rather than hammering targets. The broken-link results are administrator-facing.
Linkychecker requires **PHP 8.1** and provides its own permissions; it has no
access-control role beyond those permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside Linky
   and enable.
2. [Configuration](configuration/index.md) — checking behaviour, permissions,
   running checks, and viewing results.

## Where it lives in the admin menu

Linkychecker works on your Linky (Managed Link) entities. Checking behaviour is
configured in the module's settings, permissions are granted under **People →
Permissions**, results are exposed as **Views fields**, and checks can be run via
**Drush** or on demand. See [Configuration](configuration/index.md).
