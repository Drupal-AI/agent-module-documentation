# Burndown — manual setup guide

**Burndown** (`burndown`) brings lightweight agile project management into
Drupal. It lets you track tasks on boards, organise them into sprints, and
generate **burndown charts** that show remaining work over time — the classic
agile view of whether a team is on track. An optional **time tracker** submodule
(`burndown_time_tracker`) lets people log time against their work.

It is aimed at running simple project and task management inside your Drupal site
rather than reaching for a separate tool. Tasks, sprints, and time entries are
content that can hold internal project detail — and, via time tracking, a record
of who did what — so use the module's own permissions to keep that data visible
only to the appropriate team.

Burndown builds on several core modules (Datetime, Field, Image, Link, Options,
Taxonomy), provides its own permissions, and ships **Drush commands** for
scripting. It works on Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
a terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and, optionally,
   the time-tracker submodule) with Composer and enable it.

## Where it lives in the admin menu

Burndown does not add a single "settings" form; it is an application you work in.
After enabling it, look for its **boards and tasks** screens in the admin menu and
grant its permissions under **People → Permissions**
(`/admin/people/permissions`).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Under **People → Permissions**, grant the Burndown permissions to the roles
   that should manage projects and log time.
3. Create a board, add tasks to it, and organise them into sprints.
4. Open the burndown chart for a sprint to see remaining work trend over time.
5. If you enabled the **Time Tracker** submodule, team members can log time
   against their tasks, recording who did what.

The bundled Drush commands let you automate parts of this from the command line.
