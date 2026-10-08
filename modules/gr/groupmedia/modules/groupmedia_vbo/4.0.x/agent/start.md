<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group Media VBO — agent index

Submodule of **Group Media**. Adds two Views Bulk Operations action plugins (type `media`)
that assign/remove media to a group, choosing the group at run time. Requires `groupmedia` +
`views_bulk_operations`. No config, permissions, routes, or services of its own.

- **The VBO actions and how to wire them into a media View** →
  [configure/vbo-actions.md](configure/vbo-actions.md)

Key facts:
- Action ids: `vbo_assign_media_to_group`, `vbo_remove_media_from_group` (type `media`,
  provider `groupmedia_vbo`), extending `ViewsBulkOperationsActionBase`.
- Each has a required `group_id` (entity_autocomplete to `group`); VBO collects it at run time,
  so one action can target any group (vs the parent's core actions which bake in one group).
- Delegates to the parent service `groupmedia.attach_group`
  (see [../../../../4.0.x/agent/api/attach-service.md](../../../../4.0.x/agent/api/attach-service.md)).
- Access: requires `update` on each selected media item.
