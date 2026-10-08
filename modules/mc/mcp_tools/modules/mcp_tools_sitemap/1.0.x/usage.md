Simple XML Sitemap integration: manage sitemap variants, settings, entity inclusion, and regeneration.

---

MCP Tools - Sitemap is a submodule of MCP Tools. It contributes Tool API plugins (under `src/Plugin/tool/Tool/`) that let an MCP/AI connection work with Simple XML Sitemap variants, settings, entity inclusion, and regeneration. All plugins extend `McpToolsToolBase`, so access requires the `mcp_tools use sitemap` permission plus the connection's scope (read for reads; write for mutations), and mutating operations additionally honour the global read-only switch and the config/content/ops write-kind policy. The mutating service methods re-check write access. It depends on `mcp_tools`, `simple_sitemap`.

---

- Check whether the sitemap is up to date and how many links it holds.
- List all configured sitemap variants.
- Read a variant's generation settings.
- Inspect which node bundles are included in the sitemap.
- Enable sitemap inclusion for the `article` bundle.
- Set priority and changefreq for a content type.
- Update a variant's max-links-per-page setting.
- Regenerate the default sitemap after content changes.
- Regenerate all variants in one call.
- Add a taxonomy term bundle to the sitemap.
- Exclude a bundle from the sitemap.
- Verify sitemap coverage as part of an SEO audit.
- Scaffold sitemap settings during site setup via an AI agent.
- Standardise sitemap config across environments from MCP.
- Trigger regeneration from an automated content workflow.
- Let a read-only connection review sitemap status safely.
- Drive sitemap management from Claude Code / Cursor.
- Report link counts back to an operator after publishing.
- Wire regeneration into an ECA workflow via the Tool API.
- Fix a stale sitemap after a bulk import.
