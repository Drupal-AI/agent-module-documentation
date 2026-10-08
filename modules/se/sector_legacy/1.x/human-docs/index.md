# Sector Legacy — manual setup guide

**Sector Legacy** (`sector_legacy`) provides backward-compatibility support for
older features and packages that used to be part of the core **Sector**
distribution and theme. Its job is to bridge the gap between Sector 9 and Sector
10, so sites that still rely on features newer Sector builds no longer bundle can
keep working.

The problem it solves is continuity for aging Sector sites: as the distribution
moved forward, some older functionality was dropped from the main build, and this
module carries those pieces forward so a legacy site does not break. It is
compatibility infrastructure, not something a fresh site needs — the maintainers
note it **does not need to be enabled** unless your site actually uses the legacy
features it provides, and it does not help with the upgrade process itself. It is
incompatible with Drupal 9 and is meant for Drupal 10 and 11.

The base module has no runtime configuration; the actual legacy features live in
three submodules you enable only if you need them (see the table below). It has no
hard module dependencies of its own. A related project, **Sector Radix Starter**,
covers legacy sites that sub-theme the older D8/9 Radix starter theme.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable only
   the submodules your site needs.

## How to use it

Enable Sector Legacy (and the relevant submodules) only if your existing Sector
site depends on the older features. On a new site, leave it disabled — it exists to
keep legacy builds working, not to add new capability. Review whether you still
need it after each Sector upgrade.
