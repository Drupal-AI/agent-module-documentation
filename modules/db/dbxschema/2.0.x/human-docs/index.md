# Database Cross-Schema Queries — manual setup guide

**Database Cross-Schema Queries** (`dbxschema`) is a developer/advanced module that
lets Drupal run SQL queries spanning **multiple database schemas** (on PostgreSQL)
or **multiple databases** (on MySQL) using Drupal's familiar database API. Normally
a query is confined to Drupal's own schema/database; with this module, code can
reach across schema or database boundaries — even within a single query — as long
as everything is reachable through **one database connection** (same server, port,
and credentials).

A typical scenario: your Drupal site runs on a PostgreSQL database where Drupal
lives in the `public` schema, but you also have `myschema1`,
`some_custom_data_schema_2`, and so on that you want to query from Drupal. On MySQL
the equivalent is querying several databases on the same server through the same
credentials. It can even query a MySQL database from a PostgreSQL-hosted Drupal
site, provided the credentials are set up in `settings.php`. Both PostgreSQL and
MySQL are tested and functional; this is a **beta** module.

Because it works through an API rather than a UI, there is nothing to configure in
the admin interface — the setup lives in your database and your `settings.php`, and
you consume the feature from code. It ships two small driver submodules,
**dbxschema (MySQL)** and **dbxschema (PostgreSQL)**, and you enable the one that
matches your database.

**A security note worth taking seriously:** cross-schema access requires a database
user with broad permissions across the schemas or databases involved. Grant that
user only the **minimum access it truly needs** (least privilege) — a
widely-permissioned DB user increases the blast radius if a query or the
application is ever compromised. Always use **parameterized queries** and never
build cross-schema SQL from untrusted input. The module has no content-access role
of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and enable the driver submodule for your database.

There is **no configuration page** for this module — it's a developer API. The only
"configuration" is database-level: the connection and the DB user's permissions,
and any additional connections defined in `settings.php`.

## How to use it

1. Enable the base module and the driver submodule for your database (see
   [Installation](installation/index.md)).
2. Make sure the database user your site connects with has the appropriate — but
   minimal — permissions on all the schemas/databases you need to reach, and that
   any additional connections are defined in `settings.php`.
3. From your module code, use Drupal's database API through this module's services
   to run queries across schemas/databases, always with parameterized queries.

> **Note on version 2.0.x:** this branch no longer supports per-table prefixing
> (that capability was deprecated in Drupal 9 and removed here after the 9.4 driver
> rewrite). It also won't work against very old PostgreSQL/MySQL versions that
> don't support cross-schema/database queries.
