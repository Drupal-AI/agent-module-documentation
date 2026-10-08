# Permissions Analyzer — manual setup guide

**Permissions Analyzer** (`permissions_analyzer`) is a security-auditing tool
that examines every role on your site and its assigned permissions, flags the
sensitive or dangerous ones, and turns the result into a risk score you can act
on. It is designed to help administrators spot privilege-escalation risks — the
over-broad roles and accidental grants that creep in over the life of a site.

From a single report it gives you a per-role risk score, an overall site-wide
security score, a breakdown of which roles hold dangerous or sensitive
permissions (categorised by severity), a count of how many users hold each role,
and a flag for roles that nobody actually holds. That combination makes it easy
to prioritise: which roles to harden first, which to prune, and where a launch
may have left too much privilege lying around.

Crucially, the module **only reads** — it never modifies permissions. It produces
an analysis report to inform your decisions; the actual changes you still make
yourself on the permissions page. There is also a machine-readable export, handy
for snapshotting your posture over time or comparing two environments. Both the
report and the export are gated by the core `administer permissions` permission,
so the site's weak spots are not exposed to unprivileged users.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no settings form** — you enable the module and read the report.

## Where it lives in the admin menu

- **Reports → Permissions Analyzer** (`/admin/reports/permissions-analyzer`) —
  the dashboard with the security indicators, per-role and global scores, and
  flagged roles.
- **Export** (`/admin/reports/permissions-analyzer/export`) — a machine-readable
  version of the analysis for record-keeping or comparison over time.

Both paths require the `administer permissions` permission.

## How to use it

1. Enable the module.
2. Visit **Reports → Permissions Analyzer** and review the global score and the
   per-role breakdown. Roles flagged as high-risk, and roles holding
   destructive permissions, are your first candidates for tightening.
3. Act on what you find on the standard permissions page — the analyzer itself
   changes nothing.
4. Use the **export** to snapshot your posture before and after a hardening pass,
   or to compare staging against production.
