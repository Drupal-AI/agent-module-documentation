JSON-RPC 2.0 provides the infrastructure for building JSON-RPC 2.0 web services in Drupal: a single `/jsonrpc` endpoint, a `JsonRpcMethod` plugin type for defining callable methods, request/response validation, and per-method access control.

---

The module exposes one controller route, `POST|GET|OPTIONS /jsonrpc` (permission `use jsonrpc services`), that decodes a JSON-RPC 2.0 request (single or batch), maps it to registered method plugins, checks access, executes them, and returns a spec-compliant response. Methods are plugins discovered via the `#[JsonRpcMethod]` PHP attribute (legacy `@JsonRpcMethod` annotation also supported), each declaring an `id`, `usage`, optional `params` (each a `JsonRpcParameterDefinition` with either a JSON-Schema `schema` or a parameter `factory`), an `output` schema, and an `access` array of permissions. Parameters are transformed by factories — `RawParameterFactory` (default, pass-through), `EntityParameterFactory` (loads an entity by `{type, uuid}`), and `PaginationParameterFactory` (`{limit, offset}`). Request and response bodies are validated against JSON Schema using the `e0ipso/shaper` library and `justinrainbow/json-schema`. The `Handler` service orchestrates execution inside a render context (capturing cacheability), and an `ErrorHandler` maps exceptions to JSON-RPC error objects. Access is enforced twice: the route requires `use jsonrpc services`, and each method's `access` permissions are checked before execution (`Handler::checkAccess`). Allowed authentication providers for the endpoint are chosen on the settings form (`/admin/config/system/jsonrpc`, `administer jsonrpc`): basic auth and OAuth2 on by default, cookie and JWT off. The two submodules add ready-made methods (`jsonrpc_core`) and a discovery/self-documentation API (`jsonrpc_discovery`). Requires PHP 8.3.

---

- Build a JSON-RPC 2.0 API for a decoupled/headless front end.
- Expose a custom server action as a callable method plugin (`#[JsonRpcMethod]`).
- Accept batched RPC calls in a single HTTP request.
- Validate incoming params against a JSON Schema before executing.
- Load an entity parameter by type + UUID with `EntityParameterFactory`.
- Paginate a method's results with `PaginationParameterFactory` (`limit`/`offset`).
- Gate each method behind specific Drupal permissions via its `access` array.
- Require an authenticated caller by choosing auth providers (basic_auth/oauth2/cookie/jwt) on the settings form.
- Return spec-compliant JSON-RPC error objects for invalid requests/params.
- Attach cacheability metadata to RPC responses automatically.
- Set custom response headers per method (`responseHeaders`).
- Send notifications (no `id`) that execute without a response body.
- Scaffold a new method class with the `drush generate jsonrpc:method` generator.
- Provide a machine-discoverable API surface via the discovery submodule.
- Use core-provided methods (cache rebuild, maintenance mode, permissions, plugins) via `jsonrpc_core`.
- Integrate with OAuth2/JWT contrib modules for token-based API auth.
- Implement custom parameter factories for domain-specific input coercion.
- Support both PHP-attribute and legacy-annotation method definitions.
- Return typed results validated against each method's `output` schema.
- Power an admin/automation client that drives Drupal over RPC.
