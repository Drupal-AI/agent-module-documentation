# Smart Migrate CLI — manual setup guide

**Smart Migrate CLI** (`smart_migrate_cli`) replaces Drupal's standard Drush
`migrate:*` commands with enhanced, multi-threaded, dependency-aware equivalents.
Enabling the module registers its own Drush command services that take over the
familiar `migrate:import`, `migrate:rollback`, `migrate:status` and related
commands, adding faster execution and fixing a number of long-standing rough edges
in how core's Drush commands run migrations.

The problems it addresses are the day-to-day frustrations of large migrations. It
runs multiple migrations across worker threads instead of one at a time; it builds
the optimal execution order automatically (so you no longer need
`--execute-dependencies`); it re-instantiates migrations right before import so that
fields, entity types, and services created by an earlier migration are actually
visible to a later one; it runs operations as user 1 rather than user 0; and it is
aware of classic-vs-complete node migration strategies and of follow-up migrations,
which core's Drush command can mishandle. A dependency graph orders dependent
migrations, progress reporting tracks totals, and helper services quiet down mail
and caching noise during long runs.

This is a **command-line tool for developers and operators** — it defines no
routes, permissions, or configuration UI, and has no web-facing surface at all. Its
access is limited to whoever already has Drush/shell access, and it runs migrations
under a chosen account via the account switcher. It requires **Drush ^11** and runs
on Drupal 9, 10, and 11.

An optional submodule, **Smart Migrate Fixes** (`smart_migrate_fixes`), adds helper
utilities that patch and normalise migration definitions.

This guide is written for a **human** running migrations from a shell. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and optionally enable the Smart Migrate Fixes submodule.

## How to use it

Once the module is enabled its commands take over the standard Drush migrate
namespace, so you run migrations the way you already do — the enhancements apply
automatically:

```bash
drush migrate:import <migration_id>
drush migrate:rollback <migration_id>
drush migrate:status --format=table
```

Additional operations are available for multi-threaded import and rollback,
single-migration import/rollback, diagnosing problems (`migrate:diagnose`),
resetting a stuck migration's status (`migrate:reset`), and configuring a
migration's runtime options. Run `drush list --filter=migrate` to see the commands
available in your installation, and pass the multi-thread options to spread a large
import across worker threads — handy inside a deployment or CI migration pipeline.
