# Configuration

MCP has a single settings form that controls the transport mode and which
plugins are exposed. Everything else — the actual tools and resources — comes
from the enabled plugins.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Web services → MCP Configuration**, or navigate
   directly to `/admin/config/mcp`.

There is no `configure` link in the module's info file, so the form is reached
through the *Web services* menu link or the route above.

## Enable HTTP SSE

The **Enable HTTP SSE** checkbox chooses how clients talk to Drupal:

- **On** *(default)* — Drupal acts as the MCP server over Server-Sent Events. A
  client opens the `GET /mcp/get` stream to receive a `sessionId`, then POSTs its
  JSON-RPC messages to `/mcp/post?sessionId=…`; responses come back over the open
  stream (with a 60-second heartbeat). Use this for clients that expect a
  streaming MCP transport.
- **Off** — the streaming endpoint is disabled and `POST /mcp/post` simply
  returns each JSON-RPC response directly in the HTTP body, request/response
  style. With SSE off, the session check on `/mcp/post` is skipped entirely.

Pick whichever your MCP client supports; most desktop clients work with SSE on.

## Per-plugin settings

Below the SSE toggle, the form lists **one section (a vertical tab) per
discovered plugin**, including plugins that are currently disabled. Each section
has:

- An **Enable** checkbox. Only enabled plugins contribute their tools and
  resources — disabling one immediately removes its tools from what clients see in
  `tools/list` (aggregation only includes plugins that pass their requirements
  check *and* are enabled).
- An **Additional Configuration** area, shown only when the plugin is enabled and
  only if that plugin defines its own settings. Plugins with no options show "No
  additional configuration options available." What appears here depends entirely
  on the plugin — for example, the **MCP Content** submodule's plugin lets you
  restrict which content types are exposed to clients.

The built-in **General** plugin has no extra settings; it simply returns basic
site info (name, slogan, Drupal version) when enabled.

## Save

Click **Save configuration**. Your changes take effect immediately: newly enabled
plugins start advertising their tools, and disabled ones stop. Remember that
enabling a plugin makes its tools reachable by anyone who can reach the endpoints
— review the [auth and access
model](../index.md#a-note-on-the-auth-and-access-model) before enabling anything
that reads content or performs actions.
