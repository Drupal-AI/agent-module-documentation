# Paragraphs Report — manual setup guide

**Paragraphs Report** (`paragraphs_report`) builds an inventory of which Paragraph
types are used on which pages of your site. If you build content with the Paragraphs
module, you have probably wondered "where is the *Hero* paragraph actually used?" or
"is anyone still using this old *Accordion* component?" This module answers those
questions with a filterable table and a CSV export.

You choose which content types to scan, then run an update that walks every node of
those types, descends into nested paragraph fields, and records — per paragraph type —
which nodes it appears on and what its parent is. The result is shown as a paginated,
filterable report and can be exported to CSV for a content audit or migration
planning. The scan considers only the latest revision of each node, and it recurses
into paragraphs-inside-paragraphs so nested usage is captured too.

The report is not built automatically on install — you pick your content types on the
settings tab and then click **Update Report Data** (or run a Drush command). You can
also switch on a "watch content" option so the report keeps itself current whenever
nodes are added, changed, or deleted. The module requires the **Paragraphs** module
and core's **Path alias**, adds three permissions, ships a Drush command
(`paragraphs_report:update`, alias `pru`), and stores the report data in Drupal's
key-value store rather than in configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choosing content types, the settings,
   building the report, and the permissions.

## Where it lives in the admin menu

The report is at **Reports → Paragraphs Report**
(`/admin/reports/paragraphs-report`), with a **Settings** sub-tab
(`/admin/reports/paragraphs-report/settings`) for choosing what to scan and a CSV
export at `/admin/reports/paragraphs-report/export`. Access is controlled by three
permissions covering settings, viewing/exporting, and triggering a rebuild.
