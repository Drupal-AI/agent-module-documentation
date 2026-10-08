# Revision Cleanup — manual setup guide

**Revision Cleanup** (`revision_cleanup`) deletes old entity revisions on a
schedule, so a site that has been saving a new revision on every edit for years
stops carrying its entire history in the database. Individually revisions are
cheap; in aggregate they can become the majority of a large site's database,
slowing backups, restores, and any query that joins the revision tables.

Drupal core has no revision-retention policy, and this module supplies one. You set
two things: how many recent days of revisions to keep in full, and how many older
revisions to retain per month. Cleanup runs through Drupal's cron and queue system.
The module is multilingual-aware and also removes the associated Paragraphs
revision data for the revisions it prunes.

**Revision deletion is irreversible.** Revisions are frequently the only record of
who changed what, which can be a compliance requirement rather than a convenience.
Decide your retention rule deliberately, test it on a copy of production, and take a
backup before the first run. See the caution in
[Configuration](configuration/index.md) before you enable cleanup.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the retention rule, understand the
   data-loss risk, and run the cleanup.

## Where it lives in the admin menu

Settings live at **Configuration → System → Revision Cleanup**
(`/admin/config/system/revision-cleanup`), gated by the **Administer site
configuration** permission.
