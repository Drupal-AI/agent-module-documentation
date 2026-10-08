# Community Tasks — manual setup guide

**Community Tasks** (`community_tasks`) is a lightweight volunteer‑task system for
Drupal. You post tasks, community members commit to doing them, and once a task is
done it is marked completed — with each volunteer's completed tasks shown on their
user profile. It's aimed at community, nonprofit, and membership sites that want
to organize and recognize volunteer contributions.

The problem it solves: coordinating "who is doing what" among volunteers usually
means spreadsheets or ad‑hoc pages. Community Tasks gives you a purpose‑built
content type with a simple three‑stage workflow — the module creates a task
**node type** with a dedicated *task state* field that moves each task through
*open → committed → completed*, while the node's author (uid) records the
"responsible person" who committed to it. It comes with **full Views integration**,
so you can build task lists and volunteer‑history displays.

It builds on core modules only — **Comment**, **Datetime**, **Options**, **Text**,
and **Views** — which are enabled automatically. There is no dedicated settings
form; setup is about granting the right permissions and building the Views/pages
you want around the task content type.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no separate configuration page** — you work with the task content type,
permissions, and Views, as described next.

## Where it lives in the admin menu

Community Tasks adds its task **content type** (managed under **Structure →
Content types**) and integrates with **Views** (**Structure → Views**). Task
pages and listings appear wherever you expose them via Views or menu links, and
completed tasks surface on user profiles.

## How to use it

1. Enable the module — it creates the task content type and its fields.
2. Under **People → Permissions**, grant the appropriate roles the ability to
   create tasks, commit to them, and mark them complete (and to comment, since the
   type uses core Comment).
3. Post tasks as content. Volunteers commit to a task, and when it's done it is
   marked completed — moving through the module's three‑stage workflow.
4. Use the bundled **Views** integration (or build your own Views) to present open
   tasks, tasks in progress, and each volunteer's completed history.
