# AutoSlave — manual setup guide

**AutoSlave** (`autoslave`) is a database scaling tool. On a busy, read‑heavy
site the main database server can become the bottleneck, because every page view
runs many `SELECT` queries. AutoSlave automatically sends those read queries to
one or more **replica** (also called "slave") database servers, while keeping all
writes on the primary server. The result is that read traffic is spread across
extra machines and the primary is freed up for the work only it can do.

It is purely an infrastructure/performance feature. It adds no content, no pages,
and no editor tools — it works underneath Drupal at the database layer. It depends
only on core's System module and defines a permission of its own.

Two things are essential to understand before you rely on it. First, it only
helps if you have actually set up **database replication** at the server level —
AutoSlave routes queries to replicas, but it does not create the replicas. Second,
replicas lag slightly behind the primary, so a read that happens immediately after
a write can return **stale data**. AutoSlave manages the common cases, but for
flows where a user must see their own change instantly, verify the behavior.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

AutoSlave has no admin settings form. It is configured the way Drupal's core
database connections are configured — in your site's **`settings.php`**, by
defining replica database connections alongside the primary one. Once your
replica servers exist and are described there, AutoSlave takes over the job of
deciding which connection each query should use: writes and consistency‑sensitive
reads go to the primary, ordinary reads go to the replicas.

Because this is server‑level infrastructure, plan for it as such:

- Set up and test database replication **before** enabling the module.
- Be aware of **replication lag** — a read straight after a write may be stale.
- Test any flow where a user must immediately see their own change.
