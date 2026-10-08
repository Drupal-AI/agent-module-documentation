# Redis for Symfony Messenger — manual setup guide

**Redis for Symfony Messenger** (`sm_transport_redis`) provides a **Redis
transport** for the Symfony Messenger (`sm`) module. A transport is the backend
that holds messages between dispatch and processing; this one uses **Redis**, so
your async message queues run on a Redis server instead of the database or an
in-process backend. It works by integrating Symfony's own
`symfony/redis-messenger` library with SM.

The problem it solves is scalable background processing: Redis is a fast,
purpose-built queue backend, and using it as the Messenger transport lets high
volumes of messages move through the bus efficiently, separately from the web
request. It is an infrastructure/performance feature — it configures a queue
transport and has no content or access-control role of its own.

**One security point to keep in mind:** your message payloads pass through Redis,
so the Redis instance you connect to should be a **trusted, access-controlled**
one — not an open, shared, or publicly reachable server.

It works on **Drupal 10.3+**, and is **not covered by Drupal's security advisory
policy**. Further configuration details are in Symfony's own documentation for
the Redis transport.

This guide is written for a **human** installing the module. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Once installed and enabled, configure a Symfony Messenger transport to use Redis
as its backend, following the Symfony Messenger documentation for the Redis
transport. Point it at a **trusted, access-controlled Redis instance**, since
queue payloads pass through it. Messenger queues then run on Redis for scalable
background processing.
