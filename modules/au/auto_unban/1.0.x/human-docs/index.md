# Auto Unban — manual setup guide

**Auto Unban** (`auto_unban`) makes Drupal core's IP bans **temporary**. Out of the
box, banning an IP with core's Ban module lasts forever until someone removes it by
hand. Auto Unban changes that: each ban expires automatically after a period you
choose, and repeat offenders get progressively longer bans thanks to an exponential
back-off. It's a "self-healing" ban policy — you don't have to babysit the ban list
or remember to lift bans on shared, NAT, or dynamic IPs that were caught in the
crossfire.

The back-off works like this: the first ban of an IP lasts your base window (one
hour by default). If that IP is banned again after its previous ban already expired,
the next ban lasts twice as long — 1h → 2h → 4h → 8h, and so on. That way genuine
repeat abusers accumulate longer and longer time-outs automatically, while a
one-off offender is quietly let back in after a short window. Expiry is evaluated
live on each request, so there is no cron job or queue involved.

Auto Unban works by extending (decorating) core's ban IP manager and adding a couple
of columns to the ban table to track expiry and repeat counts. Core's ban admin page
is upgraded too — it gains sortable *Ban count* and *Expires* columns, pagination,
human-readable expiry times, and an **Add indefinitely** button for when you *do*
want a permanent ban. Drush commands (`ban`, `unban`, `banned`) mirror all of this
on the command line.

> **Important behavior change:** once this module is enabled, an ordinary ban — added
> through the UI, through code (`banIp()`), or via `drush ban` — becomes
> **time-limited by default** rather than permanent. When you genuinely want a
> permanent ban, use the **Add indefinitely** button or `drush ban <ip> --permanent`.
> (Your pre-existing bans are preserved as effectively permanent when you install the
> module, so nothing you already banned gets unbanned.)

It depends only on core's Ban module and supports Drupal 8.8 through 11. The settings
form uses core's *Administer site configuration* permission — it adds no permission
of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead — they cover the ban-manager API,
install/uninstall side effects, and the Drush commands in depth.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the base ban window, understand the
   back-off, and use the ban table and Drush commands.

## Where it lives in the admin menu

- **Settings:** *Configuration → System → Auto Unban*
  (`/admin/config/system/auto-unban`) — a single setting for the base ban window.
- **The ban list itself:** *Configuration → People → IP address bans*
  (`/admin/config/people/ban`) — core's ban page, enhanced by this module.

Both use the core **Administer site configuration** permission.

## How to use it

Enable the module, then set your base ban window on the settings page. From then on,
any IP you ban (through the UI, code, or Drush) is time-limited and released
automatically when its window passes — with each repeat ban lasting longer. Use *Add
indefinitely* / `--permanent` for the rare truly-permanent ban. See
[Configuration](configuration/index.md) for the details.
