# Configure visibility groups & assign blocks

The module has **no** module settings form (info.yml declares no `configure` route). All
configuration is the `block_visibility_group` config entity, managed from the block layout UI.

## Admin routes (all require the core `administer blocks` permission)

| Route | Path | Purpose |
|---|---|---|
| `entity.block_visibility_group.collection` | `/admin/structure/block/block-visibility-group` | List groups (also shown as a tab on the Block Layout page) |
| `entity.block_visibility_group.add_form` | `.../add` | Add a group |
| `entity.block_visibility_group.edit_form` | `.../{block_visibility_group}` | Edit a group + its conditions |
| `entity.block_visibility_group.delete_form` | `.../{block_visibility_group}/delete` | Delete a group |
| `block_visibility_groups.condition_select` | `.../{group}/condition/select/{redirect}` | Pick a condition type to add (modal) |
| `block_visibility_groups.condition_add` | `.../manage/{group}/condition/add/{condition_id}/{redirect}` | Configure/add a condition |
| `block_visibility_groups.condition_edit` | `.../manage/{group}/condition/edit/{condition_id}/{redirect}` | Edit a condition |
| `block_visibility_groups.condition_delete` | `.../manage/{group}/condition/delete/{condition_id}/{redirect}` | Remove a condition |
| `block_visibility_groups.admin_library` | `/admin/structure/block/library/{theme}/{group}` | Group-scoped "Place block" library |

## Create a group (UI)

1. Go to **Admin → Structure → Block Layout → Block Visibility Groups** and click **Add Block Visibility Group**.
2. Set **Label** and machine **id**.
3. **Logic** (`logic`): choose *All conditions must pass* (`and`) or *Only one condition must pass* (`or`).
4. **Allow other Conditions on blocks** (`allow_other_conditions`): if unchecked, blocks placed in
   this group have their own per-block visibility options removed (the group is the sole source of
   visibility rules); if checked, blocks may add extra conditions on top.
5. **Save**. Re-edit the group — the **Conditions** section only appears after the first save.
6. In Conditions, **Add new condition** (AJAX modal), pick a condition plugin, configure it, save.
   Conditions can be negated where the plugin supports it. Repeat to build the shared rule set.

## Config entity shape (`config_export` / schema)

`block_visibility_groups.block_visibility_group.{id}`:

| Key | Meaning |
|---|---|
| `id`, `label`, `uuid` | Identity |
| `logic` | `and` (default) or `or` — how the group's conditions combine |
| `conditions` | Sequence of condition plugin configs, keyed by uuid (`condition.plugin.[id]` schema) |
| `allow_other_conditions` | Bool — allow per-block conditions in addition to the group's |

Conditions come from the core condition plugin manager, so any condition plugin core or a contrib
module (CTools, Menu Condition, Term Condition, Token Conditions…) provides is selectable.

## Assign a block to a group

Edit any block's **Visibility** settings. The module adds a **Condition Group** section (the
`condition_group` visibility plugin) with a **Block Visibility Groups** select — choose the group
(or "No Block Visibility Group"). The block then inherits that group's conditions and logic. If the
group's `allow_other_conditions` is off, the block's other visibility tabs are hidden.

Schema: `config/schema/block_visibility_group.schema.yml`. Entities export/deploy with
`drush config:export`.
