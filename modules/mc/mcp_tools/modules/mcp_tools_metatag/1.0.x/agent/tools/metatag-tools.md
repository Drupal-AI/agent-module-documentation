<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# mcp_tools_metatag — tools reference

Plugins in `src/Plugin/tool/Tool/` extend `McpToolsToolBase` (`MCP_CATEGORY = 'metatag'`) and call
`MetatagService` (`mcp_tools_metatag.metatag`). Base `checkAccess()`: `mcp_tools use metatag` + scope
+ read-only off. The Write tool also calls `canWrite()`.

## Tool table

| Tool id | Class | Operation → scope | Inputs | Returns |
|---------|-------|-------------------|--------|---------|
| `mcp_metatag_list_groups` | `ListMetatagGroups` | Read → read | — | `count`, `groups` (id/label/description) |
| `mcp_metatag_list_tags` | `ListAvailableTags` | Read → read | — | `count`, tags `by_group`, flat `tags` (id/name/description/group) |
| `mcp_metatag_get_defaults` | `GetMetatagDefaults` | Read → read | `type` (optional entity type/bundle) | `count`, `defaults` (id/label/entity_type/tags, tokens like `[node:title]`) |
| `mcp_metatag_get_entity` | `GetEntityMetatags` | Read → read | `entity_type` (req), `entity_id` (req) | `entity_metatags` (explicitly set), `computed_metatags` (tokens resolved + defaults applied) |
| `mcp_metatag_set_entity` | `SetEntityMetatags` | Write → write | `entity_type` (req), `entity_id` (req), `tags` (map, req) | `updated_tags` (keys set), confirmation message |

## Behaviour notes (from `MetatagService`)

- **Read tools** enumerate groups/tags via the metatag tag/group plugin managers, read
  `metatag_defaults` config entities, and for an entity return both the stored `metatag` field value
  and the computed tags (`metatag.manager`) with tokens resolved.
- **`mcp_metatag_set_entity`**: `accessManager->canWrite()` gate → load the entity → merge the given
  `tags` into the entity's metatag field value → `$entity->set($metatagFieldName, $newValues)` →
  `save()` → audit-log. Only the metatag field is written; other entity data is untouched.
- Metatag output is rendered and sanitised by the Metatag module itself on the front end; this tool
  only stores structured field values. No raw SQL, filesystem path, or external HTTP.

## Operating it

1. `drush en mcp_tools_metatag -y` (needs `metatag`; parent `mcp_tools`).
2. Grant `mcp_tools use metatag` to the execution user; setting tags needs the **write** scope and
   read-only mode off (and, under config-only mode, the `config` write kind allowed).
3. Discover tag/group keys (`mcp_metatag_list_tags` / `_list_groups`), read current values
   (`mcp_metatag_get_entity` / `_get_defaults`), then set them (`mcp_metatag_set_entity`).
