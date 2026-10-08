# Configuration

Configuring MCP Server has three parts: choose which capabilities to expose as MCP
tools, decide how each is authenticated and who may reach the endpoint, and connect
your AI client.

## 1. Expose Tool API plugins as MCP tools

1. Make sure the capability you want exists as a **Tool API plugin** — either one
   you wrote in a custom module (see the Tool API documentation) or one from a
   ready‑made set such as the **Tool Belt** module.
2. Go to **Configuration → Web services → MCP Server → Tools**
   (`/admin/config/services/mcp-server/tools`).
3. Click to add an **MCP Tool Configuration** and:
   - Enter the **MCP tool name** and **machine name**.
   - Select the **Tool API tool ID** (autocomplete).
   - Configure the tool's settings, including its **authentication mode** (below).
4. Save. Tools are discovered from these configuration entities, so what you add
   here is exactly what an assistant sees.

## 2. Set per‑tool authentication

Each tool configuration has an authentication mode:

- **Required** — an OAuth2 Bearer token with the specified **scopes** is mandatory.
  Requests without auth get HTTP 401; requests with insufficient scopes get HTTP 403.
  Use this for anything that reads non‑public data or can make changes.
- **Disabled** — no authentication checks. Use this **only** for public, read‑only
  tools, and be deliberate about it.

The HTTP transport's OAuth 2.1 support comes from the **Simple OAuth 2.1** module and
integrates with Drupal's authentication system. Anonymous protocol handshakes (such
as `initialize`) are handled gracefully.

## 3. Grant endpoint access — and mind the account

Reaching MCP Server at all requires the **`access mcp server`** permission, which
**ships ungranted by default**. Grant it (under **People → Permissions**) only to the
roles that should reach the endpoint, and grant the separate prompt‑discovery
permission only where needed.

The single most important rule: **every tool call executes as a specific Drupal user,
with that user's permissions.** The account *is* the security boundary. Create a
dedicated **service account** with the narrowest role that can do the task, rather
than pointing an assistant at an administrator session — an assistant with an admin
session can do anything an admin can. And because a model that reads content can be
manipulated by that content into taking actions, treat everything it reads as
untrusted input to its own instructions.

## 4. Connect a client

**STDIO (command line):** point your MCP client at the Drush command. For example, a
Claude Desktop configuration entry:

```json
{
  "mcpServers": {
    "drupal": {
      "command": "vendor/bin/drush",
      "args": ["mcp:server"],
      "cwd": "/path/to/your/drupal/site"
    }
  }
}
```

**HTTP (web‑based):** the module serves an HTTP MCP endpoint (relocatable via the
`mcp_server.base_path` parameter). Configure your client with that URL and the
`http` transport, and supply the OAuth2 credentials for any tools set to *Required*.

## Test it

Use the MCP Inspector or a client such as Claude Code to connect, list the tools you
exposed, and confirm each behaves as expected — including that a token‑protected tool
is refused without valid auth.
