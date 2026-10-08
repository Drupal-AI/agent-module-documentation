# Upgrade Status — manual guide

**Upgrade Status** (`upgrade_status`) scans your installed modules and themes for
deprecated API usage and reports how ready your site is for the next major
Drupal version (for example Drupal 11 → Drupal 12). It runs a static analysis
(PHPStan with `phpstan-drupal` and the deprecation rules) over your custom and
contributed code to find deprecated API calls, Twig syntax, theme hooks,
libraries, routes, and `*.info.yml` metadata problems — each pointing at the
exact file and line — and it checks your **environment requirements** (PHP
version, database engine/version, and deprecated or obsolete core extensions)
against the target Drupal version. It is a **planning tool** for major-version
upgrades: it changes nothing on your site, it only reads and reports.

Everything lives on a single readiness dashboard at **Reports → Upgrade status**
(`/admin/reports/upgrade-status`). This guide is written for a **human** clicking
through the admin UI — it walks you, with screenshots, from installing the module
to running your first scan and exporting a report. If you want terse, token-cheap
references for an AI coding agent instead, read the sibling
[`agent/`](../agent/start.md) docs.

> **This is a development / planning tool.** Install it with `--dev`, use it while
> preparing an upgrade, and you can remove it once the upgrade is done. It does not
> belong in a locked-down production deployment.

![The Drupal 12 upgrade status report: environment requirements and a scannable project list with a percentage-ready indicator](images/report.png)

## Where it lives in the admin menu

The whole tool is a single report under **Reports → Upgrade status**
(`/admin/reports/upgrade-status`). The page is organised top to bottom as:

- A **summary** with three columns — *Gather data*, *Fix incompatibilities*, and
  *Relax* — plus a percentage-ready indicator showing how many projects are
  already compatible with the next major core version.
- **Drupal core and hosting environment** — the system-requirements checks (core,
  PHP, database, deprecated drivers and core extensions).
- A **scannable project list**, grouped by recommended action, listing every
  module and theme with its per-project scan result.

Reaching the report requires the **administer software updates** permission.

## Contents

1. [Installation](installation/index.md) — install Upgrade Status with Composer as
   a dev dependency and enable it.
2. [Running a scan](running-a-scan/index.md) — open the report, read the
   environment checks, scan your projects, read the per-project results, and
   export the report.
