# Model Context Protocol (MCP) — manual setup guide

**Model Context Protocol** (`mcp`) turns your Drupal site into an *MCP server*.
The Model Context Protocol is the open standard that LLM applications — Claude
Desktop, Zed, and other AI clients — use to discover and call "tools" and read
"resources" from an external system. Once this module is enabled, those clients
can connect to Drupal, list the tools it offers, call them, and read site data,
all over a standard JSON-RPC 2.0 API (optionally streamed with HTTP
Server-Sent Events).

The module ships a small plugin architecture: it defines an `mcp` plugin type,
and every enabled plugin contributes its own tools and resources. The base module
includes one simple plugin, **General**, whose `general_info` tool returns your
site name, slogan, and Drupal version. Two optional submodules add much more:
**MCP Content** (`mcp_content`) exposes your content as readable resources plus a
content-search tool, and **MCP AI** (`mcp_ai`) surfaces the Drupal AI module's
function-calls as MCP tools an assistant can invoke.

The two API endpoints (`/mcp/get` and `/mcp/post`) are gated by the core **View
published content** (`access content`) permission. Read the note on the access
model below before you enable this on a public site.

This guide is written for a **human** setting the module up through the admin UI
and connecting a client. If you want terse, token-cheap references for an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and choose the Content / AI submodules.
2. [Configuration](configuration/index.md) — the `/admin/config/mcp` settings
   form: the SSE toggle and per-plugin enable switches.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → MCP Configuration**
(`/admin/config/mcp`), reachable by users with **Administer site configuration**.
The two machine-facing endpoints are `GET /mcp/get` (the SSE connection stream)
and `POST /mcp/post` (the JSON-RPC message endpoint) — clients talk to those, not
to a page in the admin menu.

## How to use it

1. Enable the module (and any submodules you need — see
   [Installation](installation/index.md)).
2. Open **Configuration → Web services → MCP Configuration** and enable the
   plugins you want to expose. Leave **Enable HTTP SSE** on unless your client
   prefers plain request/response JSON-RPC.
3. **Decide who may reach the endpoints**: they use the `access content`
   permission, so configure that permission or put the `/mcp/*` paths behind
   additional authentication (a reverse proxy, an auth module, or network rules)
   to suit your site. The module ships no dedicated permission of its own.
4. Point your MCP client at your site's `/mcp/get` (SSE) or `/mcp/post`
   endpoint. The client performs the `initialize` handshake, then uses
   `tools/list` and `tools/call` (and `resources/list` / `resources/read`) to
   work with what Drupal exposes.

## A note on the auth and access model

The endpoints use the `access content` permission. Once a request passes that,
`McpService` runs the requested tool against every enabled plugin; each plugin's
own `checkRequirements()` and enabled flag decide whether it takes part. The
built-in **General** tool returns your site name, slogan and Drupal version.
Decide which plugins to expose, and configure access to the endpoints to suit
your site, before you rely on this in production. The current release is an alpha (`1.0.0-alpha4`).
