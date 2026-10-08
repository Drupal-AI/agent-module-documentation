<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Creating logs (decoupled_json_log)

Entity type: `log_json` (JSON:API type `log_json--<bundle>`, default bundle `error`).

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
- PATCH and DELETE routes for this entity are removed by the route subscriber; GET is admin-permission gated. Do not expect to read entries back via the API.
- Grant `create log_json` to the roles that should log (often anonymous for public apps).

## Rate limits
`RateLimitPerUser` rejects creation once a user (or anonymous) exceeds the configured daily count (defaults 500 anon / 50 authenticated). Adjust at `/admin/config/decoupled_json_log`.

## Log types
Add bundles at `/admin/structure/log_json_types` (`administer log_json types`). Manage/review entries inside Drupal admin, not via API.
