# Paragraphs Stats — manual setup guide

**Paragraphs Stats** (`ps`) answers a question every content model eventually
raises: *which Paragraph types are we actually using, and where?* It adds a
report under **Reports** that lays out every Paragraph type against every
content type (and custom block, and nested paragraph) that can hold it, counts
the real usage from the database, and colour-codes each cell into five levels so
heavily-used and dead-weight paragraphs jump out at a glance.

From that matrix you can drill down into the specific parent entities that use a
given paragraph — each with an edit link — trace where one individual paragraph
is embedded, and export the whole grid to CSV for a stakeholder spreadsheet.
It is a read-only auditing tool for trusted staff: all of its data-reading routes
sit behind a restricted permission, and the counts deliberately ignore access
checks so the numbers are complete. The module depends on the
[Paragraphs](https://www.drupal.org/project/paragraphs) module.

The report needs a one-time (and repeatable) *"Update the data structure"* step:
that scans every field that references a paragraph and records the structure into
a metrics table, which the report then counts against. Until you run it, the
report shows a "please update the data structure" notice. There is no settings
form — the module works the moment you enable it, run the update, and open the
report.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Paragraphs.

## Where it lives in the admin menu

Once enabled, the report lives at **Reports → Paragraphs stats Report**
(`/admin/reports/paragraphs-stats-report`).

## How to use it

1. Grant the **Access paragraphs stats report** permission to the roles that
   should see the report, and **Administer paragraphs stats configuration** to
   whoever may rebuild the metrics. Both are marked as restricted, so give them
   only to trusted staff.
2. Open **Reports → Paragraphs stats Report**.
3. Click **Update the data structure**. This scans every field whose target type
   is a paragraph and records the paragraph/bundle/field layout into the
   `paragraphs_stats_inuse` table. Re-run it any time you add new paragraph
   fields.
4. Read the matrix: rows are Paragraph types, columns are the content types /
   entity bundles that can contain them. Each cell shows a usage count, colour-
   coded into five levels relative to the site's own min and max, and a dash
   (`n/a`) where that pairing isn't possible. A `0` means "possible but unused."
5. Click a count to **drill down** to the parent entities that use it, each with
   an edit link, or open the per-paragraph usage view to trace one specific
   paragraph — including where it is nested inside other paragraphs or custom
   blocks.
6. Use **Export CSV** to download the same grid (link cells become spreadsheet
   `=HYPERLINK()` formulas) for reporting outside Drupal.
