# EDW Migrate D7 — manual setup guide

**EDW Migrate D7** (`edw_migrate_d7`) is a **developer toolkit** for building
Drupal 7-to-current migrations. It provides a set of reusable helper classes —
migration process plugins and source utilities — that take the edge off common
D7 upgrade tasks, layered on top of the standard Migrate ecosystem (core Migrate
plus Migrate Plus, Migrate Tools, and Migrate Drupal).

It is important to set expectations: this module has **no user interface and no
settings form**. It is not something a site builder configures and switches on;
it is a library of building blocks that a developer references from their own
migration definitions and code. If you are not writing migrations, there is
nothing here to click.

Operationally, treat it like any migration tooling: it processes Drupal 7 source
data with migration privileges and is run by a trusted operator. It has no
access-control role of its own — validate your sources and run migrations as you
would any privileged data import.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Migrate dependencies.

There is **no configuration page** for this module — it has no settings form. You
use it by referencing its helper classes from your own migration definitions.

## Where it lives in the admin menu

EDW Migrate D7 adds no admin page. It is used from your migration YAML/code, and
migrations are run with Drush (for example via the Migrate Tools commands such as
`drush migrate:import`).

## How to use it

1. Install and enable the module alongside the Migrate ecosystem (see
   Installation).
2. In your migration definitions, reference the helper process plugins and source
   utilities this module provides where they fit your D7-to-current mapping.
3. Run and manage your migrations with Migrate Tools' Drush commands as usual.
