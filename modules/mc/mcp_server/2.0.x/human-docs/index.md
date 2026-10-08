# MCP Server — manual setup guide

**MCP Server** (`mcp_server`) implements the **Model Context Protocol (MCP)** in
Drupal, exposing your site's resources, content, and APIs as **tools an AI assistant
can call**. MCP is the emerging standard for giving a language model access to a
system's capabilities: the server advertises tools, prompts, and resources, and an
assistant discovers and invokes them. Putting one in front of Drupal means an
assistant can read content, search, and — depending on what you expose — change
things, which is genuinely useful for editorial assistance, content operations, and
site administration.

The module is **configuration‑driven**: any **Tool API** plugin can become an MCP
tool through configuration, with no code, managed from a full CRUD admin UI. Tools
are discovered from configuration entities rather than hardcoded, and the module is
built on the official `modelcontextprotocol/php-sdk`, so it offers broad MCP protocol
support — including resources, saved prompts, and LLM sampling. It supports **two
transports**: **STDIO** for command‑line clients (via a Drush command) and **HTTP**
for web‑based clients.

### The access and authentication model — read this closely

This is a new kind of surface, so it's worth understanding exactly who can do what:

- **The endpoint is closed by default.** Reaching MCP Server requires the
  **`access mcp server`** permission, which is marked *restrict access* and, in its
  own description, **"ships ungranted by default"** — the correct posture for a
  capability endpoint. A separate permission governs prompt discovery.
- **HTTP requests are authenticated.** The 2.0.x line integrates **OAuth 2.1** (via
  the Simple OAuth 2.1 module) for token‑based access, with **per‑tool
  authentication modes**: *Required* means a valid OAuth2 Bearer token with the
  right scopes is mandatory (HTTP 401 without auth, 403 with insufficient scopes),
  while *Disabled* skips auth and should be used **only** for public, read‑only
  tools. Authentication ties into Drupal's own auth system.
- **Every tool call runs as a specific Drupal user, with that user's permissions.**
  This is the point to build your security on: the account is the boundary. An
  assistant given an administrator session can do whatever an administrator can, so
  treat the account behind an MCP connection as a **service identity with the
  narrowest permission set the task needs**.
- **The interesting failure mode is the prompt, not the module.** A model that can
  *read* site content and also *act* on it can be induced by the content it reads to
  take actions nobody asked for. Assume anything the model reads is untrusted input
  to its own instructions.

Note this is a **beta** release on the 2.0.x branch, targeting **Drupal 10 or 11**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — expose Tool API plugins as MCP tools,
   set per‑tool authentication, grant the access permission, and connect a client.

## Where it lives in the admin menu

Manage MCP tool configurations at **Configuration → Web services → MCP Server →
Tools** (`/admin/config/services/mcp-server/tools`). The HTTP MCP endpoint is served
by the module and is relocatable via the `mcp_server.base_path` parameter; the STDIO
transport is exposed through the `drush mcp:server` command.
