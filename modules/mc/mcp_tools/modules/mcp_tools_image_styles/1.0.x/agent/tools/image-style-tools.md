<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image style tools

Plugins in `src/Plugin/tool/Tool/`, all `MCP_CATEGORY = 'image_styles'` → permission
**`mcp_tools use image_styles`**. Read ops need read scope; Write ops need write scope, a
non-read-only connection, and a write-kind the connection's policy allows. Each delegates to
`mcp_tools_image_styles.image_style_service` (`ImageStyleService`).

| Tool id | Class | Op | Write-kind | Destructive | Inputs | Does |
|---|---|---|---|---|---|---|
| `mcp_image_styles_list` | `ListImageStyles` | Read | - | - | - | Lists all image styles with their effects. |
| `mcp_image_styles_get` | `GetImageStyle` | Read | - | - | style_id | Returns one image style and its ordered effects. |
| `mcp_image_styles_list_effects` | `ListImageEffects` | Read | - | - | - | Lists available image effect plugins (scale, crop, ...). |
| `mcp_image_styles_create` | `CreateImageStyle` | Write | config | - | id, label | Creates an empty image style; validates machine name `[a-z0-9_]`. |
| `mcp_image_styles_add_effect` | `AddImageEffect` | Write | config | - | style_id, effect_id, configuration? | Appends an effect; validates effect_id against the effect plugin manager. |
| `mcp_image_styles_remove_effect` | `RemoveImageEffect` | Write | config | yes | style_id, effect_uuid | Removes an effect from a style by its uuid. |
| `mcp_image_styles_delete` | `DeleteImageStyle` | Write | config | yes | style_id, force? | Deletes a style; refuses if used by fields unless force=true. |

## Notes

- All writes default to config write-kind (the `image_styles` category has no override).
- Access is enforced by `McpToolsToolBase::checkAccess()` before execution; `ImageStyleService` validates machine names, effect ids, and field-usage before deleting.
