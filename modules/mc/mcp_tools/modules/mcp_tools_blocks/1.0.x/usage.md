Adds MCP tools to place, configure, remove and enumerate blocks in theme regions.

---

mcp_tools_blocks is a submodule of MCP Tools with five Tool API plugins (`MCP_CATEGORY = 'blocks'`) delegating to `BlockService`, which uses the block plugin manager and theme handler. Read tools list available block plugins and a theme's regions; the three write tools (place/configure/remove) are `ToolOperation::Write`, gated by `mcp_tools use blocks` plus a write scope, with `AccessManager::canWrite()` re-checked and audit-logged in the service.

---

- List every block plugin available to place on the site.
- Enumerate a theme's regions (header, sidebar, footer, ...) before placing.
- Place a menu block into the primary navigation region.
- Add a search block to the header of the active theme.
- Place a custom (block_content) block into a sidebar.
- Configure a placed block's label or 'display title' setting.
- Set visibility conditions on a block (e.g. specific pages/roles).
- Reweight or relabel a block via ConfigureBlock.
- Remove a block that is no longer wanted from a region.
- Move a block by removing it from one region and placing it in another.
- Set up a footer with several informational blocks.
- Audit which blocks and regions exist before an AI redesign.
- Place the same block into multiple themes.
- Add a branding/site-name block to a new theme's header.
- Prototype a page layout using core blocks from a prompt.
- Disable a block region's contents by removing its blocks.
- Let an agent assemble a landing sidebar from available blocks.
- Reconfigure an existing block instead of recreating it.
