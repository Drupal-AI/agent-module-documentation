# FIFO Lock — manual setup guide

**FIFO Lock** (`fifo_lock`) is a developer-oriented module that provides an
alternative **lock backend** for Drupal. Drupal's locking mechanism is great, but it
does not respect the order in which requests arrive: when several requests wait on
the same lock, core picks a waiter more or less at random, so an unlucky request can
keep losing and eventually time out. FIFO Lock hands out contended locks in
**first-in-first-out** order — a "ticket lock" — so the earliest requester acquires
first. Given enough server throughput, that reduces the error rate caused by unlucky
requests timing out.

It is a database-backed backend: each acquisition attempt is stored as a row in a
dedicated `fifo_lock` table with an auto-incrementing id, and a request holds the
lock only when its row has the lowest id for that lock name. The table is created on
demand, and cron cleans up expired rows and resets the table when it is empty. It
implements Drupal's standard `LockBackendInterface`, so `acquire()`, `release()`,
`wait()`, and `releaseAll()` all behave as usual — it is a drop-in replacement.

This is a code-level tool with **no admin UI and no settings form**. You opt in
either per call site (by using the `fifo_lock` service instead of the default lock
service) or site-wide (by overriding the default `lock` backend in a
`services.yml`). See "How to use it" below. Note that this module is **not covered by
Drupal's security advisory policy**, so evaluate it accordingly before using it on a
high-stakes site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has **no configuration page**. You choose how to use its lock backend in
code or in a services file, described in "How to use it" below.

## Where it lives in the admin menu

FIFO Lock adds no admin page. It provides a service (`fifo_lock`) and a database
table; everything is wired up in code, not through the UI.

## How to use it

There are two ways to adopt the FIFO lock, depending on how broadly you want it:

- **Per call site (targeted).** In your own service or code, use the `fifo_lock`
  service instead of the default lock — inject the `fifo_lock` service, or as a quick
  swap replace `\Drupal::lock()` with `\Drupal::service('fifo_lock')`. Because it
  implements `LockBackendInterface`, the rest of your locking code is unchanged. This
  is the right choice when only certain hot locks (a busy cron job, a queue worker, a
  non-idempotent external API call) need fair ordering.
- **Site-wide.** Because the service is declared `backend_overridable`, you can make
  it the default lock backend for the whole site by overriding the core `lock`
  service in a `services.yml` (typically `sites/default/services.yml`). Every caller
  that uses the standard lock then gets FIFO ordering.

Very long or non-ASCII lock names are handled safely (they are hashed), and you do
not need to create the database table yourself — it is created on first use and
maintained by cron.
