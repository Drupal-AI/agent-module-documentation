<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTTP Request Mock (http_request_mock) — agent index

**Intercepts outgoing `http_client` requests via a Guzzle middleware and returns mocked responses from ServiceMock plugins — a test-only tool.**

- **Version:** 1.2.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **Surface:** middleware `HttpRequestMockMiddleware` (tag `http_client_middleware`); manager `plugin.manager.service_mock`; plugin interface `ServiceMockPluginInterface` with `#[ServiceMock]` attribute (`applies()` + `getResponse()`). Alter hook `hook_service_mock_info_alter`. State var `http_request_mock.allowed_plugins`. No routes/permissions/config.
- **Selection:** first plugin (by ascending `weight`) whose `applies()` matches; else the real handler runs.

**Security:** no routes, permissions, or web-facing config — nothing for a non-admin to reach. It registers a global `http_client` middleware, so it is a dev/CI tool that must not be enabled in production; with the module disabled it intercepts nothing. No security findings.

See [plugins/http_request_mock.md](plugins/http_request_mock.md) for writing a ServiceMock plugin.
