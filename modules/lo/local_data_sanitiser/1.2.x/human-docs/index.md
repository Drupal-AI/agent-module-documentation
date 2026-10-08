# Local Data Sanitiser — manual setup guide

**Local Data Sanitiser** (`local_data_sanitiser`) is a **command-line (Drush)
tool** for scrubbing personal data out of a *local* copy of a Drupal database. The
common situation it solves: you have pulled a production database down to your
laptop (or a staging box) to work with realistic data, but that database is full
of real people's names, emails, and form submissions. This module deletes webform
submissions and anonymises user and content-entity field values, giving you
realistic-but-safe data to develop against — useful for GDPR-safe developer and
staging databases, and before sharing a dump with a contractor.

It is deliberately **CLI-only and hidden**: there is no web UI, no settings form,
no route, and no permission. Everything happens through one Drush command,
`drush local-data:sanitise` (alias `lds`). Work is organised as pluggable
"sanitiser tasks" — deleting webform submissions, anonymising user accounts, and
anonymising fields on content entities — and a shared field-sanitiser service
detects sensitive fields by name/type and replaces them in place with
deterministic replacement text, tokenised values, and synthetic (uniqueness-safe)
emails, truncated to each field's maximum length, or clears them entirely.

The most important thing to understand is that it **modifies data in place — this
is destructive**. It overwrites the original values rather than exposing them
anywhere. To protect you from running it against the wrong database, the command
**refuses to run unless it detects a local environment**; it prints a
destructive-action warning showing the detected environment, and interactive runs
require confirmation before anything changes. You can override the guard with
`--force`, but only do so when you have confirmed the target database is safe to
sanitise.

This guide is written for a **human** working at the command line. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and (optionally) add Webform and Config Filter.

There is **no configuration page** — this module has no web UI at all. You drive
it entirely from the Drush command described below.

## How to use it

The whole tool is one command. From your local environment:

```bash
# Enable the module (it stays hidden from the Extend UI)
drush en local_data_sanitiser -y

# See which sanitiser tasks are available
drush local-data:sanitise --list-tasks

# Run all tasks non-interactively
drush local-data:sanitise -y

# Run only specific tasks
drush local-data:sanitise --tasks=webform_submissions,users -y

# Limit content-entity anonymisation to certain entity types, tune batch size
drush lds --entity-types=node,comment --batch-size=100
```

Key options:

- `--tasks` — comma-separated task IDs to run. Omit it to get interactive per-task
  prompts (or all tasks non-interactively with `-y`).
- `--list-tasks` — list the available sanitiser tasks and exit.
- `--entity-types` — which content entity types the field-anonymisation task
  should cover (defaults to all eligible fieldable content entities).
- `--batch-size` — how many entities to process per batch.
- `--force` — allow the command to run when the environment is **not** detected as
  local. Use this only when you are certain the target database is safe to
  sanitise.

### The safety flow

1. The command works out whether the site looks like a local environment.
2. If it does **not** look local and `--force` is absent, it aborts with guidance
   to re-run with `--force` only if the database is safe to sanitise.
3. It renders a pre-flight warning that it will permanently delete form
   submissions and anonymise stored personal data.
4. Interactive runs require you to confirm before it proceeds.

### Keeping it out of exported config

If you use the recommended **Config Filter** module, the sanitiser's config-filter
integration lets sanitised values flow through config export/import — handy for
keeping the module and its behaviour out of your exported production config while
still using it locally.
