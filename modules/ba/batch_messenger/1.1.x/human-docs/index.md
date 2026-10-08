# Batch Messenger — manual setup guide

**Batch Messenger** (`batch_messenger`) is a small developer API for controlling
which Messenger messages appear during batch and queue processing. Long‑running
batch or queue operations can otherwise flood the user with status messages, or
swallow ones you wanted to keep; this module gives developers a way to designate
which messages surface and which are suppressed, so the batch UX is cleaner.

It is a developer/UX tool. It affects status messages only — it has no content
role, and no access‑control role beyond its own permission. You use its API from
your own code inside batch operations.

This guide is written for a **human**. If you want terse, token‑cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

Nowhere — there is no settings page. This is an API you call from code.

## How to use it

Once enabled, call the module's API from your batch/queue operations to designate
which Messenger messages should appear (and which to suppress) while the batch
runs. Refer to the module's code and the [`agent/`](../agent/start.md) docs for
the available API.
