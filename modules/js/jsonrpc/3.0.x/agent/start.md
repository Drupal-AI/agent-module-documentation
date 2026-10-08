# JSON-RPC 2.0 — agent index

Infrastructure for JSON-RPC 2.0 services: the `/jsonrpc` endpoint, a `JsonRpcMethod` plugin type, param
factories, JSON-Schema validation (via `e0ipso/shaper`), and per-method access. PHP 8.3. No Drush command,
but ships a code generator. Submodules add methods and discovery.

- **Endpoint, auth settings, request/response flow, dispatch & access** → [api/handler.md](api/handler.md)
- **Defining a method plugin: attribute, params, factories, access, output schema** →
  [plugins/method.md](plugins/method.md)
- **Auth-provider settings form (`/admin/config/system/jsonrpc`)** → [configure/settings.md](configure/settings.md)
- **Permissions** → [permissions/permissions.md](permissions/permissions.md)
- **`drush generate jsonrpc:method` scaffolder** → [drush/generate.md](drush/generate.md)

Submodules (own docs):
- `jsonrpc_core` (ready-made core methods) → [../../modules/jsonrpc_core/3.0.x/agent/start.md](../../modules/jsonrpc_core/3.0.x/agent/start.md)
- `jsonrpc_discovery` (self-documentation API) → [../../modules/jsonrpc_discovery/3.0.x/agent/start.md](../../modules/jsonrpc_discovery/3.0.x/agent/start.md)

Key facts:
- Route `jsonrpc.handler`: `POST|GET|OPTIONS /jsonrpc`, permission `use jsonrpc services`, `_auth` set from config.
- Method plugin manager `plugin.manager.jsonrpc_method`; discovery via `#[JsonRpcMethod]` attribute (or legacy
  `@JsonRpcMethod` annotation) in `Plugin/jsonrpc/Method/`.
- `Handler::doExecution()` → `checkAccess($method)` before running; access = AND over the method's `access`
  permissions.
- A method that declares **no** `access` permissions requires only `use jsonrpc services`.
