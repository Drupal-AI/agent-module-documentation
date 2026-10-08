# Migrate Sandbox — manual setup guide

**Migrate Sandbox** (`migrate_sandbox`) is a UI where developers can quickly and
safely experiment with Migrate *process plugins* and process pipelines. Building
a migration is mostly an argument with the process pipeline — which plugins to
chain, in what order, and what `source`, `default_value`, or `callback` actually
do to a given value. Normally the feedback loop is: edit YAML, run
`drush migrate:import`, inspect, `drush migrate:rollback`, repeat. Migrate
Sandbox collapses all of that into a single form submit: you paste in some source
data and a process configuration, click **Save & Run**, and immediately see what
the pipeline produces.

To help you get started, it ships example source data and pipelines for almost
*every* process plugin in core Migrate and in the contributed Migrate Plus module
— nearly 50 plugins in all. That makes it an excellent way to grok the
hard‑to‑grok plugins like `sub_process`, `migration_lookup`, `entity_generate`,
`transpose`, and the DOM‑related ones. As of version 1.1.0 you can also populate
the sandbox from a real migration, which even allows some debugging of source
plugins.

The clever part is that nothing escapes the sandbox: it uses a custom `id_map`
that never writes to the `migrate_map` tables, errors are shown as on‑screen
messages instead of being logged to the database, and special destination plugins
render migrated entities in the UI without ever saving them. You never have to
reset a stuck migration, because the sandbox does that automatically.

**This is a development tool, and it must be treated as one.** The form executes
migrate process plugins against input *you* supply, and the available plugin set
on a real site can include things like `callback`. The single permission it
provides, `access migrate_sandbox`, is correctly marked *restricted* — granting
it is effectively granting developer access. Never enable Migrate Sandbox on a
production site, and never expose it to untrusted users. It depends only on core
**Migrate**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   the recommended companion modules.
2. [Configuration](configuration/index.md) — a tour of the sandbox form and how
   to run a pipeline.

## Where it lives in the admin menu

The sandbox is a single page at **Configuration → Development → Migrate Sandbox**
(`/admin/config/development/migrate-sandbox`). That form *is* the whole tool —
there are no separate settings to save.

## Good to know before you start

- **Recommended companions:** enable the **Yaml Editor** module for a far nicer
  editing experience, and **Migrate Plus** (with its **Migrate Example**
  submodule) since many of the built‑in examples reference plugins and migrations
  from it.
- **Sandbox escape warnings:** a handful of plugins can cause side‑effects
  *outside* the sandbox — `callback`, `download`, `file_copy`, `migration_lookup`,
  and several Migrate Plus plugins (`dom_migration_lookup`, `entity_generate`,
  `file_blob`, `service`). If your pipeline uses one, the sandbox shows a warning
  above the **Save & Run** button. You can still use them, but be aware there may
  be persistent consequences.
- **What it is not for:** it is not for running real migrations, not for debugging
  destination plugins, and it cannot exercise `track_changes` or high‑water marks.
