# Schema Diff — manual setup guide

**Schema Diff** (`schema_diff`) is a developer diagnostic tool that helps you
track down the *"Mismatched entity and/or field definitions"* errors that show up
on Drupal's status report. When a module's declared storage schema (from
`hook_schema` or its entity definitions) drifts out of sync with what is actually
installed in the database, core tells you *that* there is a mismatch but not
*what* differs. This module fills that gap: it shows the difference for each
affected field in a clear, tabular format so you can see exactly which columns or
definitions have changed.

It adds this detail directly to the existing **Reports → Status report** page —
there is no separate screen to visit and nothing to configure. The module works
on Drupal 9 and newer.

> **Important:** this is a **developer-only** utility and should **not be used in
> production**. Its output reveals the internal structure of your database, so
> keep it to developers and administrators on development or staging environments.
> It has no access-control features of its own.

This guide is written for a **human** using the tool. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it on a development site.

## How to use it

Once enabled, there is nothing to set up:

1. Go to **Reports → Status report** (`/admin/reports/status`).
2. Find the **entity/field definitions mismatch** section (it only appears when
   there are actually mismatches).
3. Schema Diff renders a per-field table showing the difference between the
   *defined* storage schema and the *installed* storage schema — use it to
   understand what an update hook or entity-definition change needs to reconcile.

When you have finished diagnosing, uninstall the module — it is not meant to stay
enabled on a live site.
