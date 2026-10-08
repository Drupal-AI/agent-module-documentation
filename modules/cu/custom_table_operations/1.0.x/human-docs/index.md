# Custom Table Operations — manual setup guide

**Custom Table Operations** (`custom_table_operations`) gives you an admin UI to
**view and edit the rows of custom database tables** — the kind of ad-hoc tables a
project creates directly in the database for bespoke operations, rather than
modelling them as Drupal entities. If you have a legacy or integration table that
still needs occasional hand-editing but isn't worth building a full entity type
for, this module lets a trusted administrator list its rows and update their
content through the interface instead of reaching for a database client.

Because it works **directly against database tables**, it's a developer/admin
utility that must be handled with care. Point it only at your own custom tables,
restrict its use to trusted administrators, and heed the project's own warning:
**do not add Drupal's core tables to it** — editing core tables directly can
corrupt your site. It defines its own permission to gate access, supports Drupal
10 and 11, and has no dependencies beyond core.

There is no global settings form to fill in; you work with it directly through its
admin interface, choosing the custom tables to manage and editing their rows.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no general settings form** for this module. You use it directly from
its admin interface, as described below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)) and make sure the
   administrator role holds the module's access permission (assign it on **People →
   Permissions**).
2. Open the module's admin interface and point it at a **custom** database table —
   one of your own project's non-entity tables. **Never** target Drupal's core
   tables.
3. Browse the table's rows and edit their content through the UI, then save your
   changes.

Treat this like direct database access: double-check which table you're editing,
and keep the access permission limited to administrators you trust.
