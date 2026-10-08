# Codit Batch Operations — manual setup guide

**Codit Batch Operations** (`codit_batch_operations`) is a framework for defining
and running **batch jobs** in Drupal — the one-off and repeatable data operations
every project accumulates: re-save every node so a computed field populates,
migrate a field's values into a new structure, clean up after an import, backfill
something a deployment forgot. Written as ad-hoc Drush scripts these jobs are
unrepeatable, unlogged, and known only to whoever wrote them. This module turns
each one into a defined operation with a name, ways to run it, and a record that
it ran.

You write batch-operation scripts as PHP classes in a local/custom module, and
then run them in whatever way suits the situation: from `hook_update_N()`,
`post_update` functions, Drush deploy and post-deploy hooks, a Drush command
(`drush codit-batch-operations:run {script class}`), cron, or an optional UI.
Every run is recorded in a **BatchOpLog** entity — and crucially, if an operation
is interrupted (an error, an exception, Ctrl-C, navigating away), it is still
logged and its state is kept, so the next run picks up where it left off.

**The value is as much in the record as in the running.** "Did anyone run the
backfill on production?" is a question that costs hours when the answer lives in
someone's shell history and minutes when there is a list of operations and when
each last ran.

Two things are worth being deliberate about:

- **A batch operation is arbitrary code that modifies content at scale.** Who may
  run one is therefore a serious permission — closer to *administer site
  configuration* than to a content permission — and should be treated that way
  regardless of the module's default.
- **A batch that touches thousands of entities has no undo.** Run it against a
  copy first, make each operation idempotent so a re-run is safe, and log what it
  changed rather than only that it ran.

It has no dependencies beyond Drupal core and supports Drupal 10 and 11. It
provides permissions for managing the configuration, viewing batch-operation
logs, and executing scripts via the UI, and it ships an optional **UI submodule**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally enable the UI submodule.
2. [Configuration](configuration/index.md) — point the module at your scripts
   module, set the acting user, and assign permissions.

## Where it lives in the admin menu

The settings form sits at
`/admin/config/development/batch_operations/settings`. With the UI submodule
enabled, you run operations and view their logs at
`/admin/config/development/batch_operations`.
