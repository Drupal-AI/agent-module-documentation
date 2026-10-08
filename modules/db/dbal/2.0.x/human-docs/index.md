# DBAL Connection — manual setup guide

**DBAL Connection** (`dbal`) is a small developer bridge that hands your code a
ready‑configured **Doctrine DBAL** connection
(`Doctrine\DBAL\Connection`) built from Drupal's existing database settings. If
you have code or a library that expects to talk to the database through Doctrine
DBAL — its query builder, schema manager, transactions, and so on — this module
lets it use the very same database Drupal is configured for, with no second set
of connection details to maintain.

It works entirely by deriving the Doctrine connection from Drupal's `$databases`
settings in `settings.php` at runtime, so your credentials stay in one place. You
can get the default connection, or ask for any named database target (for example
a replica), and on SQLite it even attaches Drupal's prefixes as databases for
you. If you also install the optional `doctrine/persistence` library, the module
additionally provides a Doctrine `ConnectionRegistry` for tooling that expects
one.

This is a **developer‑only** module: it has no user interface, no settings form,
no permissions, and no Drush commands. You use it from PHP by injecting one of its
services (the connection can even be autowired by its `Doctrine\DBAL\Connection`
type). It requires the `doctrine/dbal` library, which Composer installs for you.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent — including the exact service names
and how to get a connection in code — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the Doctrine
   DBAL library with Composer and enable it.

## Where it lives in the admin menu

Nowhere — DBAL Connection has no admin UI. Once enabled, it simply makes its
Doctrine connection services available to other code.

## How to use it

After enabling the module, use it from your own module's PHP code. Inject the
`dbal_connection` service (or autowire the `Doctrine\DBAL\Connection` type) to get
the default connection, or use the `dbal_connection_factory` service and call its
`get($target)` method to obtain a connection for a specific Drupal database
target. From there you use the standard Doctrine DBAL API — query builder,
`executeQuery`/`executeStatement`, the schema manager, transactions — against the
Drupal database. See the [`agent/`](../agent/start.md) docs for the precise
service names and code examples.
