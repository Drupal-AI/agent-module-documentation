# Migrate Tools — manual guide

**Migrate Tools** (`migrate_tools`) gives you the tools to actually *run* Drupal
migrations. Drupal core's Migrate API can define and execute migrations, but it
ships no user-facing way to trigger them; Migrate Tools fills that gap with a set
of **Drush commands** and, when [Migrate Plus](https://www.drupal.org/project/migrate_plus)
is installed, an **admin UI** under **Structure → Migrations**
(`/admin/structure/migrate`). From either place you can run imports, check their
status, roll them back, and read the messages a migration logged.

An important thing to understand up front: **the Drush commands are the primary
interface.** Almost everyone drives migrations from the command line —
`drush migrate:status`, `drush migrate:import`, `drush migrate:rollback` — because
that is what works in scripts, CI/CD, and long-running jobs with progress bars.
The UI is a convenient read-and-run companion, but it only appears once Migrate
Plus is enabled, and the migrations themselves are still defined elsewhere (as
Migrate Plus configuration or in a custom module). Migrate Tools does not create
migrations — it runs the ones you have already defined. This guide is written for
a **human**; for terse, token-cheap references aimed at an AI coding agent, read
the sibling [`agent/`](../agent/start.md) docs instead.

![The Migration groups list page under Structure → Migrations](images/groups.png)

## Where it lives in the admin menu

When Migrate Plus is installed, the UI sits under **Structure → Migrations**
(`/admin/structure/migrate`). That page lists your **migration groups**; clicking
into a group shows the individual migrations inside it, where you can view their
configuration and run or roll them back. Everything is gated by a single
**Administer migrations** permission.

## Contents

1. [Installation](installation/index.md) — install Migrate Tools with Composer,
   enable it, and understand what defines the migrations it runs.
2. [Configuration](configuration/index.md) — the two ways to work: browsing and
   running migrations in the **Structure → Migrations** UI, and the Drush command
   workflow that most people use day to day.
