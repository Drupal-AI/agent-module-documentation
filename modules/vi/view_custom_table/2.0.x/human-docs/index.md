# Views Custom Table — manual setup guide

**Views Custom Table** (`view_custom_table`) lets you build Drupal Views over ordinary
database tables that are **not** Drupal entities — including tables that live in a
secondary (non-default) database. Normally Views only knows about entities and a few
core tables; with this module you can point Views at a legacy table, a reporting or
analytics table, or a table some custom module writes to, and then use all of Views'
formatting, filtering, sorting, and display power on that raw data.

You register a table through an admin UI at **Structure → Views → View Custom Table**.
You tell the module the table's name and which database connection it lives in, and it
inspects the table's columns and maps each one to the right Views handler based on its
SQL type — numbers get numeric field/sort/filter/argument handlers, text gets string
handlers, and date/time columns get the module's own date handler so you can format
them with Drupal date formats. Each table must have a primary key. Through an "Edit
Table Relations" step you can also declare that a numeric column points at a Drupal
entity (a node, user, taxonomy term, file, and so on) or at another custom table,
which gives you a Views relationship to join the two together.

The module works once enabled, but it does nothing until you register at least one
table. After adding or changing a registration you clear caches so Views rebuilds its
data. It depends only on core's Views module (Views UI recommended for building the
actual Views) and needs no third-party libraries. A set of permissions controls who
can add, remove, and administer table registrations — their own or everyone's.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — the config object shape, the
column-to-handler mapping, and the relationship internals — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and grant permissions.
2. [Configuration](configuration/index.md) — register a table, declare column
   relations, and turn it into a View.

## Where it lives in the admin menu

Table registrations are managed at **Structure → Views → View Custom Table**
(`/admin/structure/views/custom_table`). From there you add a table, edit its details,
declare its column relations, and remove it. The Views you build over those tables are
created in the usual place, **Structure → Views** (`/admin/structure/views`).
