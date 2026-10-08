<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
HTTP Request Mock intercepts outgoing HTTP requests made through Drupal's `http_client` service and lets a plugin return a mocked response, so functional tests can exercise code that consumes external web services without making real network calls.

---

Code that talks to a remote API is awkward to test: you do not want tests hitting the live service, and you still need deterministic responses. This module registers a Guzzle middleware (`HttpRequestMockMiddleware`, tagged `http_client_middleware`) on the shared `http_client`. For each outgoing request it consults the `plugin.manager.service_mock` manager, which returns the first **ServiceMock** plugin whose `applies()` matches the request; that plugin's `getResponse()` supplies a PSR-7 response that is returned immediately as a fulfilled promise. If no plugin matches, the request falls through to the normal handler and goes out for real.

You provide mocks as ServiceMock plugins (`src/Plugin/ServiceMock/`, `#[ServiceMock]` attribute or legacy annotation), one per service you want to fake. Plugins are ordered by `weight`; `hook_service_mock_info_alter()` can remove/reweight/swap them, and tests can restrict the active set with the `http_request_mock.allowed_plugins` State variable. The module ships an `example_com` test plugin under `tests/modules/` (not enabled by the base module) that mocks example.com. Crucially there are **no routes, forms, permissions, or admin config** — everything is code plus a State value, so there is no web-facing surface to expose.

This is a development/CI tool. Because the middleware is global once the module is enabled, it should not be enabled in production: with it disabled (the normal production state) it registers nothing; with it enabled, any installed ServiceMock plugin can intercept and replace real outbound responses. Setup: in your test, enable this module plus the module(s) that ship your ServiceMock plugins.

---

- Mock an external REST/JSON API in functional tests
- Return deterministic responses for code that calls `http_client`
- Avoid real network calls (and flakiness) in CI test runs
- Simulate HTTP error codes (403/500/timeout) to test error handling
- Provide different responses per URL/host with `applies()` matching
- Prioritise competing mocks with the plugin `weight`
- Mock example.com quickly with the shipped test plugin
- Limit active mocks per test via the `allowed_plugins` State variable
- Remove or swap a mock plugin with `hook_service_mock_info_alter()`
- Assert your code sends the right request by inspecting it in `applies()`/`getResponse()`
- Return canned JSON payloads for a third-party integration under test
- Test OAuth/token exchange flows without a live provider
- Fake a slow or paginated API to test retry/pagination logic
- Ship reusable mock plugins in a companion test module
- Keep production untouched by enabling the module only in test environments
- Stub webhook/callback verification endpoints your code calls out to
