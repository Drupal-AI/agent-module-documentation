<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group Comment (group_comment) — agent index

Integrates core **Comment** with the **Group** module: each comment becomes a Group relationship,
so comment access is decided by **group permissions** and comments auto-attach to the group(s) of
their commented entity. Package `Group`. Version **3.1.0-alpha1**, core `^10 || ^11`.
License GPL-2.0-or-later.

Dependencies: core **`comment`**, contrib **`group` `^3.0`**. README note: core must be patched
(drupal.org issue **#2879087**) for comment create-access delegation to work.

## What it provides (from source)

- **Group relation plugin** `group_comment` (`entity_type_id = "comment"`, `entity_access = TRUE`),
  in `src/Plugin/Group/Relation/GroupComment.php`, with a **deriver** producing **one derivative
  per comment type** (`GroupCommentDeriver.php`, ids `group_comment:<comment_type>`). Forces
  `entity_cardinality = 1` and disables the cardinality / creation-wizard config fields.
- **Three relation handlers** (services, `shared: false`) that wrap Group's defaults —
  a permission provider, an access-control handler, and an operation provider.
- **Attachment service** `group_comment.group_attachment` (`GroupCommentAttachment`) that attaches
  comments to groups on insert and detaches them when a relationship is removed.
- **Group permissions**: `access group_comment overview` (in
  `group_comment.group.permissions.yml`) plus a per-comment-type
  `skip comment approval group_comment:<type> entity` (added by the permission provider), on top of
  Group's standard view/update/delete comment permissions.
- **Optional view** `views.view.group_comments` (`config/optional/`): the per-group **Comments**
  overview at path `group/%group/comments`, access-gated by the `access group_comment overview`
  group permission.
- **Hooks** in `group_comment.module` and one alter hook (`hook_group_comment_attach_groups_alter`,
  documented in `group_comment.api.php`). No settings form, no Drush, no config schema.

## Solution docs

- **The `group_comment` relation plugin, its deriver, the three handlers, all group permissions,
  and how access is delegated** → [plugins/group-relation.md](plugins/group-relation.md)
- **The attach/detach service, the entity hooks that drive it, the alter hook, and the Comments
  overview view** → [api/attachment.md](api/attachment.md)
