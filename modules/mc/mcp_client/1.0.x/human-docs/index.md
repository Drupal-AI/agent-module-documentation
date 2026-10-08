# MCP Client — manual setup guide

**MCP Client** (`mcp_client`) lets Drupal connect **out to** external **Model Context
Protocol (MCP)** servers and expose their tools to Drupal's **AI** modules as
function‑call plugins. MCP is a standard protocol for communication between AI
applications and external tools or data sources; this module is the *client* side of
it. Where a module like MCP Server exposes Drupal's own capabilities to AI clients,
MCP Client goes the other way — it reaches out to other people's MCP servers so your
AI agents in Drupal can use their tools (file systems, databases, APIs, and so on).

You register each external server as a configuration entity, and MCP Client
discovers the tools that server offers and surfaces the ones you enable as `tool`
plugins that the **AI** and **AI Agents** modules can call. You can connect to many
servers at once and pick exactly which of their tools become available.

It supports two **transport types**:

- **HTTP (Streamable HTTP)** for remote MCP servers reachable over HTTP/HTTPS — you
  provide the endpoint URL, optional headers, and a timeout.
- **STDIO (Process)** for MCP servers you run as a local process (a Node.js or
  Python program, for example) — you provide the command, an optional working
  directory, and environment variables.

Two security points are worth understanding up front. First, credentials — HTTP
`Authorization` headers and STDIO environment variables — are stored through the
**Key** module and resolved at call time, so secrets don't sit in plain
configuration. Second, the whole configuration surface is **admin‑only** (permission
`administer mcp server`): the server URL, command, and credentials are all set by an
administrator, never supplied by a web request, so there's no request‑driven SSRF.
But note that the **STDIO transport runs a local command by design**, so
`administer mcp server` is effectively command‑execution on your host — grant it only
to fully trusted administrators.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which pulls the
   AI, AI Agents, Key, and Tool dependencies plus the MCP SDK) and enable the module.
2. [Configuration](configuration/index.md) — add an MCP server (HTTP or STDIO),
   store credentials in Key entities, and enable the tools to expose.

## Where it lives in the admin menu

You manage servers at **Administration → Structure → MCP Servers**
(`/admin/structure/mcp-server`), all gated by the `administer mcp server` permission.
Create Key entities for any secrets at **Configuration → System → Keys**
(`/admin/config/system/keys`).
