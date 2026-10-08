<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Google Trace forwards performance traces from Drupal to Google Cloud Trace using the official `google/cloud-trace` PHP client, buffering spans through Drupal's queue so requests aren't blocked on the outbound API call.

---

The `google_trace.helper` service (`TraceHelper`) constructs a `TraceClient` (which authenticates via Google Application Default Credentials from the environment), and offers `getTrace()`, `insertTrace()` and `queueTrace()`. Typical use is to build a `Trace` during a request and call `queueTrace()`, which pushes the trace onto the `google_trace_queue`; the `TraceQueue` queue worker later calls the client to insert it into Cloud Trace on cron. Client and insertion errors are logged to the `google_trace` logger channel rather than thrown.

Security/operational notes: the module ships no routes, forms, permissions or config schema — it is a developer integration only. Authentication relies entirely on ambient Google credentials (e.g. `GOOGLE_APPLICATION_CREDENTIALS` or workload identity), so no secret is stored in Drupal; all traffic is outbound HTTPS handled by the Google SDK. There is no inbound callback surface.

---
- Send Drupal request traces to Google Cloud Trace
- Buffer traces via the `google_trace_queue` to avoid blocking requests
- Flush queued traces to Cloud Trace on cron
- Get a fresh `Trace` object from `google_trace.helper`
- Insert a trace synchronously with `insertTrace()`
- Enqueue a trace asynchronously with `queueTrace()`
- Authenticate through Google Application Default Credentials
- Instrument custom code paths with spans
- Monitor latency of slow endpoints in Cloud Trace
- Correlate Drupal performance with GCP telemetry
- Keep the trace token/credentials out of Drupal (env-based)
- Log integration errors to the `google_trace` channel
- Combine with cron scheduling for batch trace delivery
- Flush queued traces manually via `drush queue:run google_trace_queue`
- Trace custom spans around slow service calls
- Degrade gracefully when GCP credentials are absent
- Avoid storing any GCP secret inside Drupal config
