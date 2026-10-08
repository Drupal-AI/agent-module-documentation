Media management operations: create, upload, and manage media entities.

---

MCP Tools - Media is a submodule of MCP Tools. It contributes Tool API plugins (under `src/Plugin/tool/Tool/`) that let an MCP/AI connection work with media types, media entities, and base64 file uploads. All plugins extend `McpToolsToolBase`, so access requires the `mcp_tools use media` permission plus the connection's scope (read for reads; write for mutations), and mutating operations additionally honour the global read-only switch and the config/content/ops write-kind policy. The mutating service methods re-check write access. It depends on `mcp_tools`, `media`, `file`.

---

- Ask an AI to create an `image` media type wired to core's image source.
- Upload a base64-encoded screenshot and get back a File id.
- Create a Media entity from an uploaded File id for use in a node's media reference.
- Register a `remote_video` (oembed) media type for YouTube/Vimeo.
- List available media types before creating content that references media.
- Bulk-create media entities as part of an AI content-authoring flow.
- Delete an obsolete media entity by its id.
- Remove an unused media type once its content is cleared.
- Attach an uploaded PDF as a `document` media item.
- Seed a media library during site scaffolding.
- Look up a media type's source field name before setting its value.
- Let a read-only connection inventory media types without any write power.
- Generate media programmatically from an AI agent over MCP.
- Confirm an upload's public URL after storing a file.
- Store uploads under a custom `public://uploads` directory.
- Drive media creation from Claude Code / Cursor.
- Wire media into an ECA workflow via the Tool API.
- Clean up media types left over from a migration.
- Validate that a filename's extension is permitted before uploading.
- Reference created media in content-entity fields with `{"target_id": mid}`.
