# Configure API call logging

Form `ConfigForm` at **`/admin/config/apigee-edge/debug`** (route `apigee_edge_debug.settings`,
permission `administer apigee edge`) edits config object `apigee_edge_debug.settings`.

| Setting | Default | Effect |
|---|---|---|
| `formatter` | `full_html` | Which `DebugMessageFormatter` plugin renders the request/response (`full_html`, `simple`, `curl`). |
| `log_message_format` | `<pre>{request_formatted}</pre>…{response_formatted}…{stats}` | The log entry template; tokens below. |
| `mask_organization` | `true` | Replaces the org name in the request URI path with `***organization***`. |
| `remove_credentials` | `true` | Strips the `Authorization` header and masks secrets in the request/response before logging. |

## Log format tokens
- `{request_formatted}` — the formatted HTTP request.
- `{response_formatted}` — the formatted HTTP response (the form warns this may contain sensitive
  data such as app credentials).
- `{stats}` — transfer statistics of the call.

## What gets logged, and when
- The decorated connector adds header `X-Apigee-Edge-Api-Client-Profiler` to Apigee SDK requests.
- Middleware `ApiClientProfiler` registers a Guzzle `on_stats` callback; when the call finishes it
  formats request/response/stats and writes to the `apigee_edge_debug` logger channel. Level is
  DEBUG normally, WARNING for HTTP >= 400, ERROR when there is no response.
- Requests **without** the header are skipped, so only Apigee calls are logged.

## Sanitization (when `remove_credentials` is on)
The formatter base removes the `Authorization` header and masks values before rendering:
- on `POST /oauth/token` request bodies: `refresh_token`, `mfa_token`, `username`, `password`;
- in responses: `consumerKey`, `consumerSecret`, and on token responses `access_token` /
  `refresh_token`.

Turn `remove_credentials` off only in a trusted, non-production debugging context — the form's own
description notes it exists to keep authentication data out of the log.

## Set via PHP
```php
\Drupal::configFactory()->getEditable('apigee_edge_debug.settings')
  ->set('formatter', 'curl')
  ->set('mask_organization', TRUE)
  ->set('remove_credentials', TRUE)
  ->save();
```

Config schema: `config/schema/apigee_edge_debug.schema.yml` (`formatter`, `log_message_format`,
`mask_organization`, `remove_credentials`).
