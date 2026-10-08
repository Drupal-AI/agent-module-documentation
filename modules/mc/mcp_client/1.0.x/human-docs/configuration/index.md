# Configuration

Configuration means registering one or more external MCP servers, telling Drupal how
to reach and authenticate to each, and choosing which of their tools to expose to
your AI agents. Each server is a configuration entity managed under **Structure →
MCP Servers** (`/admin/structure/mcp-server`), and every route there requires the
**`administer mcp server`** permission.

## Before you start: store secrets in Key

If a server needs an API token, bearer token, or secret environment variable, create
a **Key** entity for it first at **Configuration → System → Keys**
(`/admin/config/system/keys`). MCP Client resolves Key references at call time, so
your secrets never sit in plain configuration.

## Add an HTTP (remote) server

1. Go to **Structure → MCP Servers** and click **Add MCP Server**.
2. Fill in:
   - **Label** — a descriptive name (e.g. "GitHub MCP Server").
   - **Transport Type** — **HTTP (Streamable HTTP)**.
   - **Endpoint URL** — the MCP server's URL (e.g. `https://example.com/mcp`).
   - **Timeout** — connection timeout in seconds (default 30).
3. Add any **HTTP headers** the server needs. For authentication, the special
   `Authorization` handling lets you point at a **Key** entity and prepend a prefix
   such as `Bearer ` to the resolved secret. Other header values are also looked up
   in the Key repository — if a value matches a Key it's replaced with the secret,
   otherwise it's sent literally.
4. **Save**, then **edit** the server to enable the specific tools you want (see
   below).

## Add a STDIO (local process) server

Use this for MCP servers you run as a local program (Node.js, Python, etc.).

1. Click **Add MCP Server**.
2. Fill in:
   - **Label** — a descriptive name.
   - **Transport Type** — **STDIO (Process)**.
   - **Command** — the full command to execute (e.g. `node /path/to/server.js`).
   - **Working Directory** — optional working directory for the process.
   - **Environment Variables** — add name/value pairs. For sensitive values (API
     keys, tokens), choose the **Key** type and select the Key you created; for
     non‑sensitive values choose **Plain text**. Configured variables are merged over
     the system environment, so `PATH` survives.
3. **Save**, then **edit** the server to enable specific tools.

> **Security caution:** the STDIO transport launches a local process — that is
> arbitrary command execution by design. Treat `administer mcp server` as a
> trusted‑admin‑only permission, and always prefer Key references over literal
> secrets.

## Enable the tools to expose

After saving a server, edit it and enable the individual tools you want to make
available. Only the tools you enable are surfaced as `tool` plugins for the AI /
AI Agents modules — enabling exactly what you need keeps the agent's capabilities
scoped. Enabled tools then appear in the AI API Explorer and in AI function‑calling
workflows.

## Multiple servers

You can register as many servers as you like and use them simultaneously; each keeps
its own transport, credentials, timeout, and enabled‑tool list.
