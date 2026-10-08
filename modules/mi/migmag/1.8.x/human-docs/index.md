# Migrate Magician — manual setup guide

**Migrate Magician** (`migmag`) is a developer toolset for building and running
Drupal migrations — especially the big Drupal 7 → 10/11 upgrade jobs — more
reliably. It is a companion to core's Migrate system, so you only need it when
core Migrate is already in play. There is no page to click through and nothing to
switch on for a site editor; the value is in the PHP helpers, migrate plugins, and
rollback-capable destination plugins it gives migration developers.

The **base `migmag` module has no configuration, no admin UI, no plugins, and no
services of its own.** It is a library of static PHP helper classes plus a reusable
trait that the submodules — and your own migration code — build on. For example,
`MigMagArrayUtility` inserts or moves keys inside an array (handy for surgically
re‑ordering a migration's `process:` pipeline), `MigMagMigrationUtility` normalises
a pipeline to associative form and rewrites `migration_lookup` references across a
definition, and `MigMagSourceUtility` instantiates a source plugin from a
definition array.

All of the real, user‑visible functionality ships in **submodules**, and each one
is enabled independently — you turn on only the pieces a given project needs. They
add extra process plugins and an improved migrate‑stub service, force core's
`migration_lookup` to use the smarter `migmag_lookup`, add rollback support to
core destinations that normally can't be rolled back, fix core's menu‑link
migrations, and backport core 9.2's `callback` process plugin to older cores. See
[Installation](installation/index.md) for the full submodule table.

This guide is written for a **human** reading through the setup. If you want terse,
token‑cheap references for an AI coding agent — including the full helper API — read
the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and pick the submodules you need.

## Where it lives in the admin menu

Nowhere. Migrate Magician has no admin pages, no settings form, no permissions, and
no Drush commands. Once enabled it simply makes its helpers, plugins, and (for the
rollback submodules) database tables available to your migrations.

## How to use it

You use Migrate Magician from **migration code**, not from the admin UI:

- **The helper library (base module).** Call the static utilities from custom
  tooling or tests — insert a step in front of an existing one with
  `MigMagArrayUtility::insertAfterKey()`, re‑order pipeline keys with
  `moveInFrontOfKey` / `moveAfterKey`, normalise a shorthand `plugin: x` pipeline
  into associative form, bulk‑rewrite `migration_lookup` references when renaming
  or splitting migrations, or strip references to migrations that don't exist yet
  so a partially‑built site still validates. The full list is in the agent docs at
  [`agent/api/utilities.md`](../agent/api/utilities.md).
- **Extra process plugins (`migmag_process`).** Once that submodule is enabled you
  can use plugins such as `migmag_lookup` (create valid stubs for references that
  resolve to a translation or a specific revision), `migmag_try` (wrap a fragile
  sub‑pipeline in try/catch with a fallback), `migmag_compare`,
  `migmag_target_bundle`, `migmag_get_entity_property`, `migmag_uuid_generate`, and
  `migmag_logger_log` directly in your migration YAML `process:` blocks.
- **Rollback support (`migmag_rollbackable` / `migmag_rollbackable_replace`).**
  Enable these to gain rollback‑capable versions of core destination plugins (for
  config, theme settings, colors, display components) so a completed migration can
  be rolled back cleanly instead of leaving orphaned config behind — the `_replace`
  submodule swaps them in across every migration without editing a single YAML file.

Because every submodule works on its own, enable only what a project needs.
