# Checklist API — manual setup guide

**Checklist API** (`checklistapi`) is a developer‑oriented framework for building
fillable, persistent checklists in Drupal. Think of a grouped to‑do list an admin
can tick off — a site‑setup guide, a compliance audit, a QA sign‑off — where each
completed item permanently records *who* checked it and *when*. Checklist API
handles the routes, permissions, progress storage, and reporting for you; you (or
a module you install) just declare the checklist's contents.

Because it is an API, Checklist API ships no ready‑made checklist of its own.
A module defines one by implementing `hook_checklistapi_checklist_info()`,
returning a definition with a title, a path, and a callback that supplies the
groups and items. Groups render as vertical tabs; each item can carry a
description, documentation links, a weight, and a default value that auto‑checks
programmatically verifiable steps (for example "this module is enabled"). From
that definition, Checklist API automatically generates a route and a pair of
per‑checklist permissions, and it saves progress to one of two storage backends:
`config` (the default, exportable) or `state`.

A **Checklists** report at `/admin/reports/checklistapi` lists every checklist
with its percent complete, last‑updated date, and last user, and Drush commands
surface the same information on the command line. A bundled example submodule,
**Checklist API Example** (`checklistapiexample`), ships a working reference
implementation you can learn from.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the hook
signatures and storage API — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and (optionally) the example submodule.

## Where it lives in the admin menu

Checklist API has **no settings form** — it is a framework, configured in code
rather than through a UI. The one page it provides is the **Checklists** report at
**Reports → Checklists** (`/admin/reports/checklistapi`), which lists all
registered checklists and their completion status. Individual checklists live at
whatever path their defining module declares.

## How to use it

On its own, Checklist API does nothing visible until a checklist is defined. There
are two ways to get one:

- **Enable the example** — turn on the `checklistapiexample` submodule to see a
  fully working checklist and study how it is built.
- **Define your own (developers)** — implement
  `hook_checklistapi_checklist_info()` in a custom module. Each definition needs a
  `#title`, a `#path`, and a `#callback` that returns the groups and items. Handy
  per‑item options include `#description`, `#default_value` (to auto‑check
  verifiable items), `#weight`, and any number of handbook `#url` links. Choose
  where progress is stored with `#storage` (`config` or `state`). Other modules
  can adjust an existing checklist via `hook_checklistapi_checklist_info_alter()`.

Once a checklist exists, using it is simple:

1. Open the checklist at its declared path (or find it on the **Checklists**
   report).
2. Tick items as you complete them — each item remembers the time and user of its
   first completion — and click save. Progress persists across sessions and users.
3. Track overall progress on the report at `/admin/reports/checklistapi`, or from
   the command line with `drush checklistapi:list` (all checklists and progress)
   and `drush checklistapi:info` (one checklist's items and completion detail).

**Access control:** each checklist gets its own `view {id} …` and `edit {id} …`
permissions, and there are universal `view any` / `edit any` permissions to grant
a role blanket access. So you can, for example, let everyone *view* a checklist
while only trusted staff may *edit* it.
