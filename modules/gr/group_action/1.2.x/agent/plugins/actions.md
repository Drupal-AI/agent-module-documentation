# Group Actions — the action plugins

All actions extend `GroupActionBase` (`ConfigurableActionBase`). They are consumed like any
Drupal action: attach to a VBO view, or select in an ECA "action" step. They are NOT plugin
*types* you implement — this module defines concrete actions, not a manager.

## The plugins

| Action id | `@Action` type | Preset in `defaultConfiguration()` | Deriver |
|---|---|---|---|
| `group_add_content` | `node` | `operation=create` | `GroupActionDeriver` (adds `…:<entity_type>` variants) |
| `group_remove_content` | `node` | `operation=delete` | `GroupActionDeriver` |
| `group_update_content` | `node` | `operation=update` | `GroupActionDeriver` |
| `group_add_member` | `user` | `operation=create`, `content_plugin=group_membership` | — |
| `group_remove_member` | `user` | `operation=delete`, `content_plugin=group_membership` | — |
| `group_update_member` | `user` | `operation=update`, `content_plugin=group_membership` | — |

The deriver (`GroupActionDeriver`) creates one derivative per group-enabled entity type
(skipping `user`), so a view of a specific entity type only offers relevant plugins.

## Configuration keys (`buildConfigurationForm` / `defaultConfiguration`)

| Key | Meaning |
|---|---|
| `operation` | `create` / `update` / `delete`. Usually preset by the chosen plugin. |
| `content_plugin` | The Group relation/content plugin id (e.g. `group_membership`, `group_node:article`). A `_none` option guards selection. If the entity is bundle-aware and a `:<bundle>` derivative exists, it is auto-appended at run time. |
| `group_id` | Numeric group ID **or** UUID. Supports tokens. Rendered as an `entity_autocomplete` (target `group`) unless running inside the ECA BPMN.io modeller, where it falls back to a plain textfield. |
| `entity_id` | Optional. The entity to operate on; blank = the entity the action is executed against. Supports tokens and UUIDs. |
| `values` | Textarea, one `key: value` per line (repeat a key for multiple values). Raw relationship field values, e.g. `group_roles: mygroup-editor`. Supports tokens. Ignored for `delete`. |
| `add_method` | Create only: `skip_existing` (default), `always_add`, `update_existing` (upserts → falls back to update). |

Values are parsed with `decodeValues()` (splits each line on the first `:`) and token-replaced
at execute time with the operated entity (and the group) as token data.

## Access (no bypass)

`GroupActionBase::access()`:
- Resolves the entity and its group, and the effective `content_plugin` id.
- **Group v2/v3:** asks the relation's permission provider for the `create|update|delete` +
  `relationship` + `any`/`own` permission and checks `$group->hasPermission()`, then the admin
  permission; site super-user (uid 1) and roles flagged `isAdmin()` are also allowed.
- **Group v1:** checks `"<operation> <content_plugin> content"` on the group.
- Forbidden if the group doesn't exist or the content plugin isn't installed on that group type.

## Execute flow

`execute()` loads entity + group, appends the bundle derivative to `content_plugin` if needed,
verifies the plugin is installed and the entity type/bundle match, token-replaces `values`,
then calls `executeOperation()`:
- **create** honours `add_method`; v2 `addRelationship()` / v1 `addContent()`.
- **delete** removes matching relationships/content.
- **update** sets changed field values on existing relationships and saves.

`Compatibility::beforeOperation()/afterOperation()` temporarily bump ECA's recursion threshold
so Group's automatic content re-save (for access recalculation) doesn't trip ECA recursion
detection. Both `GroupActionBase` and `Compatibility` are marked `@internal`.
