# PM — manual setup guide

**PM** (`pm`) is the base module of the **Drupal PM** suite — a collection of
project-management and work-tracking tools for Drupal 10 and 11. On its own the
base module is deliberately thin: it provides a shared content-entity framework
and a central, plugin-driven **dashboard** at `/pm`. All the things you actually
work with — projects, epics, features, stories, tasks, sub-tasks, boards
(Kanban), time tracking, notes, expenses, invoices, personas and organizations —
live in separate submodules that you enable only as you need them.

Because everything is built on Drupal's Field API and Views, PM entities behave
like any other content: you can add fields, build Views reports, and expose them
over REST. The base module also gives each project an auto-incrementing key
generator, so child items get sequential, human-friendly keys like `PROJ-1`,
`PROJ-2`, and so on.

Note that version 4.x is a complete rewrite focused on Drupal 10/11
compatibility, and at the 4.1.x stage it is an alpha release — some features from
older versions may not be back yet. Treat it as evolving software and check the
project's issue queue for gaps.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the base module with Composer,
   enable it, and add the submodules for the tools you want.

There is **no single settings form** for the base module (its `configure` route
is empty). Configuration happens in two places: the `/admin/pm` admin section that
the submodules add (bundles, statuses, priorities, boards), and per-project
settings such as the project key prefix. See "How to use it" below.

## Where it lives in the admin menu

Once enabled, the dashboard is at **`/pm`**. It is gated only by the core
**Access content** permission, but it is safe by design: it merely renders links
to the sub-tools you have enabled, and it hides any link the current user cannot
actually reach. Site administration for the suite lives under **`/admin/pm`** and
is gated by the **Administer PM configuration** permission — grant that only to
trusted project administrators.

## How to use it

1. Enable the base module (`pm`) to bootstrap the framework, then enable the
   submodules for the entity types you need — for example `pm_project`,
   `pm_task`, `pm_sub_task`, `pm_story`, `pm_epic`, `pm_feature`, `pm_board`,
   `pm_timetracking`, `pm_invoice`, `pm_expense`, `pm_note`, `pm_persona`,
   `pm_organization`, plus `pm_status` and `pm_priority` for custom
   statuses/priorities.
2. Visit **`/pm`** to see the dashboard of the tools you enabled.
3. Grant **Administer PM configuration** to your project administrators only, and
   configure entity bundles, statuses, priorities and boards under **`/admin/pm`**.
4. Create a project and set its **project key prefix** — child work items are then
   auto-numbered from it (`PROJ-1`, `PROJ-2`, …).
5. Add tasks, subtasks, stories, epics and features, and relate them
   hierarchically. Task types such as bug, issue, task and test ship as default
   bundles.
6. For a REST API over PM entities, enable the **`pm_rest`** submodule, which
   wires up REST views for the entities. The **`pm_ui`** submodule provides a
   Single-Directory Component "pill" formatter for rendering status/priority
   badges.
7. Developers can extend the dashboard by declaring their own
   `*.pm_dashboard_items.yml` entries or a custom dashboard-item plugin.
