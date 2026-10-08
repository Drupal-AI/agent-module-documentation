<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media tools

Plugins in `src/Plugin/tool/Tool/`, all `MCP_CATEGORY = 'media'` → permission
**`mcp_tools use media`**. Read ops need read scope; Write ops need write scope, a
non-read-only connection, and a write-kind the connection's policy allows. Each delegates to
`mcp_tools_media.media` (`MediaService`).

| Tool id | Class | Op | Write-kind | Destructive | Inputs | Does |
|---|---|---|---|---|---|---|
| `mcp_list_media_types` | `ListMediaTypes` | Read | - | - | - | Lists all media types with id, label, source plugin, source field. |
| `mcp_upload_file` | `UploadFile` | Write | content | - | filename, data (base64), directory? | Decodes base64 into a managed File. 10 MiB cap, exec-extension blocklist, filename sanitised, only public:// / private:// dirs. |
| `mcp_create_media` | `CreateMedia` | Write | content | - | bundle, name, source_field_value | Creates a Media entity; source_field_value is a File id (image/file) or a URL (remote/oembed). |
| `mcp_create_media_type` | `CreateMediaType` | Write | config | - | id, label, source_plugin | Creates a media type and its auto-generated source field. |
| `mcp_delete_media` | `DeleteMedia` | Write | content | yes | mid | Permanently deletes a media entity. |
| `mcp_delete_media_type` | `DeleteMediaType` | Write | config | yes | id | Deletes a media type; refuses while any media of that type exists. |

## Notes

- `MediaService::uploadFile()` rejects the exec-extension blocklist (php, phtml, phar, cgi, pl, py, sh, exe, ...), caps decoded size at 10 MiB, sanitises the filename to `[a-zA-Z0-9._-]`, and restricts the target to `public://` / `private://` (no `..`).
- All mutating methods re-check `AccessManager::canWrite()` at the service layer; `listMediaTypes()` re-checks `canRead()`.
- `createMedia()` stores the given source value on the type's source field; it performs no server-side fetch of remote URLs (oembed validation happens later in core Media).
