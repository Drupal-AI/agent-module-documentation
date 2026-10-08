# Config Guardian — manual setup guide

**Config Guardian** (`config_guardian`) wraps Drupal's core configuration
management in a safety net for teams that deploy config changes with real stakes.
Core CMI is powerful but has no historical context and no risk assessment — Config
Guardian adds **point-in-time snapshots**, a **rollback engine**, and **impact
analysis** so you can look before you leap and undo if you slip.

The main capabilities are:

- **Instant snapshots** — capture the active config plus the sync directory in
  seconds, so you always have a known-good point to return to.
- **Safe rollback** — restore a previous snapshot, with a simulation mode and
  conflict detection that show what a restore would do before it happens. Config
  Guardian can also take an automatic snapshot before an import, making core's
  otherwise destructive import reversible.
- **Impact analysis** — a visual dependency graph showing how changing, say, a
  field storage would ripple through your views, search indexes, and form displays,
  plus an automatic **risk score** (0–100) for pending changes.
- **Integrity and audit** — SHA-256 hashing to detect corruption, detailed audit
  logs (who changed what, when), and scheduled automatic backups (hourly, daily,
  or weekly) with retention policies.

It requires core's **Configuration** (`config`) and **File** (`file`) modules and
supports Drupal 10.5+, 11, and 12. It also offers Drush commands for CI/CD
pipelines (for example `drush cg-snap` and `drush cg-rollback`).

> **Powerful, and potentially destructive — restrict access carefully.** Config
> Guardian exposes a broad set of permissions: administering it, and creating,
> restoring, viewing, deleting, exporting, and importing snapshots, plus
> synchronizing/importing/exporting configuration. Restoring or importing config
> **overwrites the site's configuration**, so grant the restore, import,
> synchronize, and administer permissions only to trusted operators.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   assign its permissions.

Config Guardian is driven from its admin dashboard and from Drush; the workflow is
described below.

## Where it lives in the admin menu

Config Guardian provides an admin dashboard for snapshots, rollback, and impact
analysis, and a set of fine-grained permissions to control who can do what. Assign
those permissions under **People → Permissions**
(`/admin/people/permissions`) before letting anyone use it.

## How to use it

1. **Take a snapshot** of your current, working configuration from the dashboard
   (or `drush cg-snap`) before making changes.
2. Make your config changes, then use **impact analysis** to see the dependency
   graph and risk score for what you're about to apply.
3. If a change goes wrong, use the **rollback engine** to restore a snapshot —
   run the simulation first to see exactly what will be restored, then apply it
   (or `drush cg-rollback`).
4. Optionally set up **automatic scheduled backups** (hourly/daily/weekly) with a
   retention policy so you always have recent restore points.
