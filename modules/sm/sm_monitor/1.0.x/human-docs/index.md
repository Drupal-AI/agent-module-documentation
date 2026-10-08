# Symfony Messenger Monitor — manual setup guide

**Symfony Messenger Monitor** (`sm_monitor`) adds a visual admin dashboard for
your Symfony Messenger setup. Where the Metrics module quietly records the
numbers, this module surfaces them: it exposes the active **workers**,
**messages**, and **aggregate statistics** in an at-a-glance UI so operators can
see what the message bus is doing.

The problem it solves is operational visibility. Async processing is otherwise a
black box — you can't easily tell which workers are running, how busy they are,
or how the queue is performing. The dashboard shows worker cards; if the ChartJS
module is installed, each card automatically gains a **graph**. From the UI you
can also **terminate workers** directly.

It builds on the Metrics module for its statistics, so it depends on
**`sm_metrics`** as well as **`pinto`** (used to build its UI components), and it
requires **Drupal 11.3+**. It provides its own permissions to control who can see
the dashboard and act on workers. Note it is **not covered by Drupal's security
advisory policy**.

This guide is written for a **human** installing the module. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Once enabled, open the monitor dashboard from the admin UI. It lists the active
workers, the messages flowing through the bus, and aggregate statistics drawn
from the Metrics module. Each worker appears as a card — install the **ChartJS**
module to have a graph rendered on each one automatically. When you need to stop
a worker, you can **terminate it** from the dashboard. Because the dashboard
relies on the data collected by **Symfony Messenger Metrics**, make sure that
module is installed and has recorded some activity.
