# JSON-RPC 2.0 Discovery — agent index

Adds two GET discovery endpoints that list JSON-RPC methods for the current (access-filtered) user. Depends on
`jsonrpc` + core `serialization`. No config/permissions of its own.

- **The discovery routes, controller, access filtering, normalizer** → [api/discovery.md](api/discovery.md)

Key facts:
- Routes (permission `use jsonrpc services`, `_auth: [cookie, basic_auth, oauth2]`, GET):
  `jsonrpc.method_collection` `/jsonrpc/methods`, `jsonrpc.method_resource` `/jsonrpc/methods/{method_id}`.
- `DiscoveryController` filters via `$method->access('view', NULL, TRUE)` (view delegates to execute access) so a
  caller only sees methods it may call.
- Serialized by `DefinitionNormalizer` (service `serializer.normalizer.jsonrpc_definition`).
