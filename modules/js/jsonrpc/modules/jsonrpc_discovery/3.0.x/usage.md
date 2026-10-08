JSON-RPC 2.0 Discovery adds self-documentation endpoints that list the available JSON-RPC methods (and a single method's definition) for the current user, so clients can discover the API at runtime.

---

This submodule exposes two GET routes: `/jsonrpc/methods` returns a JSON document of all methods the current user is allowed to see, and `/jsonrpc/methods/{method_id}` returns the definition of one method. Both require the `use jsonrpc services` permission and accept cookie, basic_auth, or oauth2 authentication. The `DiscoveryController` filters methods with each method's `access('view', ...)` result (so a client only sees methods it could call), and serializes them with a dedicated `DefinitionNormalizer` (registered as a `serializer.normalizer.jsonrpc_definition` service, depends on core `serialization`). Responses are cacheable and carry the access cacheability so they invalidate correctly. The method collection returns a `{data: [...], links: {self}}` envelope; requesting an unavailable method id yields a cacheable 404. Depends on `jsonrpc` and core `serialization`.

---

- Discover all callable JSON-RPC methods at runtime via `GET /jsonrpc/methods`.
- Fetch a single method's definition via `GET /jsonrpc/methods/{method_id}`.
- Build a client that adapts to whichever methods a server exposes.
- Show users only the methods their permissions allow (access-filtered list).
- Generate API documentation from the live method registry.
- Let a decoupled front end introspect available server operations.
- Drive a form/UI from a method's parameter definitions.
- Cache discovery responses with correct access-based invalidation.
- Return a 404 for methods the caller cannot access or that don't exist.
- Provide a self-describing API surface for tooling and SDK generation.
- Authenticate discovery with cookie, basic auth, or OAuth2.
- Keep the method catalog in sync automatically as methods are added/removed.
- Serialize method definitions consistently via a custom normalizer.
- Validate client assumptions about params/output against the published definitions.
- Support batch clients that first discover, then call.
- Expose the `self` link for HATEOAS-style navigation of the collection.
- Audit which methods are visible to a given role by calling as that user.
