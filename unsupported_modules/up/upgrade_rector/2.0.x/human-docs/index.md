# Upgrade Rector — manual setup guide

**Upgrade Rector** (`upgrade_rector`) is a developer tool that runs
[Drupal Rector](https://www.drupal.org/project/rector) against your installed
custom and contrib projects and shows you the deprecation‑fix patches it
suggests, as a head start for a Drupal major‑version upgrade. It wraps the
`palantirnet/drupal-rector` command‑line tool behind an admin report so you can
review suggestions in the browser instead of running Rector yourself on the
command line.

From the report at **Reports → Upgrade Rector**, you pick one of your installed
projects (modules, themes, and profiles, grouped into "custom" and "contrib") and
click **Run rector**. The module runs Rector in `--dry-run` mode against that
extension, stores the raw output, and reformats it into a reviewable diff you can
read inline or download as a `.patch` file. It also weaves its results into the
**Upgrade Status** module's report, adding a "Patch available" / "Nothing to
patch" link per project.

Two things are important to understand. First, this is a **development tool** —
it produces *suggestions* only. It never writes patches back to your code, and it
is not a substitute for running your test suite. Second, it needs the Rector
binary available in your site's `vendor/` directory, which Composer installs as a
dependency of the module. Because of that, most teams install it only in
development/staging environments, not production.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (dev‑only note)
   and enable the module.
2. [Configuration](configuration/index.md) — the run report itself: picking a
   project, running Rector, and reading or exporting the results.

## Where it lives in the admin menu

The report sits at **Reports → Upgrade Rector**
(`/admin/reports/upgrade-rector`). Everything the module does is gated behind
core's **Administer software updates** permission, so restrict it to trusted
administrators.
