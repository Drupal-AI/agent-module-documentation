MCP Tools - Cache adds Tool API plugins that let an MCP/AI connection clear all caches, clear a bin, invalidate tags, clear one entity's render cache, rebuild a subsystem, and read cache status.

---

This submodule of MCP Tools contributes six `tool` plugins under the `cache` category, backed by `CacheService`. One is read-only (cache status); the rest are write tools: clear all caches, clear a named bin, clear one entity's cache tags, invalidate an explicit tag list, and rebuild the router/theme/container/menu subsystem. Access is enforced by the shared MCP Tools model — the `mcp_tools use cache` permission plus the connection scope, the ops write-kind policy, and the read-only switch — with write tools re-checking write access in `executeLegacy()`. `rebuild` validates the requested type against a fixed list. It depends only on the base mcp_tools module.

---

- Ask an AI to clear all caches after a config change (drush cr equivalent).
- Clear just the render or page cache without a full rebuild.
- Invalidate a specific set of cache tags after updating related data.
- Clear one entity's cache when only that node changed.
- Rebuild the router after adding or changing routes.
- Rebuild the theme registry after editing templates or preprocess.
- Rebuild the service container after a services change.
- Rebuild menu links after a menu structure change.
- Read a cache-bin overview to see which backends are in use.
- Troubleshoot "stale content" by clearing the relevant bin.
- Include a targeted cache clear in an automated deploy runbook.
- Let an agent flush caches between test steps.
- Invalidate tags for a taxonomy term after bulk edits.
- Clear entity cache for a page an editor just fixed.
- Avoid full cache rebuilds by clearing only the affected bin.
- Integrate cache maintenance into an ECA or AI-agent workflow.
- Drive cache operations from Claude Code / Cursor over MCP.
- Confirm cache health as part of a site audit.
- Force a theme-registry rebuild when a new template is not picked up.
- Selectively invalidate tags instead of clearing everything.
