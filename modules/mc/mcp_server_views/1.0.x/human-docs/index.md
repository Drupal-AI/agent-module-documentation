# MCP Server Views — manual setup guide

**MCP Server Views** (`mcp_server_views`) adds a new **MCP Resource** display type to
Views. You build a view the ordinary way — pick fields, filters and sorts in the Views
UI — add the special display, and the display's rows become a **read‑only MCP resource**
that AI agents connected through the [MCP Server](https://www.drupal.org/project/mcp_server)
module can read. There is no PHP to write and no routes to register: the Views UI is the
whole authoring surface, and the MCP URI is derived automatically.

When an agent reads the resource, the view is executed **in the requesting account's
context** and returned as structured JSON — a `rows` array plus `total`, `has_more` and
`next_offset` for paging. Because the data an agent sees is exactly the data the view
would return for that account, the view's own access settings and filters are what govern
exposure. Configure them deliberately: a view that would show a page of content to a
visitor will expose the same content to a connected agent.

Views that take **contextual or exposed filters** are advertised as *resource templates*
instead — each filter becomes a segment of the URI so an agent can supply values (for
example a status or a category) when it reads. This lets one display serve many
parameterised queries without extra work.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module
   alongside MCP Server and MCP Server UI.
2. [Configuration](configuration/index.md) — add an MCP Resource display to a view,
   configure field aliases, and turn on the resource providers so agents can see it.

## Where it lives in the admin menu

MCP Server Views has no settings page of its own. You author resources in **Structure →
Views** (`/admin/structure/views`) by adding an **MCP Resource** display to a view, and
you switch the providers on in the MCP Server UI at **Configuration → Web services → MCP
Server → Resources** (and **Resource Templates**). Until both provider types are enabled
there, MCP Resource displays are neither advertised nor readable.
