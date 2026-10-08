# AUTO_INCREMENT Alter — manual setup guide

**AUTO_INCREMENT Alter** (`auto_increment_alter`) lets administrators change the
`AUTO_INCREMENT` starting value of MySQL database tables. It is useful in the
rare cases where new rows — node IDs, order numbers, and the like — need to begin
at a specific number, or where you need to reset a counter.

The module provides an admin form for listing and altering tables, plus Drush
commands and its own permission. Under the hood it runs
`ALTER TABLE … AUTO_INCREMENT` directly against real tables, so it is a powerful,
low-level database operation rather than an everyday content tool.

**Treat it with care.** Because it edits the database directly and bypasses
application logic, using it carelessly can cause real damage: setting an
`AUTO_INCREMENT` value below a table's existing maximum, or altering the wrong
table, can produce duplicate-key errors and data-integrity problems. Restrict its
permission to trusted administrators, run it only against the tables you intend,
and take a backup first. It has no content-access role beyond its permission, and
it requires MySQL. It supports Drupal 10 and 11. (The packaged release is
`1.0.0-alpha5`, an alpha.)

This guide is written for a **human** working through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The module's configuration is the **list of tables** you can act on (config route
`auto_increment_alter.list_tables`), where you choose a table and set its new
`AUTO_INCREMENT` value. The same operations are available via the module's Drush
commands. Access is gated by the module's own permission, set at **People →
Permissions** (`/admin/people/permissions`) — grant it only to trusted
administrators.

## Before you use it

- **Back up the database first.** This runs a direct `ALTER TABLE` against real
  data.
- **Never set a value below the table's current maximum ID**, or you will get
  duplicate-key errors.
- **Double-check you have the right table.** The operation bypasses application
  logic, so there is no safety net at the Drupal layer.
