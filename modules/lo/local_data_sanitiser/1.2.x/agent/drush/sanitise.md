<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: local-data:sanitise

Command service: `Drupal\local_data_sanitiser\Drush\Commands\LocalDataSanitiserCommands` — `local-data:sanitise` (alias `lds`).

## Usage
```
drush local-data:sanitise -y                                  # all tasks, non-interactive
drush local-data:sanitise --tasks=webform_submissions,users -y
drush local-data:sanitise --list-tasks
drush lds --entity-types=node,comment --batch-size=100
```

## Options
- `--tasks` — comma-delimited task IDs (omit → interactive per-task prompts, or all tasks non-interactively).
- `--list-tasks` — list available sanitiser tasks and exit.
- `--entity-types` — content entity types for `ContentEntityFieldsTask` (default: all eligible fieldable content entity types).
- `--batch-size` — entities processed per batch.
- `--force` — allow running when the environment is **not** detected as local.

## Safety flow
1. `getEnvironmentDescription()` determines whether the site looks local.
2. If not local and `--force` is absent → `UserAbortException` ("Refusing to run outside a detected local environment ... Re-run with --force if this database is safe to sanitise.").
3. A pre-flight warning is rendered ("permanently delete form submissions and anonymise stored personal data").
4. Interactive runs require confirmation before proceeding.

## Extending
Add an `@LocalDataSanitiserTask` plugin (base `LocalDataSanitiserTaskBase`, interface `LocalDataSanitiserTaskInterface`) implementing `preview()`/`execute()`; use the `local_data_sanitiser.field_sanitiser` service to anonymise/clear fields. Tasks are discovered by `plugin.manager.local_data_sanitiser_task`.
