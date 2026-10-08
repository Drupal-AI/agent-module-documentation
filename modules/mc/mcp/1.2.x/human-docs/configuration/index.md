# Configuration

MCP has three admin screens, all under **Configuration → Web services → MCP
Configuration** and all gated by the **Administer MCP configuration** permission.
Before a client can connect at all, someone must also hold the **Use MCP server**
permission (not granted to anyone by default).

## 1. Authentication (`/admin/config/mcp`)

This is the **Settings** form. It decides how clients prove who they are.

- **Enable Auth** — off by default. Its help notes that while off, "the server will
  allow clients to connect with anonymous permissions" — meaning route access still
  requires the **Use MCP server** permission, but no additional credential is demanded
  beyond cookie/OAuth2. Turn this on to require a token or Basic auth.
- **Enable Token Auth** — requires a **Secret key** (a Key entity that holds the shared
  token) and a **Token User** (the Drupal user the token authenticates as). A client
  sends the raw token as an `Authorization: Basic <base64(token)>` header (no colon).
- **Enable Basic Auth** — standard username:password Basic auth; the client then acts as
  that Drupal user with their role permissions.
- **OAuth** — informational only. If an OAuth2 provider is configured on the site,
  clients can authenticate with it; there is nothing to set here.

If you enable Auth, at least one of Token or Basic auth must be selected (the form
enforces this). Because the token is a secret, store it in a Key entity backed by an
environment variable rather than committing it — with DDEV,
`ddev dotenv set .ddev/.env --mcp-token=<value>` then create a Key with the env
provider.

## 2. Plugins (`/admin/config/mcp/plugins`)

This page lists every MCP plugin. For each one you can enable it and open its own
settings page. Only **general** is enabled out of the box.

On a plugin's settings page (`/admin/config/mcp/plugins/{plugin}/settings`) you get:

- **Enable plugin** — the master on/off switch for that plugin.
- **Allowed roles** — which roles may use it; leave empty to allow all authenticated
  users.
- **Additional Configuration** — the plugin's own options. For example, **content**
  shows a checkbox per content type (only the ones you tick are exposed as resources);
  **jsonapi** lets you choose which resource types are allowed (and additionally requires
  the *Access content* permission).
- **Tool Settings** — one section per tool the plugin provides, where you can toggle the
  tool on/off, see the machine name that will be sent to the LLM, write a **Custom
  Description** (what the assistant sees), and set per‑tool **Allowed roles**.

A note on the **drush** plugin: it is disabled by default and every command is off; it
runs an allow‑list of commands and is intended for development/ops only. Enable it
deliberately, and only in trusted environments.

## 3. Connection (`/admin/config/mcp/connection`)

This page generates **copy‑paste client configuration** for Claude Desktop, Claude
Code, and Cursor, pointing at your site's `/mcp/post` endpoint with the authentication
you configured. Paste it into your MCP client and it will connect, list the tools and
resources you enabled, and start calling them.

## How access is enforced

Every request is checked more than once: the route requires the **Use MCP server**
permission and a valid authentication method; each plugin re‑checks its enable flag and
allowed roles; each tool re‑checks its own enable flag and roles; and the underlying
tool/resource code still runs Drupal's normal entity and JSON:API access checks. The
endpoint is also flood‑protected against brute‑forcing of Basic/token credentials. In
short, a tool can never expose more than the authenticated user is permitted to see.
