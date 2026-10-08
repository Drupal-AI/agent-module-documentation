# Endpoint, dispatch & access

## Route

`jsonrpc.handler` → `HttpController::resolve`, `path: /jsonrpc`, `methods: [POST, GET, OPTIONS]`,
requirement `_permission: 'use jsonrpc services'`, `options._auth: []` (populated at runtime from config by
`JsonRpcRouteSubscriber`, see settings doc). `OPTIONS` is handled as a CORS preflight (`preflight()`).

## Request forms

- **POST**: body is the JSON-RPC payload (`Json::decode($request->getContent())`).
- **GET / OPTIONS**: payload is the `query` query-string parameter (`?query=<url-encoded JSON>`). Responses are
  cacheable and vary on `url.query_args:query`.
- Single object or an array (batch). A request without an `id` is a **notification** (executes, returns no
  response entry); an all-notifications batch yields HTTP 204.

## Flow (`HttpController` + `Handler`)

1. `getRpcRequests()` → `RpcRequestFactory` (Shaper) validates the envelope against `Shaper/request-schema.json`
   and builds `Request` objects; params are coerced by each param's factory.
2. `Handler::batch()` → `doRequest()` per request, each run inside a `RenderContext` (bubbled cacheability is
   attached to the RPC response).
3. `doExecution()`: resolves the method plugin, calls `checkAccess($method)`, instantiates it
   (`methodManager->createInstance($id, [JSONRPC_REQUEST_KEY => $request])`), and calls
   `execute($params)` (a `ParameterBag`).
4. Result is wrapped in a `Response`, its `output` schema attached, method `responseHeaders` merged.
5. `RpcResponseFactory` validates + serializes the response(s) to JSON; HTTP status 200 (or 204 for
   notifications, 400/500 for errors).

## Access enforcement

Two layers:
- Route permission `use jsonrpc services` (must hold to reach `/jsonrpc` at all).
- Per method: `Handler::checkAccess()` calls `$method->access('execute', NULL, TRUE)`; if not allowed it throws an
  `invalidRequest` JSON-RPC error. `JsonRpcMethodDefinition::access()` starts from `AccessResult::allowed()` and
  `andIf()`s `allowedIfHasPermission()` for **each** permission in the method's `access` array (AND semantics). A
  method may instead set `access` to a callable for custom logic.
  - An empty `access` array leaves the result at `allowed()` → the method is callable by anyone with
    `use jsonrpc services`. Always declare `access`.

## Errors

`ErrorHandler` + `JsonRpcException` map thrown errors to JSON-RPC error objects (`-32600` invalid request,
`-32602` invalid params, `-32601` method not found, `-32603` internal error, etc.). Server errors are logged to
the `jsonrpc` channel.

## Services

- `jsonrpc.handler` (`Handler`) — orchestration; `supportedMethods()`, `availableMethods($account)` (access-filtered),
  `getMethod($id)`, `batch()`.
- `plugin.manager.jsonrpc_method` — method plugin manager (private).
- `jsonrpc.schema_validator` (`JsonSchema\Validator`), `jsonrpc.route_subscriber`, `jsonrpc.options_request_listener`.
