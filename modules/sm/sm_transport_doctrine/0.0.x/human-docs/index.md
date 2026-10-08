# Doctrine transport for Symfony Messenger — manual setup guide

**Doctrine transport for Symfony Messenger** (`sm_transport_doctrine`) adds a
**Doctrine (DBAL) transport** to the Symfony Messenger (`sm`) module. A transport
is the backend that holds messages while they wait to be processed; this one uses
**Doctrine DBAL** on your active Drupal database, so messages are queued in a
database table rather than in an external broker. It gives you a full-featured,
database-backed async transport without standing up extra infrastructure.

The problem it solves is a database queue for message-driven work — useful with
SQL databases such as PostgreSQL or MySQL. Once the module is installed the
transport is available immediately under the **`doctrine`** alias, and you can
configure multiple transports through container parameters.

**Worth reading first:** as of SM v0.2.0 and later, the `sm` module already
includes a Drupal database native transport via the `drupal-db://` protocol. The
maintainers suggest you **consider that built-in transport before** reaching for
this Doctrine one — so use this module when you specifically want the Doctrine
DBAL implementation.

It is an infrastructure/developer module with no content or access-control role
of its own. It depends on the **DBAL** module (`dbal`), requires **Drupal
10.1+**, and this project must have its dependencies managed with Composer. It is
covered by Drupal's security advisory policy.

This guide is written for a **human** installing the module. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Install and enable the module and the transport becomes available immediately
under the **`doctrine`** alias — point a Symfony Messenger transport at it to
queue messages in your database via Doctrine DBAL. You can configure multiple
transports using container parameters. Remember the built-in `drupal-db://`
native transport is an alternative worth considering first.
