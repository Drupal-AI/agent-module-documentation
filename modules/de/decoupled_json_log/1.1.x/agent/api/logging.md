<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Creating logs (decoupled_json_log)

Entity type: `log_json` (JSON:API type `log_json--<bundle>`, default bundle `error`).
Fields: `label` (required string), `log` (required JSON), `device_info` (JSON). `uid` and `created` are server-stamped on create — never trust client values.

## JSON:API create (only POST is exposed)
```
POST /jsonapi/log_json--error
Accept: application/vnd.api+json
Content-Type: application/vnd.api+json
X-CSRF-Token: <token from /session/token for cookie auth>

{ "data": { "type": "error",
  "attributes": { "label": "FrontendFatalError",
    "log": "{...stringified error...}", "device_info": { ... } } } }
```
- PATCH and DELETE routes for this entity are removed by the route subscriber; GET is gated behind `administer log_json types`. Do not expect to read entries back via the API.
- REST is also available (config `entity.log_json`): POST only, formats json/xml, cookie auth.
- Grant `create log_json` to the roles that should log (often anonymous for public apps).

## Rate limits (per log type)
`RateLimitPerUser` rejects creation once a user (or anonymous) exceeds the configured count within the rolling interval. **Counts are per bundle**, so entries of one log type never consume another type's allowance. Site-wide defaults in `decoupled_json_log.settings`:
- `rate_limit.count_anon` (default 500) — max per interval for the shared anonymous account.
- `rate_limit.count_auth` (default 50) — max per interval for each authenticated user.
- `rate_limit.interval_seconds` (default 86400) — rolling window length.

Each log type may override these via `rate_limit_count_anon`, `rate_limit_count_auth`, `rate_limit_interval_seconds` on its type form (NULL/empty inherits the default). A count of `0` rejects every client-validated submission to that type — useful for server-only types (programmatic `save()` skips entity validation, so server writes still succeed). Adjust defaults at `/admin/config/decoupled_json_log`.

## Payload size caps
`MaxPayloadSize` rejects an entry whose field exceeds the byte limit and logs a warning to the `decoupled_json_log` channel:
- `max_payload_bytes.log` (default 65536 = 64 KB) — caps the `log` field.
- `max_payload_bytes.device_info` (default 8192 = 8 KB) — caps the `device_info` field.

Empty fields are skipped; size is measured in bytes (`strlen`). Both configurable on the settings form.

## Log types
Add bundles at `/admin/structure/log_json_types` (`administer log_json types`). Manage/review entries inside Drupal admin (`/admin/content/log-json`), not via API. Logs are plain content entities — usable with Views, bulk ops, and modules like ECA for alerting.
