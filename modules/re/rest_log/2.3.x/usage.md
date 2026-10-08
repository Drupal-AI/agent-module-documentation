<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
REST Log records Drupal REST API requests and their responses as `rest_log` content entities — method, URI, headers, cookies, payload, status, response headers, response body and timing — and exposes them as an admin report.

---

Debugging a decoupled or REST integration means answering "what did the client actually send, and what did we return?" — a question that is hard to answer after the fact without a record. REST Log keeps that record on the server side. A kernel event subscriber (`RestLogSubscriber`) watches every response, and for routes that are REST-module resources (detected by `RestPageRouteCheck`, which matches routes carrying a `_rest_resource_config` default) it writes one `rest_log` entity per request. Because each log is an entity, the data is queryable, viewable through a shipped Views report at `/admin/reports/rest_log`, gated by its own access handler and its `access rest log list` permission, and cleaned up automatically. A settings form (`/admin/config/development/logging/rest_log`) controls a `maximum_lifetime` retention window — cron deletes older rows, and setting it to 0 disables cleanup — and an `include_same_host` toggle to keep or drop requests whose referrer is the same host. It is most useful switched on for an investigation on a REST endpoint and given a sensible lifetime, rather than treated as a permanent record: responses served from Drupal's page cache do not run the subscriber, so a cache hit produces no entry.

---

- See exactly what a REST client sent to a resource, from the server side.
- See the response status, headers and body Drupal returned for a request.
- Debug a decoupled front end's API calls without instrumenting the client.
- Diagnose why a REST request returns a 4xx/5xx by inspecting the stored response.
- Query captured requests and responses through the shipped Views report.
- Browse logs at `/admin/reports/rest_log` under Reports → REST API Logging.
- Restrict who can read the API logs with the `access rest log list` permission.
- Measure per-request response time (stored in milliseconds).
- Distinguish which REST resource route handled a request via the logged URI.
- Automatically expire old logs by setting a `maximum_lifetime` in seconds.
- Disable automatic cleanup by setting the maximum lifetime to 0.
- Include or exclude requests that carry a same-host referrer header.
- Bulk-delete selected log entries with the shipped delete action.
- Delete an individual log entry from its canonical/delete route.
- Capture REST exceptions — the subscriber records error responses too.
- Limit logging to REST resource routes only (core `_rest_resource_config` routes).
- Extend which routes are logged by tagging a `rest_log.route_check` service.
- Correlate a request with the user who made it via the log's owner (`user_id`).
- Compare request/response pairs across environments during migration.
- Verify a third-party integration is calling the expected endpoints and payloads.
- Confirm a client is sending the content type and body you expect.
- Keep a short-lived diagnostic trail while troubleshooting an integration.
