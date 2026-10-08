<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google Trace (google_trace) — agent index

**Queue-backed helper that ships application traces to Google Cloud Trace.**

- **Version:** 1.0.x
- **Core:** ^8 || ^9 || ^10
- **Service:** `google_trace.helper` (`TraceHelper`) — `getTrace()`, `insertTrace(Trace)`, `queueTrace(Trace)`; builds `Google\Cloud\Trace\TraceClient`.
- **Queue worker:** `google_trace_queue` (`TraceQueue`) inserts queued traces on cron.
- **No** routes/permissions/forms/config schema.

**Security:** developer integration with no HTTP surface (no routes or webhooks). Authentication uses ambient Google Application Default Credentials from the environment, so no secret is stored in Drupal; all traffic is outbound HTTPS via the Google SDK. Errors are logged, not thrown.

See [api/trace.md](api/trace.md).
