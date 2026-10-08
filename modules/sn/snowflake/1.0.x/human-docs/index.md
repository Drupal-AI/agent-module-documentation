# Snowflake — manual setup guide

**Snowflake** (`snowflake`) provides a Drupal service that talks to the
**Snowflake SQL API v2** over HTTPS, so your custom code can run SQL statements
against a Snowflake data‑warehouse account and read back structured result sets.
It is a developer/integration module: it exposes a single client service,
`snowflake.sql_api` (the `SqlApi` class), rather than any end‑user feature.

Note that the SQL API is different from the PHP PDO driver for Snowflake — this
module talks to the REST SQL API and does not use the PDO driver. From code you
build statements with the module's `Statement` class (with typed **bindings** so
values are sent as JSON parameters rather than concatenated into SQL), group them
into a `Statements` object, and call `executeStatements()`. It supports single or
combined statements, asynchronous execution, polling a statement's status by its
handle, and cancellation, and it wraps responses in typed result classes.

The module is not usable on enable alone: you must configure a Snowflake account
identifier and an authentication method before the client can connect. It
requires the **Key** module for storing credentials securely — your Snowflake
private key or OAuth secret is referenced through a Key entity rather than saved
in plain configuration. Depending on the authentication method you choose you
also need an extra PHP library: key‑pair (JWT) authentication needs
`firebase/php-jwt`. See the [Configuration](configuration/index.md) page for the
full setup.

A note on trust and security: the settings forms are gated by a restricted
**`administer snowflake`** permission, SQL is sent with typed bindings (so the
client itself does not open a SQL‑injection path), credentials live in Key
entities rather than plain config, statement handles are validated as UUIDs, and
requests use Guzzle's default TLS verification. This is a soundly built
integration client.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module, the Key
   dependency, and the JWT library with Composer, then enable it.
2. [Configuration](configuration/index.md) — set the account identifier, choose
   an authentication method, and connect your credentials via the Key module.

## Where it lives in the admin menu

Snowflake's configuration lives under **Configuration → Snowflake**. The two main
forms are **Snowflake Settings** (`/admin/config/snowflake/settings`) for the
account identifier and statement defaults, and **Snowflake Authentication**
(`/admin/config/snowflake/auth`) for the authentication method. All of these
require the **`administer snowflake`** permission.

## How to use it

Once configured, call the client from your own module code:

```php
/** @var \Drupal\snowflake\SqlApi $client */
$client = \Drupal::service('snowflake.sql_api');

$statement = \Drupal\snowflake\Statement\Statement::create(
  'SELECT FIRST_NAME, LAST_NAME FROM CONTACTS WHERE USER_ID=?'
)->addBinding('TEXT', '1234567890');

$statements = \Drupal\snowflake\Statement\Statements::create($statement);
$result = $client->executeStatements($statements);
```

Statements can be combined, run asynchronously, polled by handle, or cancelled —
see the sibling [`agent/api.md`](../agent/api.md) for the full method list.
