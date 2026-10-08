Submodule of MCP Tools that adds four Tool API plugins for cloning entities via the Entity Clone module from an AI/MCP client.

---

`mcp_tools_entity_clone` exposes the contrib Entity Clone integration to MCP tooling. Read tools list which entity types/bundles support cloning and describe a bundle's clone settings (title pattern, reference-clone behaviour, excluded fields, whether it contains paragraph fields). Two write tools perform clones: a single-entity clone with optional title prefix/suffix and child-paragraph handling, and a deep clone that also duplicates specified entity-reference fields and rewrites the references in the copy. All tools extend `McpToolsToolBase` with category `entity_clone`, inheriting the parent access model (`mcp_tools use entity_clone` permission, per-connection read/write scope, config write policy, global read-only switch); the clone tools also check `canWrite()` in `EntityCloneService`. The submodule depends on `entity_clone:entity_clone`, ships one permission and one service (`EntityCloneService`), and declares no config, routes, or forms.

---

- List all entity types and bundles that support cloning (`mcp_entity_clone_types`).
- Inspect a bundle's clone settings and reference/paragraph fields before cloning (`mcp_entity_clone_settings`).
- Clone a single node, media item, or paragraph with a sensible default title suffix (`mcp_entity_clone_clone`).
- Add a custom title prefix or suffix to a cloned entity.
- Choose whether child paragraphs are cloned along with the parent.
- Deep-clone an entity plus specific referenced entities, updating references in the copy (`mcp_entity_clone_with_refs`).
- Duplicate a landing page and its referenced components as a starting point for a new one.
- Let an agent "make me a copy of article 12 to edit" without leaving the chat.
- Clone a template node so editors start from a known-good structure.
- Understand deep-clone behaviour (which reference fields are cloned vs preserved) before running it.
- Detect whether a bundle contains paragraph fields that will be deep-cloned automatically.
- Produce cloned entities as unpublished drafts by default for safe review.
- Get the new entity's id and UUID back for follow-up edits or config references.
- Bulk-duplicate a set of components by cloning references field-by-field.
- Restrict cloning to write-scoped connections while leaving type/settings inspection read-only.
- Seed A/B variants of a page by cloning and tweaking.
- Answer "what can I clone here and how deep does it go?".
- Support content-modelling workflows that rely on duplicating structured content.
