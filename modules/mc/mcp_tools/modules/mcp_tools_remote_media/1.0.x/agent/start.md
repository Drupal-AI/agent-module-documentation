<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Remote Media (mcp_tools_remote_media) — agent index

Content submodule of **MCP Tools**. Adds one MCP write tool that downloads a remote file by URL and
creates a managed Drupal file/media entity — currently images (JPEG, PNG, GIF, WebP, SVG). Depends
on `mcp_tools`, `mcp_tools_media`, core `media`, `file`. Defines permission
`mcp_tools use remote media`. Core `^10.3 || ^11 || ^12`. License GPL-2.0-or-later. Version dir
1.0.x (installed 1.0.0-beta8).

- **The `mcp_fetch_remote_image` tool and its fetch/validate/save pipeline** →
  [tools/fetch-remote-image.md](tools/fetch-remote-image.md)

## What it provides (from source)

- `src/Plugin/tool/Tool/FetchRemoteImage.php` — Tool `id: mcp_fetch_remote_image`, label *Fetch
  Remote Image*, `operation: Write`, `MCP_CATEGORY = 'remote media'`. Inputs: `url` (req), `name`
  (req), `bundle` (default `image`), `directory` (default `public://mcp-uploads`), `create_media`
  (default true). Extends `McpToolsToolBase`; delegates to `RemoteImageService`.
- `src/Service/RemoteImageService.php` — image MIME allowlist + SVG sanitization
  (`enshrined/svg-sanitize`, remote references removed); `fetchRemoteImage()`.
- `src/Service/AbstractRemoteFileService.php` — reusable template: `fetchAndCreate()` runs
  validateAccess → validateUrl → validateNotInternalUrl → validateDirectory → fetch → validate
  MIME/body/content-MIME → sanitize → build safe filename → validateExtension → save file → optional
  media. Constants: `MAX_FILE_BYTES` 10 MiB, `BLOCKED_UPLOAD_EXTENSIONS`.
- `mcp_tools_remote_media.services.yml` — `mcp_tools_remote_media.remote_image` (injects
  entity_type.manager, file_system, `@http_client`, `@mcp_tools.access_manager`,
  `@mcp_tools.audit_logger`, datetime.time, `@mcp_tools_media.media`).
- `mcp_tools_remote_media.permissions.yml` — `mcp_tools use remote media` (`restrict access: true`).

No routes, no config schema, no Drush. Access = parent's write scope + the remote-media permission.
