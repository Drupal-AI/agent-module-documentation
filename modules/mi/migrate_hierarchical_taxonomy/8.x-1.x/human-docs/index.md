# Migrate Hierarchical Taxonomy — manual setup guide

**Migrate Hierarchical Taxonomy** (`migrate_hierarchical_taxonomy`) adds Migrate
support for importing a **nested taxonomy tree** — terms with parent/child
relationships to unlimited depth — from a source system into a Drupal
vocabulary. Migrating a flat list of terms is easy; faithfully reproducing a deep
category tree (categories with sub‑categories, several levels down) needs extra
handling, and that is the gap this module fills.

You use it inside a taxonomy‑term migration definition when the source data
carries a hierarchy you need to preserve on the Drupal side. It is a
developer/site‑builder tool that runs through the Migrate framework (typically
driven by Drush), not a runtime feature your site visitors ever see. The terms it
creates are content derived from your source, so validate the source data before
you import.

It depends on core **Migrate** (`migrate`), the contributed **Migrate Plus**
module (`migrate_plus`), and core **Taxonomy** (`taxonomy`). It supports Drupal 8
through 11. There is nothing to configure through the admin UI — the module works
by providing migration handling you reference from your migration YAML.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Migrate, Migrate Plus, and Taxonomy.

There is **no configuration page** for this module. It has no settings form; you
consume it from migration YAML as described below.

## How to use it

Migrate Hierarchical Taxonomy is consumed entirely from a migration definition,
not from an admin screen. In practice you:

1. Define a taxonomy‑term migration (source, process, destination) as you
   normally would for a vocabulary.
2. Order or structure your source so that parent terms and their children are
   related in a way the migration can resolve — the module's handling then
   preserves the parent/child nesting to unlimited depth as terms are created.
3. Run the migration with Drush (for example `drush migrate:import <id>`) and
   review the resulting vocabulary to confirm the tree matches the source.

Because it relies on **Migrate Plus**, keep your migration definitions in the
configuration/YAML style that Migrate Plus provides. Always test the import on a
copy of the site first and keep a database backup before importing into
production.
