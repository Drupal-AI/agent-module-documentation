Apigee Edge Debug is a developer helper for the Apigee Edge module. It logs the requests, responses,
and transfer statistics of every Apigee Management API call the module makes, so developers can see
exactly what Drupal sends to and receives from Apigee when troubleshooting a connection or behavior.

---

The module decorates the Apigee SDK connector to tag its outgoing requests with a marker header, and
registers a Guzzle HTTP client middleware that, on each finished Apigee call, formats the request,
response, and timing and writes them to a dedicated logger channel. A pluggable formatter
(`full_html`, `simple`, or `curl`) controls the rendering, and a configurable message template with
`{request_formatted}`, `{response_formatted}`, and `{stats}` tokens controls the log entry. By
default it masks the Apigee organization name and strips authentication data (Authorization header,
OAuth tokens, passwords, consumer key/secret) so credentials are not written to logs. Only requests
carrying the module's profiler header are logged, so non-Apigee traffic is left alone. It depends on
`apigee_edge` and is configured at `/admin/config/apigee-edge/debug`.

---

- Inspect the exact HTTP request Drupal sends to the Apigee Management API.
- Inspect Apigee API responses to debug why an app or product operation failed.
- View transfer/timing statistics for slow Apigee calls.
- Reproduce an Apigee API call outside Drupal by logging it as a `curl` command.
- Get a concise one-line summary of each API call with the `simple` formatter.
- Keep credentials out of the logs with the default sanitization on.
- Temporarily log full credentials in a trusted debug environment (sanitization off).
- Mask the organization name in logged request URIs.
- Customize the log entry template with request/response/stats tokens.
- Escalate log severity automatically for failed (>=400) Apigee calls.
- Diagnose OAuth token exchange problems against Apigee X / hybrid.
- Confirm which API products or credentials an app call touched.
- Dump Apigee call data inline via Devel/Kint during development.
- Verify the module's connection settings by watching the actual requests.
- Filter Apigee traffic in logs by its dedicated logger channel.
