Exposes the MCP Tools server over HTTP at /_mcp_tools with API-key authentication and a defense-in-depth request pipeline; intended for trusted internal networks and remote/containerized AI clients.

---

`mcp_tools_remote` is a transport submodule of MCP Tools. It serves the MCP protocol over HTTP using the SDK's Streamable HTTP transport, at the route `/_mcp_tools` (`McpToolsRemoteController::handle`). The endpoint is **disabled by default** and fails closed. When enabled it runs a strict pipeline before any tool executes: config `enabled` re-check, optional client IP allowlist, Origin validation (DNS-rebinding defense), Accept-header check, API-key authentication (`ApiKeyManager` — keys are hashed in State and peppered with the site private key), optional server-profile access/transport checks, per-key scope resolution, and resolution of a **configured execution user** (fails if unset, refuses uid 1 unless explicitly allowed). It then account-switches to that user and runs the request, so every tool's permission/scope check is evaluated as the configured service account. Drush commands manage API keys (`remote-key-create/list/revoke`) and provision a dedicated least-privilege executor account (`remote-setup`). Settings live at `/admin/config/services/mcp-tools/remote` (config object `mcp_tools_remote.settings`).

---

- Connect a remote or containerized AI client over HTTP: `claude mcp add drupal http://host/_mcp_tools --transport http -H "Authorization: Bearer KEY"`.
- Create a scoped API key: `drush mcp-tools:remote-key-create --label="Claude" --scopes=read,write`.
- Issue a short-lived key with a TTL for a time-boxed session (`--ttl=86400`).
- List issued keys (redacted) with `drush mcp-tools:remote-key-list`.
- Revoke a key with `drush mcp-tools:remote-key-revoke <key_id>`.
- Provision a dedicated executor user + role with granted MCP categories: `drush mcp-tools:remote-setup`.
- Restrict the endpoint to specific client IPs/CIDRs via the `allowed_ips` allowlist.
- Restrict allowed request origins (DNS-rebinding defense) via `allowed_origins`.
- Run the HTTP endpoint under a least-privilege execution user rather than uid 1.
- Keep uid-1 execution blocked by default and only override for local/dev with `allow_uid1`.
- Serve a specific server profile over HTTP (name, version, scopes, tool set) via `server_id`.
- Expose only the compact gateway tools over HTTP with `gateway_mode`.
- Run behind a reverse proxy / in Docker for an assistant that cannot spawn local Drush.
- Combine with read-only or config-only mode to bound what remote clients can change.
- Enable `mcp_tools_observability` to audit every remote tool call.
- Use per-key scopes to hand different clients read-only vs read/write access to the same endpoint.
