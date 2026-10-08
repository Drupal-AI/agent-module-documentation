# HTTP Request Mock — manual setup guide

**HTTP Request Mock** (`http_request_mock`) is a **testing tool for developers**. It
intercepts the outbound requests your code makes through Drupal's `http_client`
service and lets a plugin return a fabricated ("mocked") response — so functional
tests can exercise code that talks to an external web service **without ever making
a real network call**. Your tests stay fast, deterministic, and independent of
whether the third-party service is up.

It works by registering a Guzzle middleware on the shared `http_client`. For each
outgoing request it asks a plugin manager for the first matching **ServiceMock**
plugin; if one applies, that plugin's response is returned immediately and the real
request never leaves the server. If no plugin matches, the request falls through and
goes out for real.

You supply the mocks as ServiceMock plugins — one per service you want to fake —
and you can prioritize competing mocks by weight, narrow the active set per test,
and swap or reweight plugins with an alter hook. The module ships an `example.com`
test plugin (under its `tests/` directory, not enabled by the base module) as a
reference.

> **Not for production.** Once enabled, the middleware is global — any installed
> ServiceMock plugin can intercept and replace real outbound responses. Enable this
> module only in test/CI environments. With it disabled (the normal production
> state) it registers nothing and intercepts nothing.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (in test/CI only).

There is **no configuration page** for this module — it has no routes, forms, or
permissions. Everything is code plus a State value, as described below.

## How to use it

1. In your test environment, **enable this module** plus the module(s) that ship
   your ServiceMock plugins.
2. **Write a ServiceMock plugin** for each service you want to fake. A plugin lives
   in a module's `src/Plugin/ServiceMock/`, carries the `#[ServiceMock(...)]`
   attribute (legacy `@ServiceMock` annotation also works), implements
   `ServiceMockPluginInterface`, and provides two methods:
   - `applies(RequestInterface $request, array $options): bool` — return `TRUE` for
     the requests this plugin should handle (for example, match on host or URL).
   - `getResponse(RequestInterface $request, array $options): ResponseInterface` —
     return the canned PSR-7 response.
3. **Control which plugin wins.** Plugins are sorted by `weight` (ascending); the
   first whose `applies()` returns `TRUE` handles the request. Lower weight = higher
   priority.
4. **Optionally narrow the active set per test** by setting the
   `http_request_mock.allowed_plugins` State variable to an array of plugin IDs;
   leaving it empty or unset allows all plugins. You can also remove, reweight, or
   swap plugins with `hook_service_mock_info_alter(&$plugins)`.

See the sibling [`agent/plugins/http_request_mock.md`](../agent/plugins/http_request_mock.md)
for a full example plugin.
