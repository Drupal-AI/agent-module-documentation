# SQL Server (sqlsrv) — manual setup guide

**SQL Server** (`sqlsrv`) is a Drupal database **driver** that lets Drupal run on
Microsoft SQL Server 2016+ and Azure SQL, instead of the usual MySQL/MariaDB or
PostgreSQL. It's built on PHP's `pdo_sqlsrv` extension and implements the full
Drupal Database API for SQL Server — connection, schema, and all the query
builders — so core and contrib modules work against a SQL Server backend.

Because it's a database driver, it's configured entirely through your site's
**`settings.php`** connection information (or the installer's database form,
which writes the same keys) — there is **no admin UI**, no settings page, no
permissions, and no Drush commands. You point a connection's `driver`,
`namespace`, and `autoload` keys at the driver, supply host/database/credentials,
and add any SQL-Server-specific options you need.

Under the hood the driver does a lot of translation so portable Drupal SQL runs
correctly on SQL Server: it quotes identifiers with SQL Server brackets, rewrites
functions core assumes from MySQL, deploys helper scalar functions at install
(for `GREATEST`, `IF`, `LPAD`, `MD5`, `SUBSTRING_INDEX`, and more), handles
case-sensitive vs case-insensitive collations, manages transactions with
savepoints, retries on deadlocks, and provides a Views date plugin so date-based
Views work. It supports Windows authentication, custom schemas, automatic
database/schema creation, encrypted connections, Always Encrypted columns, and
availability-group failover. Notably, it does **not** use `StatementPrefetch`, so
the SA-CORE-2024-008 driver-allowlisting requirement doesn't apply.

This guide is written for a **human** setting the driver up. If you want terse,
token-cheap references for an AI coding agent (including the driver internals),
read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — point Drupal at SQL Server via
   `settings.php`, with every connection option explained.

## Where it lives in the admin menu

Nowhere — a database driver has no admin screen. All setup happens in
`settings.php` (or the installer's database form). See
[Configuration](configuration/index.md).

## How to use it

1. Ensure the **`pdo_sqlsrv`** PHP extension is installed and you have a **SQL
   Server 2016+** or **Azure SQL** database.
2. Install the module with Composer **before** running the Drupal installer (see
   [Installation](installation/index.md)).
3. Either select **SQL Server** in the installer's database step, or write the
   connection into `settings.php` yourself.
4. Add any SQL-Server-specific options (schema, encryption, failover, etc.) as
   needed — see [Configuration](configuration/index.md).
