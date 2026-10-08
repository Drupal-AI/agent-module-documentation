# Batch Service Interface — manual setup guide

**Batch Service Interface** (`batch_service_interface`) is a developer framework
that lets you define and run Drupal Batch API operations as **services**. Instead
of writing procedural batch arrays, you write your batches as injectable services
against a provided interface — a more structured, testable way to organise batch
code. It ships with an example submodule (`batch_example`) that shows the pattern
in practice.

It is a developer/API module with no site‑builder UI. The batches it runs execute
with the privileges of whoever triggers them, and it has no access‑control role of
its own. You define your batch services from code.

This guide is written for a **human**. If you want terse, token‑cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   the optional example submodule.

## Where it lives in the admin menu

Nowhere — there is no settings page. This is a service/interface you build on in
code.

## How to use it

Once enabled, define your batch operations as services that implement the
module's batch interface, wire them up in your module's service definitions, then
run them. The bundled **`batch_example`** submodule is a working reference —
enable it to see how a batch service is declared and run. Refer to it and the
[`agent/`](../agent/start.md) docs for the pattern. Remember a batch runs with
the privileges of the user who triggers it.
