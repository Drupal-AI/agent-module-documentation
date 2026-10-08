Adds MCP tools to create and manage Paragraphs bundle types and their fields (requires the contrib Paragraphs module).

---

mcp_tools_paragraphs is a submodule of MCP Tools that depends on the contrib `paragraphs` module. Its six Tool API plugins (`MCP_CATEGORY = 'paragraphs'`) delegate to `ParagraphsService`, which manages `paragraphs_type` bundles and their fields via the entity-type and field managers. Read tools list/describe types; the mutating tools are `ToolOperation::Write`, gated by `mcp_tools use paragraphs` plus a write scope, with `AccessManager::canWrite()` re-checked and audit-logged. It manages the paragraph type structure, not individual paragraph entity content.

---

- List all paragraph types defined on the site.
- Inspect a paragraph type's fields before extending it.
- Create a 'hero' paragraph type for reusable page components.
- Create a 'text + image' paragraph type from a prompt.
- Add a body/text field to an existing paragraph type.
- Add an image or media reference field to a paragraph type.
- Add an entity-reference field to link paragraphs to other content.
- Remove an unused field from a paragraph type.
- Delete a paragraph type that is no longer needed.
- Build a component library of paragraph types for a landing page.
- Scaffold CTA, quote and gallery paragraph types in one session.
- Audit the paragraph structure of an inherited site.
- Prepare paragraph types to be attached to a node's paragraph field.
- Standardize paragraph field naming across bundles.
- Prototype a flexible page builder using Paragraphs from natural language.
- Extend an existing paragraph type with an extra field without the UI.
- Enumerate paragraph types to plan a content migration.
