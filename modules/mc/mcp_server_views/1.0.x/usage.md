<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
MCP Server Views exposes Views results as read-only MCP resources for AI agents.

---

MCP Server Views adds a Views display type that exposes a view's rows as read-only MCP (Model Context Protocol) resources — so AI agents connected via an MCP server can query Drupal content through configured Views, getting structured, read-only data. It builds on the mcp_server module.

Because it exposes content to MCP clients, the view's access/filters govern what's exposed — configure the views (and MCP server access) carefully so only intended data reaches agents. Depends on core `views` and `mcp_server`; supports Drupal 10.3+ and 11.

---

- Expose view rows as MCP resources.
- Add a Views display type.
- Serve read-only data to AI agents.
- Let agents query via Views.
- Build on the mcp_server module.
- Govern exposure via view access/filters.
- Configure views carefully.
- Configure MCP server access.
- Depend on core `views` and `mcp_server`.
- Support Drupal 10.3+ and 11.
- Provide structured data.
- Support MCP clients.
- Expose content to agents
- Read-only resource access.
- Integrate Views with MCP.
- Support AI tooling.
- Query content safely.
- Serve view data
