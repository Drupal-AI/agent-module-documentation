<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
REST & JSON API Authentication (by miniOrange) secures a Drupal site's REST and JSON:API endpoints by registering a Drupal authentication provider that requires callers to present valid credentials — API key, Basic Auth, OAuth, or JWT — before an API request is served.

---

The module adds a Drupal `authentication_provider` (`RestAPI`, provider id
`rest_api_authentication`, priority 150). When the master switch `enable_authentication` is on
(`1`), the provider's `applies()` claims incoming requests whose URI contains `/jsonapi/` or a
`?_format=` query (the JSON:API admin UI path is excluded), so those endpoints are only served
to authenticated callers. Requests select an "application" via an `auth-method` request header
(or a configured default application), and each application declares an
`authentication_method`: `0` basic_auth, `1` api_key, `2` oauth, `3` jwt, `4` external_oauth.
The matching validator (`ApiAuthenticationBasicAuth`, `ApiAuthenticationApiToken`, …) checks
the credentials — e.g. the API-key method compares an `api-key`/`Authorization: Basic` header
against the configured `api_token`. All configuration lives in the `rest_api_authentication.settings`
config object (the `applications` map, `default_application_id`, `enable_authentication`,
`authentication_method`, `api_token`, plus miniOrange customer/licensing fields). Admin forms
under `/admin/config/people/rest_api_authentication/*` cover the main auth settings, advanced
settings, headless SSO, and audit logs, and a `RestApiLogger` service records authentication
attempts to a database table. A public `/rest_api/revoke` endpoint revokes tokens. Some
methods (OAuth, JWT, headless SSO, multiple applications) are premium miniOrange features; the
Drupal-side configuration and the authentication-provider mechanics are inspectable without
contacting miniOrange.

---

- Require an API key on all JSON:API requests so anonymous callers cannot read content.
- Protect core REST resources (`?_format=json` endpoints) behind Basic Auth credentials.
- Turn API protection on or off site-wide with a single `enable_authentication` flag.
- Issue an API token to a mobile app and validate it via the API-key method.
- Authenticate a decoupled front end calling `/jsonapi/node/article` with a bearer/API key.
- Exclude the JSON:API admin configuration UI from authentication while protecting the data endpoints.
- Route a request to a specific credential set using the `auth-method` header (application id).
- Configure a default application so requests without an `auth-method` header still authenticate.
- Log every authentication attempt (success/failure) to an audit table for review.
- Review recent API authentication failures on the Audit Logs admin page.
- Purge old authentication logs via the delete-logs confirmation form.
- Choose per-application which method to use: basic auth, API key, OAuth, or JWT.
- Secure a headless Drupal backend used by a React/Next.js app.
- Prevent scraping of REST endpoints by unauthenticated clients.
- Set the expected API token that callers must present for the API-key method.
- Bypass authentication for `/user/login` so clients can still obtain sessions.
- Revoke an issued token through the `/rest_api/revoke` endpoint.
- Keep API responses out of the page cache for authenticated API requests.
- Give integration partners scoped credentials to consume the site's API.
- Enforce authentication only on API traffic, leaving normal page requests untouched.
- Prepare a Drupal site for a mobile/decoupled rollout with enforced API security.
- Audit which applications and methods are configured by reading `rest_api_authentication.settings`.
- Upgrade to premium methods (OAuth/JWT/headless SSO) when advanced auth is required.
