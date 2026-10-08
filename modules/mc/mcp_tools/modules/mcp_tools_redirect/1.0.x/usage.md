URL redirect management: create, update, and manage URL redirects for SEO and link maintenance.

---

MCP Tools - Redirect is a submodule of MCP Tools. It contributes Tool API plugins (under `src/Plugin/tool/Tool/`) that let an MCP/AI connection work with redirect entities (source path to destination). All plugins extend `McpToolsToolBase`, so access requires the `mcp_tools use redirect` permission plus the connection's scope (read for reads; write for mutations), and mutating operations additionally honour the global read-only switch and the config/content/ops write-kind policy. The mutating service methods re-check write access. It depends on `mcp_tools`, `redirect`.

---

- List existing redirects with pagination.
- Look up a redirect by id.
- Check whether a source path already has a redirect.
- Create a 301 from an old path to a new node.
- Create a temporary 302 during a campaign.
- Point a retired URL at a canonical internal path.
- Update a redirect's destination after a content move.
- Change a redirect's status code from 302 to 301.
- Delete a stale redirect.
- Bulk-import a CSV-derived list of legacy redirects.
- Repair link rot after a large content migration.
- Audit redirect counts as part of an SEO review.
- Set language-specific redirects.
- Scaffold redirects during a site relaunch via an AI agent.
- Let a read-only connection review redirects safely.
- Drive redirect management from Claude Code / Cursor.
- Detect duplicate redirect sources before creating new ones.
- Consolidate redirects after merging pages.
- Wire redirect creation into an ECA workflow via the Tool API.
- Report import results (created/skipped/errors) back to an operator.
