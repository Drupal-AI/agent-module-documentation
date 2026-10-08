Adds MCP tools to enable/disable Layout Builder for content types and manipulate their sections and block components.

---

mcp_tools_layout_builder is a submodule of MCP Tools (package `MCP`) with nine Tool API plugins (`MCP_CATEGORY = 'layout_builder'`) delegating to `LayoutBuilderService`, which uses the entity-display repository, core layout plugin manager, block plugin manager and a UUID generator. Read tools inspect layouts and list layout plugins; mutating tools enable/disable Layout Builder and add/remove sections and blocks. Every service method — including the display-toggling ones — re-checks `AccessManager::canWrite()` before saving and audit-logs the change, so a write scope plus `mcp_tools use layout_builder` is required for any layout mutation.

---

- Enable Layout Builder on the 'page' content type's default display.
- Allow per-entity layout overrides so editors can customize individual nodes.
- Read a content type's current layout (sections and their blocks).
- List the available layout plugins before adding a section.
- Add a two-column section to a layout.
- Add a three-column section for a feature row.
- Place a block component into a specific section region.
- Add a content/system block into a layout region.
- Remove a block component from a section.
- Remove a whole section from a layout.
- Rearrange a page by adding new sections and removing old ones.
- Disable Layout Builder for a bundle and revert to the default display.
- Build a landing-page layout from a natural-language description.
- Audit which sections/blocks make up an existing layout.
- Prototype a multi-section homepage without the Layout Builder UI.
- Standardize a section structure across content types.
- Toggle custom layouts off to lock a content type's design.
- Assemble a marketing page's layout from an agent prompt.
