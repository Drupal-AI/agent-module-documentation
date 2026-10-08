<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
View API Response lets administrators define external HTTP API endpoints as config entities and inspect their live responses rendered as a PHP array.
---
Admins create `view_api_response_api_type` config entities (admin permission `administer site configuration`) at `/admin/structure/view-api-response`, each storing a server URL, HTTP method, optional headers (newline `name|value` pairs), optional basic auth username/password, optional proxy, and a source type (`json`/`xml`). The `ViewApiResponseController::getResponse()` route (`/admin/view-api/response?type=<id>`, permission `Access View API Response`) loads the matching entity, assembles Guzzle options, calls the URL via `ApiCall::getRequest()` (core `http_client`), decodes JSON or converts XML to an array, and prints the result with `print_r()` inside `<pre><code>` `#markup`.

Operational notes: the request URL, headers, auth credentials and proxy are all admin-configured on the config entities (`administer site configuration`). The *viewing* route uses a separate custom permission `Access View API Response`; grant it only to roles that should trigger the outbound call and see the raw response body. The response body is emitted via `print_r()` into `#markup`; `#markup` is admin-XSS-filtered, but the content originates from a remote server. No TLS options are disabled (Guzzle defaults apply).

Typical setup: add an API type with its URL/method/headers/auth, then open the response page to inspect the returned data.
---
- Register an external REST API endpoint as a config entity.
- Inspect a JSON API's live response as a PHP array.
- View an XML API response converted to array form.
- Send custom request headers (`name|value` per line).
- Attach HTTP basic auth credentials to the call.
- Route the request through a configured proxy.
- Choose GET/POST (or other) HTTP method per endpoint.
- Debug a third-party API integration from the admin UI.
- Compare responses across several configured endpoints.
- List and manage all API types in one collection view.
- Restrict who can view responses via the custom permission.
- Prototype an API integration before writing code.
- Verify auth headers produce the expected response.
- Check an endpoint's payload shape during development.
- Delete or edit stored API type definitions.
