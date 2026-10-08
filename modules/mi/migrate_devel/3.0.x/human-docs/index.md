# Migrate Devel — manual setup guide

**Migrate Devel** (`migrate_devel`) is a developer tool for debugging Drupal
migrations. When a migration produces empty, wrong, or unexpected data, the usual
struggle is that you cannot *see* what is flowing through it. Migrate Devel makes the
data visible: it dumps each row's **Source**, **Destination**, and generated
**destination IDs** to the command line as a migration runs, so you can watch the
real values move through the pipeline.

It has two independent pieces. First, it adds two options —
`--migrate-debug` and `--migrate-debug-pre` — to the migrate import command (the one
provided by Migrate Tools or Migrate Run). Run your normal import with the flag and
each row is pretty-printed with colored, indented output. `--migrate-debug` dumps
after each row is saved (including the new destination IDs, such as freshly created
node IDs); `--migrate-debug-pre` dumps *before* the row is saved.

Second, it provides a **`debug` process plugin** you drop into a migration's
`process:` pipeline like a breakpoint. It prints the value at that point and passes
it through unchanged, so you can inspect exactly what a field looks like between two
process steps. It can also dump the whole destination, all source values, or the
source IDs collected so far.

The module itself has no configuration, no permissions, no admin UI, and no settings
to clean up — you add debug output while developing and remove it when you're done.
Output only appears on the command line (`PHP_SAPI === 'cli'`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and the recommended companion modules.

## Where it lives in the admin menu

Nowhere — Migrate Devel is a command-line and migration-config tool. There is no
admin page, no settings form, and no menu entry.

## How to use it

**Watch every row as a migration runs.** Add the debug flag to a normal import:

```bash
# Dump each row's source + destination + new destination ids as the migration runs:
drush migrate:import <migration_id> --migrate-debug

# Dump source + destination BEFORE each row is saved:
drush migrate:import <migration_id> --migrate-debug-pre
```

The output is colored, indented, and only appears on the CLI.

**Inspect a value mid-pipeline with the `debug` process plugin.** Drop a `debug`
step into a field's process pipeline; it dumps the incoming value and passes it
through unchanged:

```yaml
process:
  field_tricky:
    - plugin: debug
      source: whatever
    - plugin: some_next_plugin
```

Useful keys on the `debug` plugin:

- **`dump`** — what to print: `value` (the default, passed through unchanged),
  `destination` (everything set on the destination so far), `source` (all source
  values), `source_ids`, or `source_keys`. Note that with any value other than
  `value`, the *returned* value becomes the dumped structure — so only use those on a
  step whose output you don't need to keep.
- **`label`** — a string printed before the output, e.g. `label: 'Step 1: '`.
- **`multiple`** — set `true` to tell the next step to process array values
  individually.

There is nothing to configure and nothing to clean up beyond deleting the `debug`
step when you're finished.

**A note on Migrate Plus config.** When you pass `--migrate-debug` and both
`migrate_plus` and `config_update` are installed, the module also clears cached
migration definitions and reverts each migration's config — so edits to your
`migrate_plus.migration.*` YAML are re-read on the next run.
