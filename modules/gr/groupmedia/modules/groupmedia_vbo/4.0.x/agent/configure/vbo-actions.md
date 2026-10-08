<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group Media VBO actions

Two VBO action plugins (type `media`), provider `groupmedia_vbo`:

| Action id | Label | Effect |
|---|---|---|
| `vbo_assign_media_to_group` | VBO: Assign media to a Group | relate each selected media to the chosen group |
| `vbo_remove_media_from_group` | VBO: Remove media from a Group | unrelate each selected media from the chosen group |

Both extend `ViewsBulkOperationsActionBase` + `PluginFormInterface`, define a required
`group_id` (entity_autocomplete, target `group`) in their configuration form, and call the
parent `groupmedia.attach_group` service (`assignMediaToGroups()` and the remove equivalent).
`access()` returns the media item's `update` access.

## Wire them into a View (UI)

1. Ensure `views_bulk_operations` and `groupmedia_vbo` are enabled.
2. Edit (or create) a **media-based View** with a page/table display.
3. Add the field **Views bulk operations** (Global) to the display.
4. In that field's settings, enable **VBO: Assign media to a Group** (and/or the remove
   action). Save the View.
5. On the View page, select media rows, choose the action, and — because VBO gathers the
   action configuration at execution time — pick the **target group** for that run, then apply.

## vs. the parent's core actions

The parent module's `assign_media_to_group` / `remove_media_from_group` are core Action
plugins that store a single fixed `group_id` in the action config (`action.configuration.*`
schema), so each action always targets one group. The VBO variants here let the operator pick
the group per run, which scales to many groups. There is no separate config entity or settings
form — configuration lives in the View's VBO field and in the per-run action form.
