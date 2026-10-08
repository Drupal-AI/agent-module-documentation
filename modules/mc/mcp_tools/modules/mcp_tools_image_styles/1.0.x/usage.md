MCP Tools for image style management (list, create, delete, add effects).

---

MCP Tools - Image Styles is a submodule of MCP Tools. It contributes Tool API plugins (under `src/Plugin/tool/Tool/`) that let an MCP/AI connection work with image styles and their effects. All plugins extend `McpToolsToolBase`, so access requires the `mcp_tools use image_styles` permission plus the connection's scope (read for reads; write for mutations), and mutating operations additionally honour the global read-only switch and the config/content/ops write-kind policy. The mutating service methods re-check write access. It depends on `mcp_tools`, `image`.

---

- List existing image styles and their effects.
- Inspect a single image style before editing it.
- Discover which image effect plugins are installed.
- Create a `thumbnail_square` image style.
- Add a scale-and-crop effect to a style with width/height config.
- Add a convert-to-webp effect to a style.
- Reorder or prune effects by removing one by uuid.
- Delete an unused image style.
- Force-delete a style still referenced by fields.
- Scaffold a responsive-image style set via an AI agent.
- Audit image styles as part of a theme review.
- Create derivative presets for a media library.
- Let a read-only connection enumerate styles safely.
- Standardise image styles across environments from MCP.
- Drive image-style creation from Claude Code / Cursor.
- Add crop effects for editorial image ratios.
- Verify an effect's configuration keys before adding it.
- Remove a deprecated effect from all styles.
- Generate image styles from an ECA workflow via the Tool API.
- Clean up styles left by an uninstalled module.
