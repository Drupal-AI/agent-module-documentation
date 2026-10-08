# JSON-RPC 2.0 Core — agent index

Ready-made `JsonRpcMethod` plugins for core admin operations, callable at `/jsonrpc`. All are admin-gated.
Depends on `jsonrpc`. No config/permissions/routes of its own.

- **The six methods: ids, params, access, effect** → [plugins/methods.md](plugins/methods.md)

Key facts:
- Method plugins live in `src/Plugin/jsonrpc/Method/` and use the `#[JsonRpcMethod]` attribute (parent module's
  plugin type).
- Every method declares `access` (`administer site configuration` or `administer permissions`) — good reference
  implementations for the empty-access footgun documented in the parent module.
