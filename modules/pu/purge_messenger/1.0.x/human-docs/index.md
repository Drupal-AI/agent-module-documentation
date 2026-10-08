# Purge integration with Symfony Messenger — manual setup guide

**Purge integration with Symfony Messenger** (`purge_messenger`) changes *how*
Purge moves its cache invalidations around. Out of the box, Purge keeps its queue
in the database (or memory) and processes it with its own processors. This module
replaces that queue with **Symfony Messenger**, so invalidations become Messenger
messages that can be dispatched asynchronously to a transport such as Redis,
RabbitMQ, or SQS — with deduplication and an optional delay. Workers consuming the
Messenger queue then execute the actual purge calls, which decouples cache
invalidation from your HTTP request threads.

In practice this means purges happen off-thread and in real time, without tying up
the request that triggered them, and they can be processed by dedicated workers
across a distributed setup. It is purely a performance and infrastructure
integration — it has no content model or access role of its own.

It depends on **Purge** (`purge`), the **Symfony Messenger** module (`sm`), and
core **Serialization** (`serialization`), and runs on Drupal `^10.5 || ^11.3`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Purge and Symfony Messenger.

There is **no dedicated settings form** for this module. You switch Purge's queue
engine over to Messenger from within Purge's own configuration, and a couple of
optional settings are set as configuration values — both are described in "How to
use it" below.

## Where it lives in the admin menu

You enable the Messenger queue engine from Purge's own configuration at
**Configuration → Development → Performance → Purge**
(`/admin/config/development/performance/purge`), under the **Queue** section.

## How to use it

1. Install and configure **Purge**, **Symfony Messenger** (`sm`), and this module.
   Set up a Messenger transport (Redis/RabbitMQ/SQS, etc.) in your Messenger
   configuration.
2. Go to **Configuration → Development → Performance → Purge** and, under the
   **Queue** dropdown, choose **Change engine**.
3. Select **Messenger** and save. From now on, new invalidations are intercepted
   and dispatched via Symfony Messenger.
4. Purge's own queue-processing command (`drush p:queue-work`) is now redundant
   for this queue and can be disabled — the Messenger workers do the processing
   instead.

### Optional configuration values

Two optional settings tune the behavior (set them as configuration values):

- **`purge_messenger.delay`** — delay message delivery by the given amount, so
  invalidations are dispatched after a short wait rather than immediately.
- **`purge_messenger.immediate`** — buffer invalidations and send them as a batch
  *after* the HTTP response has been sent to the visitor, keeping the request as
  fast as possible.
