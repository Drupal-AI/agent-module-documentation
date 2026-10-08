Adds an MCP write tool that downloads a file from a remote URL and creates a managed Drupal file and (optionally) media entity; currently supports images (JPEG, PNG, GIF, WebP, SVG).

---

`mcp_tools_remote_media` is a content submodule of MCP Tools. It provides one Tool API plugin, `mcp_fetch_remote_image` (`FetchRemoteImage`, category `remote media`, operation Write), backed by `RemoteImageService` which extends the reusable `AbstractRemoteFileService`. Given a URL and a name, the service validates access (write scope), validates the URL (http/https only, non-internal host), validates the target stream-wrapper directory, fetches the file over Guzzle, checks the declared and detected MIME against an image allowlist, enforces a 10 MiB cap, sanitizes SVGs with `enshrined/svg-sanitize`, blocks dangerous filename extensions, saves a managed `file` entity, and optionally creates a `media` entity via `mcp_tools_media`'s MediaService. Every fetch is recorded through the shared AuditLogger. It depends on `mcp_tools`, `mcp_tools_media`, core `media` and `file`, and defines the `mcp_tools use remote media` permission. The tool is gated by the parent's scope + permission model, so an AI client must hold write scope and the remote-media permission to invoke it.

---

- Let an assistant import an image from a URL into the media library: `mcp_fetch_remote_image`.
- Fetch a remote JPEG/PNG/GIF/WebP/SVG and create a managed file plus a media entity.
- Save only a managed file (no media) by passing `create_media: false`.
- Import into a specific media bundle with the `bundle` argument (default `image`).
- Store the fetched file in a chosen stream-wrapper directory via `directory` (default `public://mcp-uploads`).
- Populate a site's media library from external image sources during content authoring.
- Pull SVGs safely — scripts, event handlers, foreign objects and remote references are stripped.
- Enforce an image-only policy on agent-fetched files via the MIME allowlist and finfo content check.
- Cap remote downloads at 10 MiB to bound resource use.
- Keep an audit trail of every remote fetch (source URL, filename, uri) via the AuditLogger.
- Reject uploads with executable extensions (php, phar, exe, sh, …) regardless of MIME.
- Grant a dedicated MCP client the `mcp_tools use remote media` permission for image import only.
- Extend to other media types (documents, audio) by subclassing `AbstractRemoteFileService`.
- Combine with read-only/config-only mode: the tool is blocked unless content writes are permitted.
