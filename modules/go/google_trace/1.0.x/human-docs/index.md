# Google Trace — manual setup guide

**Google Trace** (`google_trace`) forwards performance traces from Drupal to
**Google Cloud Trace**, using the official `google/cloud-trace` PHP client. It
buffers spans through Drupal's queue system so a request is never blocked waiting on
the outbound API call — traces are collected during the request and flushed to
Cloud Trace later, on cron.

This is a **developer integration**, not a point-and-click feature: it ships no
routes, forms, permissions or settings page. You use it from code through the
`google_trace.helper` service, which offers `getTrace()` to build a trace,
`insertTrace()` to send one synchronously, and `queueTrace()` to enqueue one for
background delivery. The `google_trace_queue` queue worker then inserts queued
traces into Cloud Trace when cron runs (or when you run the queue manually with
`drush queue:run google_trace_queue`). Errors are logged to the `google_trace`
channel rather than thrown, so a missing credential degrades gracefully instead of
breaking requests.

Authentication relies entirely on **ambient Google credentials** from the
environment (Application Default Credentials), so no secret is ever stored inside
Drupal. All traffic is outbound HTTPS handled by the Google SDK, and there is no
inbound callback surface.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable, and set
   the two Google Cloud environment variables.

There is **no configuration page** for this module — it has no settings form. Its
only "configuration" is a pair of environment variables (below), and its behaviour
is driven from code via the `google_trace.helper` service.

## Configure the environment

Two environment variables must be set for the trace client to authenticate:

- **`GOOGLE_APPLICATION_CREDENTIALS`** — the path (relative to the Drupal root) to
  a JSON file holding your Google Cloud authentication credentials, for example
  `../files/my-project-5115.json`. Keep this file outside the web root and out of
  version control.
- **`GOOGLE_CLOUD_PROJECT`** — your Google Cloud project name, for example
  `my-gcp-project-5115`.

With DDEV you can set these in `.ddev/.env` (kept out of Git) and `ddev restart`,
or provide the credentials through your platform's workload identity. Because the
credentials live in the environment, no secret is stored in Drupal config.

## How to use it

From your code, build a `Trace`, then call `queueTrace()` on the
`google_trace.helper` service to buffer it; cron flushes the queue to Cloud Trace.
Use `insertTrace()` if you need synchronous delivery. Instrument custom spans
around slow service calls to see their latency in Cloud Trace.
