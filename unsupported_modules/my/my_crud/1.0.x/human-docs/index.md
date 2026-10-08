# my_crud — manual setup guide

**my_crud** (`my_crud`, distributed as the project
`basic_crud_operation_in_drupal_sites`) is a small tutorial/example module that
demonstrates how to build classic **create, read, update and delete** screens
over a custom database table using Drupal's Database API and Form API. It is a
learning reference for developers, not a feature you would ship to a live site.

When you enable it, the module creates a simple `my_crud` table (with `id`,
`name`, and `age` columns) via `hook_schema`. It then exposes a themed listing
of the stored records, an add/edit form, and a delete confirmation form — all
wired up with parameterized queries, field validation (letters-only names,
numeric ages), and status messages, so you can read the source to see how each
piece fits together.

There is nothing to configure and no settings form. One thing worth knowing:
the add/edit and delete routes are declared with `_permission: 'TRUE'`, which is
not a real permission — in practice that means only user 1 (the superuser) can
reach the write forms. This is an accidental lock-out rather than an open door,
and it is a quirk of the example code rather than a feature.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the project with Composer and
   enable the module.

There is **no configuration page** for this module — it has no settings form.

## How to use it

Once the module is enabled, the example screens are available at:

- **`/my_crud`** — a themed table listing every record in the `my_crud` table.
  This listing is available to anyone with the core **View published content**
  (`access content`) permission.
- **`/my_crud/form/data`** — the add/edit form. Editing an existing record uses
  an `?id=` query parameter.
- **`/my_crud/form/delete/{cid}`** — the delete confirmation form.

Because the write forms are gated by the placeholder `_permission: 'TRUE'`, you
will effectively need to be logged in as user 1 to add, edit, or delete records.
Treat the whole module as reference material: read the controller and form
classes to learn the Database API `select`/`insert`/`update`/`delete` builders,
then build your own production feature from what you have learned.
