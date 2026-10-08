# Taxonomy Overview — manual setup guide

**Taxonomy Overview** (`taxonomy_overview`) is a taxonomy auditing and clean-up
toolkit. It lists all the vocabularies on your site in one place, shows where each
term is actually used (in content types, paragraphs, and other entities), finds
unused or near-duplicate terms, and lets you merge duplicates into one canonical term
— safely updating every reference as it goes.

The problem it solves is taxonomy sprawl. On a mature site, vocabularies accumulate
stray, misspelled, and overlapping terms, and it becomes hard to know which are used,
which are safe to delete, and which are really the same thing under two names.
Taxonomy Overview gives you a health dashboard, usage reports, and a governed
workflow to fix all of that with confidence rather than guesswork. Its clean-up and
merge operations are built to be careful: you preview before you delete, dry-run
first, and confirm destructive actions explicitly.

Recent versions add a **governance-first action plan workflow**: clean-ups and merges
become reviewable *action plans* that move through a status lifecycle (pending →
approved → running → completed, with failed / cancelled / retry states), gated by an
approval step and separated by role-based permissions so one person can create a plan
and another approves and executes it. There are CSV exports for action plans, top
terms, and unused terms, plus dashboard recommendations and cron-based alerts. It
depends on core **Taxonomy** and **Node**, and on the contributed **Paragraphs**
module (`paragraphs:paragraphs`) so merges can update paragraph references too. It
also ships **Drush commands** for scripted clean-ups and merges.

Because this module can **delete and re-reference content at scale**, treat it as a
powerful admin tool: restrict its permissions to trusted taxonomy administrators, run
clean-ups and merges with `--dry-run` first on large datasets, and use the approval
and execution permissions to separate duties by role.

This guide is written for a **human** using the admin UI. If you are an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and run any database updates.
2. [Configuration](configuration/index.md) — the trend settings form and the
   permissions that govern the workflow.

## Where it lives in the admin menu

The tools live under **Reports**, not Configuration. The main entry point is the
**Taxonomy Insights** dashboard at `/admin/reports/taxonomy`, with these related
pages:

- `/admin/reports/taxonomy` — Insights dashboard (health score, per-vocabulary
  summary, quick actions).
- `/admin/reports/taxonomy/action-plans` — the action plan listing (with filters,
  pagination, and CSV export); individual plans live at
  `/admin/reports/taxonomy/action-plans/{plan}` with `approve`, `execute`, `cancel`,
  and `retry` sub-paths.
- `/admin/reports/taxonomy/unused-terms` — the Unused Terms report, with
  `/unused-terms/cleanup` for the safe clean-up flow.
- `/admin/reports/taxonomy/top-terms/all` — the Top Terms report.
- `/admin/config/system/taxonomy-trend-settings` — the trend settings form (see
  [Configuration](configuration/index.md)).

## How to use it

Start on the **Insights dashboard** to read the taxonomy health score and the
per-vocabulary summary. From there:

- Open the **Unused Terms** report to find terms nothing references; filter by
  vocabulary or name, preview the terms, and run the dry-run-first clean-up, which
  creates a reviewable action plan before anything is deleted.
- Use **Similar Terms and Merge** to let the module group near-duplicate terms by
  normalized similarity, suggest a canonical term based on usage, preview the
  per-bundle impact (with optional bundle exclusions), and merge — updating
  references in nodes and paragraphs.
- Manage everything through the **Action Plans** listing: approve, execute, retry, or
  cancel plans, and export to CSV for the record.

For scripted work, the module provides Drush commands:

```bash
drush taxonomy-overview:cleanup-unused
drush taxonomy-overview:similar-groups <vid> --threshold=80
drush taxonomy-overview:similar-merge <vid> --threshold=80
```

Useful options include `--dry-run`, `--vid`, `--min-size`, and `--remove-merged`.
Always run clean-ups and merges with `--dry-run` first on large datasets.
