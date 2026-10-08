# Migrate Dry run — manual setup guide

**Migrate Dry run** (`migrate_dry_run`) lets you **see what a migration would do
without actually running it**. It extends the
[Migrate Tools](https://www.drupal.org/project/migrate_tools) module by adding a
**"Dry run" option** to the migration execution screen, so you can preview the
result — how rows map, what would be created or updated — before committing to a
real import.

The problem it solves is confidence: migrations are easy to get subtly wrong, and
a dry run gives you a safe rehearsal that touches no real data. It's the natural
companion to iterating on process mappings.

Unlike most modules in this cluster, Migrate Dry run works through the **Migrate
Tools admin UI** rather than migration YAML. There's no settings form of its own —
after enabling it, a checkbox simply appears where you execute a migration. It
depends on **Migrate Tools** (`migrate_tools`) and runs on **Drupal 10 and 11**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Migrate Tools dependency.

There is **no separate configuration page** — the feature is a checkbox on the
Migrate Tools execution screen, described below.

## How to use it

1. Make sure your migrations are visible to Migrate Tools (for example under
   **Structure → Migrations**, or your migration group's dashboard).
2. Open the migration you want to test and go to its **Execute** screen.
3. Expand **Additional execution options** — you'll find a new **Dry run**
   checkbox added by this module.
4. Tick **Dry run** and run the migration. It processes as a preview so you can
   inspect the outcome without writing the real changes.
5. When you're satisfied, run it again with **Dry run** unticked to perform the
   actual import.

> This is similar in spirit to the **Migrate Preview** project, but implemented as
> a dry‑run option on the Migrate Tools execute form.
