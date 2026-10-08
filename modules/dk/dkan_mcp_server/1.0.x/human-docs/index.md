# DKAN MCP Server — manual setup guide

**DKAN MCP Server** (`dkan_mcp_server`) exposes a DKAN open‑data portal's
operations as **Model Context Protocol (MCP)** tools, so an AI client (an LLM
agent) can search the catalog, query the datastore, inspect metadata and — if you
allow it — publish, edit, import and harvest datasets. It's a thin adapter built on
the contributed **MCP Server** module: MCP Server handles the transport, tool
discovery and session handling, and this module contributes the DKAN‑specific
tools, prompts and resources plus a per‑tool permission layer.

The read surface is broad and safe by design: tools to get, list and search
datasets; query datastore tables (filters, joins, distinct values, samples);
inspect datastore schema, stats and import status; and read harvest plans and
runs. Read tools are gated by MCP Server's base **`access mcp server`** permission,
which suits a public open‑data catalog. Every **write** tool, by contrast, carries
its own fine‑grained permission (for example `publish datasets via mcp`, `import
datastore via mcp`, `manage harvests via mcp`), and an access subscriber both
**denies** unauthorized calls and **hides** the write tools from tool discovery so
an unauthorized client can't even see them.

A few things to weigh before turning this on, because it deliberately opens your
portal to AI clients:

- **Egress and access:** this module lets an external MCP client reach into your
  DKAN site. The MCP transport endpoint is owned by the MCP Server module; make
  sure only intended clients can reach it, and never grant `access mcp server` — or
  any `* via mcp` write permission — to the anonymous role unless that is a
  deliberate choice.
- **Authentication:** remote clients authenticate via OAuth (`simple_oauth`) using
  read/write scopes shipped as optional config.
- **SSRF guard:** harvest registration passes source URIs through a validator
  before use, to prevent server‑side request forgery.
- **Experimental:** this release currently requires dev releases of MCP Server and
  the `mcp/sdk` library. Portions of the module were developed with AI assistance
  and reviewed by the maintainer.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it
   against DKAN and MCP Server, and (for remote clients) set up OAuth.
2. [Configuration](configuration/index.md) — enabling tool groups, granting the
   per‑tool permissions, OAuth scopes, and the access considerations to get right.

## Where it lives in the admin menu

The module's own settings form is at
**`/admin/config/services/dkan-mcp-server`** (permission **Administer DKAN MCP
server**) and enables or disables whole tool groups. The MCP transport endpoint
itself is provided by the MCP Server module, and per‑tool access is controlled by
permissions on **People → Permissions**.
