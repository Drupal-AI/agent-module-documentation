Exposes the MCP Tools server over STDIO through a Drush command — the recommended transport for connecting a local AI client (Claude Code, Cursor, Windsurf) to a Drupal site.

---

`mcp_tools_stdio` is a transport submodule of MCP Tools. It adds one Drush command, `mcp-tools:serve` (aliases `mcp-tools-server`, `mcp-tools:server`), implemented in `McpToolsStdioCommands`. The command builds an `Mcp\Server` via the parent's `McpToolsServerFactory` and runs it over the MCP SDK's `StdioTransport`, so the client speaks MCP on the process's stdin/stdout. It resolves a server profile (`--server`), can override the execution account (`--uid`, via `AccountSwitcher`) and the connection scopes (`--scope=read,write,admin`), and can expose all Tool API tools (`--all-tools`) or only the compact gateway tools (`--gateway`). It requires the `mcp/sdk` package (checked by `hook_requirements`). Because STDIO runs as a local process, its trust boundary is the shell that launches it; there is no network endpoint and no authentication layer of its own — access is still gated by the parent's per-tool permission + scope model against the resolved user.

---

- Connect Claude Code to a Drupal site: `claude mcp add --scope project drupal -- drush mcp-tools:serve --quiet --uid=1 --scope=read,write`.
- Add a `.mcp.json` server entry running `drush mcp-tools:serve` for Cursor/Windsurf.
- Run a read-only assistant session with `--scope=read`.
- Grant write access for a local build session with `--scope=read,write`.
- Run tools as a specific Drupal user with `--uid=<n>` (defaults to the Drush bootstrap user).
- Select a named server profile with `--server=<id>` to apply its scopes/transports/tool set.
- Expose the compact discover/info/execute surface with `--gateway` for token efficiency.
- Expose every Tool API tool (not just `mcp_tools` providers) with `--all-tools`.
- Use inside DDEV/Lando by launching the command in the web container.
- Restrict a profile to STDIO only (profile `transports: [stdio]`) so it cannot be served over HTTP.
- Drive the same tool library locally without enabling the HTTP endpoint.
- Pair with `mcp_tools_observability` to log every tool call the local client makes.
- Debug tool schemas interactively by calling `discover-tools`/`get-tool-info` in gateway mode.
- Keep production sites endpoint-free while still allowing local agent-assisted development.
- Combine with the parent's config-only or read-only mode to bound what a local agent can change.
