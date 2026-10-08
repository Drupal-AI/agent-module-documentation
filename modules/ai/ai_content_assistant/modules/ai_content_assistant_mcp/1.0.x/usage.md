<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Exposes AI Content Assistant's content discovery and draft-node creation as Model Context Protocol (MCP) tools, so AI clients such as Claude can inspect a site's content types and create draft nodes directly, authenticated per-user over OAuth.

---

This submodule registers five `mcp_server` Tool plugins under `src/Plugin/Tool/`: `list_content_types`, `describe_content_type`, `list_entities`, and `get_node` (all read-only) plus `create_node` (write; always creates an unpublished draft). Read tools are backed by a read-only `EntityQueryService` and the parent module's `ContentSchemaDiscovery`; `create_node` calls the parent's `ContentGenerator::generateFromData()`, which maps a structured payload onto real node/paragraph/reference/image values. Every tool's `checkAccess()` requires the `generate ai content` permission, and each call runs as the OAuth-authenticated Drupal user — `create_node` additionally re-checks per-bundle node create-access inside the generator, so an AI client can never create content the underlying user could not. All entity reads run `accessCheck(TRUE)` with a per-entity `view` check, so tools never surface content the user cannot see. `create_node` deduplicates by bundle + user + title for ten minutes to make timeout-retries safe. The module depends on `mcp_server`, `mcp_server_oauth`, and the `simple_oauth_21` server-metadata/PKCE/client-registration submodules; a small `McpAuthChallengeSubscriber` converts anonymous 403s on the MCP endpoint into RFC 9728 `401` Bearer challenges so discovery-less clients (claude.ai) can start the OAuth flow. Neither `mcp_server` nor its `mcp/sdk` dependency has a stable release, so admins pin both to tested commits (see the parent README).

---

- Let Claude Desktop, claude.ai, Claude Code, or Codex create Drupal draft nodes over MCP.
- Discover which content types the connected user can create (`list_content_types`).
- Fetch a bundle's full field/paragraph schema before generating (`describe_content_type`).
- Search existing entities by type/bundle/label to pick reference IDs (`list_entities`).
- Read an existing node's fields and paragraphs for context (`get_node`).
- Create a draft node from a structured JSON payload (`create_node`).
- Generate images for image-media fields via the configured `text_to_image` provider from an AI client.
- Fan out sub-agents to create many draft nodes in parallel, each under the same Drupal user.
- Enforce per-user Drupal permissions and entity access on every MCP call (no ambient elevation).
- Authenticate AI clients per-user via OAuth (simple_oauth) rather than a shared API key.
- Keep created content safe for review — every node is saved unpublished (`status = 0`).
- Avoid duplicate nodes when an image-generation call times out and the client retries.
- Serve OAuth discovery metadata to MCP clients that do not do proactive discovery.
- Map an existing node's structure back into a `create_node` payload for consistent related content.
- Restrict tool availability to roles holding the `generate ai content` permission.
- Give a dedicated "content editor" role scoped MCP access without full admin rights.
