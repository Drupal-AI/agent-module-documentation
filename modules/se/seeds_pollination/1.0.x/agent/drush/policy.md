<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush policy hooks

`Drush/Commands/PolicyCommands.php` (class `PolicyCommands extends DrushCommands`, namespace
`Drush\Commands`) registers Drush **validate** hooks that add safety prompts around destructive
sync/drop operations. It is loaded via `drush.yml`, whose `include:` points at a Seeds-profile
path (`public_html/profiles/contrib/seeds/modules/custom/seeds_pollination/Drush`); update hook
`8109` copies `drush.yml` into a project-level `drush/` dir. These are **local CLI-only** hooks,
not web routes.

`const DANGEROUS_ENV = ['dev', 'prod', 'live', 'stg', 'stage']`.

- `@hook validate sql:sync` → `validate()` — parses the env from the target alias
  (`explode('.', $target)[1]`); if it contains a dangerous token, prints a warning and requires
  the operator to type `"I Understand"` (recurses on a wrong answer). Uses a temp marker file
  `sys_get_temp_dir()/.bypass_rsync_warning` to coordinate with the rsync hook.
- `@hook validate core:rsync` → `validateRsync()` — same confirmation for rsync targets, with the
  marker-file/30-minute window logic to avoid an infinite loop when `sql:sync` triggers `rsync`.
- `@hook validate sql:drop` → `validateSqlDrop()` — before a drop, runs `shell_exec('drush cr')`
  and `shell_exec('drush sql-dump > {tmp}/{project}{time}.sql.gz --gzip')` to leave a gzipped
  backup in the temp dir, then reports its path.

Notes: the backup filename is derived from `$GLOBALS['ROOT']` and `time()` (not from user input).
`validateSqlDrop` uses `array_pop(explode('/', $root))` — passing a function result by reference,
a PHP deprecation on 8.x — and the drop proceeds regardless (it only makes a backup, it does not
block). These commands only run for a developer invoking Drush locally.
