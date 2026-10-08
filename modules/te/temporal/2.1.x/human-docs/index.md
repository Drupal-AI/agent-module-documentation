# Temporal IO — manual setup guide

**Temporal IO** (`temporal`) connects Drupal to
[Temporal.io](https://temporal.io), a platform for durable execution and
workflow orchestration. It lets Drupal start and take part in Temporal
workflows and activities, so long‑running, reliable, retryable business
processes can be managed by Temporal instead of by ad‑hoc cron and queue code.

The problem it addresses is that Drupal's own Queue and Batch APIs run out of
road for very long‑running background processes. In Temporal, the basic unit is
an *activity* (for example generating a report from an entity, or indexing an
entity), and a *workflow* is a long‑running process that tells Temporal which
activities to run. Temporal stores the input and output of activities in a
durable event log, so if a workflow stops for any reason it can resume exactly
where it left off without re‑running completed activities, and failed activities
can be retried automatically. Workflows can be started on demand or scheduled.

This module is integration plumbing rather than something that does visible work
the moment you enable it — you must give it the connection details for your
Temporal server before it can do anything, and those details should be stored
securely (env‑backed) rather than committed. It depends on core **Options** and
supports **Drupal 11**. It ships no submodules.

One installation caveat from the module's own notes: if you have
`drupal/opentelemetry` installed, upgrade it to at least `1.0-beta7`
(`composer require drupal/opentelemetry:"^1.0@beta" --update-with-dependencies`)
*before* installing Temporal IO, otherwise the installation will break. Note also
that this project is **minimally maintained** and its releases are **not covered
by the security advisory policy**, which is worth weighing before relying on it in
production.

This guide is written for a **human**. If you want terse, token‑cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   handle the OpenTelemetry caveat, and enable it.

## How to use it

Temporal IO has no standalone settings page listed. Once enabled, its role is to
provide the connection to your Temporal server (configured by an administrator
and stored securely as an environment variable) and the code hooks for starting
and running Temporal workflows and activities from Drupal. The heavy lifting —
defining workflows and activities — is a development task; this module is the
bridge that lets that code talk to a running Temporal cluster.
