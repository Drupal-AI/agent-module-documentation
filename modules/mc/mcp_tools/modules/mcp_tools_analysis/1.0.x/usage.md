MCP Tools - Analysis adds read-only Tool API plugins that let an MCP/AI connection run site-health and content checks: broken links, SEO, a security review, performance, accessibility, a content audit, duplicate detection, and unused-field detection.

---

This submodule of MCP Tools contributes eight read `tool` plugins under the `analysis` category, each backed by a specialized analyzer service coordinated by the `AnalysisService` facade. The tools inspect entity, config, and database metadata and return structured results; none of them write. Access follows the shared MCP Tools model — the `mcp_tools use analysis` permission plus the connection's read scope. The broken-link tool performs no outbound requests unless an `allowed_hosts` allowlist is configured in `mcp_tools.settings`, and it validates every fetched host (including redirects) against that list. It depends only on the base mcp_tools module.

---

- Ask an AI to scan published content for broken internal links.
- Get an SEO check (meta tags, headings, alt text) for a specific page.
- Run a quick review of permissions and role grants.
- Review cache settings and recent watchdog errors for performance issues.
- Check a page for accessibility problems like missing alt text.
- Find stale content that has not been updated in N days.
- List orphaned or draft content that needs attention.
- Detect duplicate or near-duplicate pages by field similarity.
- Identify fields that hold no data and could be removed.
- Summarize site health as part of an automated audit.
- Prioritize an SEO backlog from per-entity checks.
- Surface heading-order problems for editors to fix.
- Estimate database growth from a table-size review.
- Let a read-only MCP connection assess a site without any write power.
- Feed analysis output into an ECA or AI-agent remediation workflow.
- Spot redundant content before a content consolidation.
- Run accessibility spot-checks during content review.
- Verify link health after a large content migration.
- Check register-mode and similar config as a hardening step.
- Drive site analysis from Claude Code / Cursor over MCP.
