Submodule of MCP Tools that adds five Tool API plugins for reading and setting Metatag SEO tags on entities and inspecting metatag configuration.

---

`mcp_tools_metatag` connects the contrib Metatag module to MCP tooling. Read tools list the available metatag groups (basic, Open Graph, Twitter cards, Dublin Core, etc.), list all available tags with their descriptions and group assignments, return the default metatag configuration (optionally filtered by entity type), and return the metatags set on a specific entity — both the explicitly stored values and the final computed values with tokens resolved and defaults applied. One write tool sets metatag key/value pairs on a specific entity. All tools extend `McpToolsToolBase` with category `metatag`, inheriting the parent access model (`mcp_tools use metatag` permission, per-connection read/write scope, config write policy, global read-only switch); the write tool also checks `canWrite()` in `MetatagService`. The submodule depends on `metatag:metatag`, ships one permission and one service (`MetatagService`), and declares no config, routes, or forms.

---

- List all metatag groups available on the site (`mcp_metatag_list_groups`).
- List every metatag tag with its description and group (`mcp_metatag_list_tags`).
- Get the default metatag configuration, optionally for one entity type (`mcp_metatag_get_defaults`).
- See which default tags use tokens like `[node:title]`.
- Read the metatags currently set on a node, term, or user (`mcp_metatag_get_entity`).
- Compare an entity's explicitly-set tags against the final computed output that appears in the HTML.
- Set a page title and description meta tag on a specific node (`mcp_metatag_set_entity`).
- Add Open Graph or Twitter-card tags to an entity for better social sharing.
- Let an agent optimise a page's SEO metatags on request.
- Bulk-review which entities are missing key metatags.
- Prepare an SEO audit by reading defaults and per-entity overrides.
- Discover the exact tag keys to use before setting them (via the tags/groups tools).
- Set canonical, robots, or keyword tags on a taxonomy term.
- Confirm token-based defaults resolve correctly for a given entity.
- Restrict metatag changes to write-scoped connections while leaving inspection read-only.
- Support a content agent that fills in SEO fields as it creates content.
- Answer "what meta description will this node output?".
- Standardise metatags across a content type by inspecting defaults then overriding per entity.
