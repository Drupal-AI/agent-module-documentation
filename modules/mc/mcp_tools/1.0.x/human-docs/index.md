# MCP Tools — manual setup guide

**MCP Tools** (`mcp_tools`) turns a Drupal site into a **Model Context Protocol (MCP)
tool server**. MCP is the interface an AI assistant such as Claude, Cursor or Windsurf
uses to call out to external systems; this module makes your Drupal site one of those
systems. Site operations — creating and editing content, managing taxonomy and fields,
users, cache, configuration, structure and much more — are exposed as **tools** the
assistant can call. In practice you describe what you want in plain English and the
assistant performs the Drupal work for you.

The tools are grouped into **37 domain submodules** (content, media, users, views,
layout, config, cron, and so on). This matters: **installing the base module exposes
nothing on its own** — you enable only the submodules whose surfaces you actually want an
assistant to touch. That keeps the exposed footprint small by default.

The reason to take this module seriously is its **access model**, which is unusually well
built and layered: module‑based availability, a site‑wide **read‑only mode**, per‑
connection **scopes** (`read` / `write` / `admin`), a **config‑only mode**, a permission
per domain, and rate limiting. Every tool runs as a **configured Drupal user**, so the
identity MCP acts as is a real security decision — treat it like a least‑privilege service
account. Two transports carry the protocol: **STDIO** over Drush (the recommended local
path) and **remote HTTP** at `/_mcp_tools` (the network‑reachable surface, to configure
most carefully).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base module,
   and pick the transport and domain submodules you need.
2. [Configuration](configuration/index.md) — the settings form, its presets, and the
   layered access model, field by field.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → MCP Tools**
(`/admin/config/services/mcp-tools`), which requires the **Administer site configuration**
permission. A companion **status** page at `/admin/config/services/mcp-tools/status` shows
which tools are currently exposed — the place to audit the server's surface. When you use
the remote HTTP transport, its own settings live at
`/admin/config/services/mcp-tools/remote`.
