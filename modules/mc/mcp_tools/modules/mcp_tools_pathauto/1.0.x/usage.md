URL alias pattern management: create, update, delete, and generate URL aliases using Pathauto patterns.

---

MCP Tools - Pathauto is a submodule of MCP Tools. It contributes Tool API plugins (under `src/Plugin/tool/Tool/`) that let an MCP/AI connection work with Pathauto alias patterns and bulk alias generation. All plugins extend `McpToolsToolBase`, so access requires the `mcp_tools use pathauto` permission plus the connection's scope (read for reads; write for mutations), and mutating operations additionally honour the global read-only switch and the config/content/ops write-kind policy. The mutating service methods re-check write access. It depends on `mcp_tools`, `pathauto`.

---

- List pathauto patterns for the `node` entity type.
- Inspect a specific pattern's token string.
- Create an article pattern `articles/[node:title]`.
- Create a taxonomy pattern per vocabulary.
- Update a pattern to add a date segment.
- Enable or disable a pattern via its status flag.
- Reorder patterns by weight for correct precedence.
- Delete an obsolete alias pattern.
- Bulk-generate aliases for all existing nodes.
- Regenerate aliases after changing a pattern (update=true).
- Generate aliases for a single content type/bundle.
- Scaffold SEO-friendly URLs during site setup via an AI agent.
- Audit which entity types have alias patterns.
- Standardise URL patterns across environments from MCP.
- Fix missing aliases after a content import.
- Drive alias generation from Claude Code / Cursor.
- Let a read-only connection review patterns without editing.
- Add a bundle-specific override pattern.
- Wire alias generation into an ECA workflow via the Tool API.
- Clean up patterns left by a removed content type.
