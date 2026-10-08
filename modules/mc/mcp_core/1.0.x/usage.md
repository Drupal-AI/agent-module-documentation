<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
MCP Core provides the framework for exposing Drupal capabilities as MCP servers to AI agents.

---

MCP Core provides a framework for building custom MCP (Model Context Protocol) servers in Drupal — the protocol AI agents use to discover and call tools/resources. Modules build on it to expose Drupal capabilities (data, actions) to MCP-speaking AI clients in a structured, discoverable way. It ships an example submodule.

Because MCP servers expose site capabilities to AI clients, scope what each server exposes carefully and treat access as trusted. No hard dependencies; requires Drupal 11.3+.

---

- Build custom MCP servers.
- Implement the Model Context Protocol.
- Expose Drupal tools/resources to AI.
- Let AI agents discover capabilities.
- Provide a server framework.
- Ship an example submodule.
- Structure tool/resource exposure.
- Scope what each server exposes.
- Treat MCP access as trusted.
- Have no hard dependencies.
- Require Drupal 11.3+.
- Underpin modules like ctx.
- Support AI tooling.
- Enable discoverable tools.
- Serve MCP clients.
- Bridge Drupal and AI agents.
- Define MCP servers.
- Support structured AI integration.
