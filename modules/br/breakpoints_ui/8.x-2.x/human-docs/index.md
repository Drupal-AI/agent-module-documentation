# Breakpoints UI — manual setup guide

**Breakpoints UI** (`breakpoints_ui`) is a read-only admin overview that
discovers and displays every breakpoint defined across your installed themes and
modules. It works by parsing their `*.breakpoints.yml` files and listing what it
finds — breakpoint groups, media queries, labels, machine names, and pixel
multipliers — in one table. Drupal core has no UI for breakpoints, so this simply
fills that gap for site builders and themers.

Use it to quickly audit which breakpoint groups and media queries exist on a site
without opening YAML files by hand: verify a theme's breakpoints loaded, check
retina multipliers, spot duplicated or conflicting definitions, or reference the
exact media-query strings while writing CSS. A Drush command is also provided so
you can list breakpoints from the command line.

It depends on core's Breakpoint module and supports Drupal 8.8, 9, and 10.

This guide is written for a **human** using the module through the admin UI. If
you want a terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — installing with Composer and enabling
   the module.

## A note on access

The overview route is gated by the core **Access content** permission, which is
granted to anonymous users by default — so in practice the breakpoint listing is
**public**. What it exposes is only non-sensitive breakpoint metadata (names,
media queries, multipliers) read from code — no entity or database data — so this
is a minor access-hardening note rather than a leak of anything secret. Still, if
you would rather the listing not be reachable anonymously, adjust the permission
or restrict the path.

## Where it lives in the admin menu

The overview is at **Configuration → Media → Breakpoints**
(`/admin/config/media/breakpoints`).

## How to use it

Enable the module and open the overview page. You will see every breakpoint the
site knows about, gathered from installed themes and modules, in a single table.
Because it is read-only, there is nothing to save — it is a reference and audit
tool. From the command line, the module's Drush command lists the same
information, which is handy for documentation or CI checks.
