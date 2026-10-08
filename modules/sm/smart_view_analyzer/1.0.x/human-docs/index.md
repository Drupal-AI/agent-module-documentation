# Smart View Query Analyzer — manual setup guide

**Smart View Query Analyzer** (`smart_view_analyzer`) helps you spot performance
risks in your Drupal Views *before* they cause trouble in production. It provides a
centralized dashboard that scans every View on the site and evaluates each one on
factors like query complexity, the number of relationships and fields, its caching
configuration, and its pager usage — then assigns a risk level of **Low, Medium,
High, or Critical** and flags the configurations that push a View into the danger
zone.

The problem it solves is that a slow View often looks fine until real traffic hits
it. Rather than discovering that during an incident, this module surfaces the likely
culprits up front — missing caching, an excessive field or relationship count,
expensive joins — so you can fix them during development, code review, or a
pre-deployment check.

Beyond the at-a-glance risk classification, each View has a drill-down **"Analyze"**
option that opens a detailed inspection: number of relationships, field count, cache
configuration status, pager usage, plus SQL-level inspection and optimization hints.
The dashboard also summarises how your Views are distributed across the risk levels.

It depends on core's **Views** module and provides its own permission. It is a
**developer/performance tool**: it inspects View definitions and query performance,
which is admin-facing work, so gate access to trusted developers with that
permission. It has no content role and no access-control role beyond that
permission, and runs on Drupal 10.3+ and 11.

This guide is written for a **human** using the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

After enabling, grant the module's permission to the roles that should run the
analyzer — treat it as a developer tool and keep it to trusted people, since it
inspects query behaviour. Then open its **dashboard** to see every View listed with
its risk level and the summary of risk distribution. For any View you want to
understand better, click **Analyze →** to open the detailed breakdown of
relationships, fields, caching, pager configuration, and the SQL-level optimization
hints.
