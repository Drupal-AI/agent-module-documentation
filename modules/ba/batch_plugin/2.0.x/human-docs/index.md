# Batch Plugin — manual setup guide

**Batch Plugin** (`batch_plugin`) is a developer framework for defining batch
operations as **plugins**. Instead of assembling ad‑hoc batch arrays each time,
developers define reusable, discoverable batch processes through a structured
plugin API — which makes batches easier to reuse across a codebase and easier to
reason about.

It is a developer/API module with no site‑builder UI. The batches it runs execute
with the privileges of whoever triggers them, and the module has no
access‑control role of its own. You define and run your batch plugins from code.

This guide is written for a **human**. If you want terse, token‑cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

Nowhere — there is no settings page. This is a plugin framework you build on in
code.

## How to use it

Once enabled, define your batch operations as plugins using the framework's API,
then run them. Refer to the module's code and the [`agent/`](../agent/start.md)
docs for how to declare a batch plugin. Remember that a batch runs with the
privileges of the user who triggers it.
