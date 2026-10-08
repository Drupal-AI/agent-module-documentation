<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# APCu Diagnostics — manual setup guide

**APCu Diagnostics** (`apcu_diagnostics`) brings the diagnostic tools from the
APCu PHP extension (`krakjoe/apcu`) into Drupal, so an administrator can inspect
the state of the APCu in-memory cache from inside the site — its memory usage,
hit/miss statistics and stored entries. APCu is commonly used as a fast cache
backend or for the class/metadata cache, and this module makes its runtime state
visible for tuning and troubleshooting.

It is purely an administration/developer diagnostic tool: it reads APCu's state
and displays it. It has no effect on your content or on site access. Because
cache internals can reveal operational detail about your server, access is gated
by the module's own permission — grant it only to trusted administrators.

The module works as soon as it is enabled; there is no settings form to
configure. It supports Drupal 9, 10 and 11, and needs the APCu PHP extension to
be installed and enabled on the server (otherwise there is nothing to inspect).

This guide is written for a **human** installing and using the module through the
admin UI. If you want terse, token-cheap references for an AI coding agent, read
the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the diagnostics permission.

## How to use it

Once enabled, and with the permission granted to your role, the module surfaces
the APCu diagnostics — the cache's memory usage, hit/miss rates and entry list —
for review. Use it to check whether an APCu-backed cache is healthy, to see how
much memory it is consuming, and to help diagnose cache performance problems
during tuning. There is nothing to save or configure; it simply reads and
displays the live APCu state each time you open it. Keep the permission
restricted to trusted administrators, since the information it shows is
operational server detail.
