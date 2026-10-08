<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
MCP Server turns your Drupal site into a Model Context Protocol server, so AI assistants can call tools, read resources, and use saved prompts against your content over HTTP or the command line.

---

The module embeds the official `mcp/sdk` PHP SDK and offers two transports: an HTTP endpoint at **`/_mcp`** for web-based MCP clients, and a STDIO transport started with **`drush mcp:server`** for local clients such as Claude Desktop. The parent module is runtime-only; enable the **mcp_server_ui** submodule to get admin pages at `/admin/config/services/mcp-server` for server settings (name, version, pagination limit, session TTL), resource-plugin toggles, and prompt authoring. It ships **no tools on its own** — install **mcp_server_tool_bridge** and it exposes any `drupal/tool` (Tool API) tool as an MCP tool through a simple **MCP Tool Configuration** entity (pick a tool by autocomplete, give it an MCP name), with no PHP required; developers can alternatively write a native `#[Tool]` plugin. Resources are provided by `ResourceTemplate` plugins (the **mcp_server_examples** submodule includes a `content_entity` template that serves any content entity as JSON:API), and prompts are `mcp_prompt_config` config entities with typed text/image/audio/resource messages and pluggable argument autocomplete. Access is layered and closed by default: the `/_mcp` route requires the `access mcp server` permission (which ships **ungranted**), every request runs as a specific Drupal account (cookie session, or an OAuth2 Bearer token when **mcp_server_oauth** is enabled), each call passes through the `mcp_server.authorize_call` event, and bridge tools still run the underlying Tool API tool's own access check. The optional **mcp_server_oauth** submodule (requiring Simple OAuth 2.1) adds per-tool OAuth2 scope requirements and advertises them via RFC 9728 protected-resource metadata. Grant `access mcp server` only to a role scoped to exactly what the assistant should be able to do, since that account's permissions are the effective boundary.

---

- Expose Drupal to an AI assistant over the Model Context Protocol.
- Connect an MCP client (Claude Desktop, MCP Inspector, Claude Code) to your site.
- Serve MCP over HTTP at `/_mcp` for web-based clients.
- Serve MCP over STDIO with `drush mcp:server` for local/CLI clients.
- Turn any Tool API tool into an MCP tool with no code, via configuration.
- Give each exposed tool a friendly MCP name and description.
- Write a custom `#[Tool]` plugin for bespoke server-side actions.
- Expose content entities as MCP resources using the JSON:API example template.
- Restrict which entity types are exposed as resources with a deny-list.
- Author reusable prompts with arguments and typed messages.
- Add text, image, audio, or embedded-resource content to a prompt.
- Provide argument autocomplete from an entity query or a static list.
- Require callers to authenticate before reaching the endpoint.
- Run each tool call as a specific, least-privileged Drupal account.
- Add per-tool OAuth2 scope requirements with the OAuth submodule.
- Advertise supported OAuth scopes via RFC 9728 metadata discovery.
- Add custom authorization policy through the `mcp_server.authorize_call` event.
- Configure server name, version, and pagination limit shown to clients.
- Persist MCP sessions in the database for distributed deployments.
- Enable an admin UI for tools, prompts, resources, and settings.
- Keep the endpoint closed by default until you grant access to a role.
- Let assistants read site content through a governed, access-checked interface.
- Prototype AI tooling on Drupal using the official MCP PHP SDK.
