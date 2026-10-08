# Batch API (developer tools) — manual setup guide

**Batch API (developer tools)** (`batch`) is a developer aid, not an end‑user
feature. It provides helpers and utilities that make building and running
operations on Drupal's core **Batch API** easier — the kind of long‑running work
that has to be split into chunks so it doesn't time out or exhaust memory. It
wraps core's Batch API rather than replacing it.

There is nothing for a site builder to click. The module has no content role and
no access‑control role; you use its helpers from your own code when you write
batch operations. It depends on the **Awareness** module.

This guide is written for a **human**. If you want terse, token‑cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

Nowhere — this is a developer toolkit with no settings page and no admin screens.

## How to use it

Once enabled, use the module's helper functions/classes inside your own module
code when defining and running batch operations. Refer to the module's own code
and the [`agent/`](../agent/start.md) docs for what the helpers provide; it is a
convenience layer over core's Batch API. Note this release is an alpha
(2.0.0‑alpha9), so pin your version and test before relying on it in production.
