<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# View API Response — configuring API types

**Collection:** `/admin/structure/view-api-response` (add/edit/delete
`view_api_response_api_type` config entities; admin_permission
`administer site configuration`).

Each API type (`ApiTypeForm`) stores:
- `server_url` — target endpoint.
- `method` — HTTP method passed to Guzzle.
- `header` — newline-separated `Name|Value` pairs.
- `auth_status` + `username` / `password` — optional HTTP basic auth.
- `proxy_status` + `proxy` — optional outbound proxy.
- `source` — `json` (decoded) or `xml` (`simplexml_load_string` → array).

**Viewing:** `/admin/view-api/response?type=<id>` (permission
`Access View API Response`) loads the entity, builds Guzzle options in
`ViewApiResponseController::getResponse()`, calls `ApiCall::getRequest()`
(`\Drupal::httpClient()`), and prints the decoded result with `print_r()`.

**Cautions for agents:**
- Grant the viewing permission only to roles that should see API responses.
- The outbound URL is admin-controlled; treat editors of these entities as
  trusted.
- TLS verification is left at Guzzle defaults (not disabled).
