# Symfony Messenger Metrics — manual setup guide

**Symfony Messenger Metrics** (`sm_metrics`) records timing metrics about how
Symfony Messenger processes your messages, so you can measure the latency and
throughput of the message bus. For each message it captures two figures:

- **Pre-handle time** — the gap between a message being dispatched and its
  processing beginning. Most of this is time spent waiting for a worker to pick
  the message up.
- **Handle time** — how long the handler actually took to execute the message.

It also includes a **UI** that displays summaries of these statistics grouped by
transport and message type, so you can see at a glance where time is going.

The problem it solves is observability for async processing: without metrics,
queue latency and slow handlers are invisible. A couple of things are worth
knowing — statistics are always **complete**, meaning they only appear once a
message has finished processing, and metrics use **database persistence**, so a
catastrophic connection failure can prevent a metric from being logged until the
message is processed.

It depends on **Symfony Messenger** (`sm`), requires **Drupal 11.3+**, is covered
by Drupal's security advisory policy, and provides its own permissions. It is
**ready as soon as it is installed** — no configuration is required, though some
options are documented in the module's README. The companion **Symfony Messenger
Monitor** project builds a richer dashboard on top of the data this module
records.

This guide is written for a **human** installing the module. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Once enabled, metrics collection starts automatically — there is nothing to turn
on. As messages are dispatched and handled, their pre-handle and handle times are
recorded to the database. Open the included statistics UI to review summaries per
transport and message combination. For a graphical dashboard, add the Symfony
Messenger Monitor module, which consumes these metrics.
