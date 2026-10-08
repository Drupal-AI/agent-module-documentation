<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group Media — agent index

Integrates core **Media** with the **Group** module: media becomes group content via a
derived `group_media` relation plugin, with an optional auto-tracking feature and a
pluggable media-finder system. Depends on `media` + `group` (`drupal/group:^3.0`).
No global settings form (`configure` is `null`); everything is configured per group type.

- **Install the media relation on a group type, turn on tracking, permissions, the Media tab** →
  [configure/group-media.md](configure/group-media.md)
- **Define/implement a `media_finder` plugin (auto-attach detection)** →
  [plugins/media-finder.md](plugins/media-finder.md)
- **`groupmedia.attach_group` service + Assign/Remove actions (programmatic attach)** →
  [api/attach-service.md](api/attach-service.md)
- **Alter hooks that veto/redirect automatic attachment** →
  [hooks/alter-hooks.md](hooks/alter-hooks.md)

Key facts:
- Relation plugin id: `group_media`, derived per media type → `group_media:<media_type>`
  (e.g. `group_media:image`). Deriver: `GroupMediaDeriver`.
- Installing it creates a config entity `group.relationship_type.<group_type>-group_media-<bundle>`
  whose `plugin_config.tracking_enabled` (0/1) toggles auto-attach; `entity_cardinality` is
  forced to 1.
- Media overview view: `group_media` (route `view.group_media.page_1`), shown as a group *Media* tab.
- Permissions: global `administer groupmedia`; per-group `access group_media overview` plus the
  standard per-plugin `create/view/update/delete group_media:<bundle> entity` group permissions.
- Service `groupmedia.attach_group` (`AttachMediaToGroup`); actions `assign_media_to_group`,
  `remove_media_from_group` (type `media`).
- Submodules: `groupmedia_paragraphs` (finders for media in Paragraphs), `groupmedia_vbo` (VBO actions).
