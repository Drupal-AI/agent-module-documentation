<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Attach/detach service, entity hooks, alter hook & the Comments overview

## Service `group_comment.group_attachment`

Class `Drupal\group_comment\GroupCommentAttachment` (`src/GroupCommentAttachment.php`, implements
`GroupCommentAttachmentInterface`). Constructor args (services.yml):
`@group_relation_type.manager`, `@entity_type.manager`, `@comment.manager`, `@module_handler`.
Two public methods, both driven by entity hooks in `group_comment.module`.

### `attach(EntityInterface $entity)`

Called from `group_comment_entity_insert()` when a **`CommentInterface`** or
**`GroupRelationshipInterface`** is inserted.

1. `getComments($entity)` resolves the affected comments:
   - a Comment → just that comment;
   - a GroupRelationship → all comments of its target entity, **only if the target is commentable**
     (`comment.manager->getFields($entityTypeId)` non-empty), fetched via a comment entity query
     with `->accessCheck(FALSE)` and `condition('entity_id', (int) …)` + `condition('entity_type', …)`.
     `accessCheck(FALSE)` is correct here — this is a system-side bookkeeping fetch to mirror
     relationships, not a user-facing listing.
2. For each comment, get its commented entity, then `CommentedEntityHelper::getGroupsByEntity()`
   (see below) → the groups to attach to.
3. `moduleHandler->alter('group_comment_attach_groups', $groups, $comment, $commented_entity)` lets
   other modules change the target groups.
4. For each target group whose group type has the plugin `group_comment:<comment bundle>` installed
   (`groupRelationTypeManager->getInstalled(...)->has($plugin_id)`), and where the comment is not
   already related (`$group->getRelationshipsByEntity($comment, $plugin_id)` empty), call
   `$group->addRelationship($comment, $plugin_id)`.

Net effect: a comment on a **group** attaches to that group; a comment on a **grouped entity**
attaches to every group the entity belongs to.

### `detach(GroupRelationshipInterface $entity)`

Called from `group_comment_entity_predelete()` when a group relationship is deleted. Gets the
target entity's comments (same `getComments`), and for each comment deletes any of its group
relationships whose group id equals the removed relationship's group. So removing a commentable
entity from a group cleans up that group's comment relationships.

## `CommentedEntityHelper::getGroupsByEntity()`

`src/CommentedEntityHelper.php` (static). Returns the groups a commented entity belongs to, or `[]`
if the entity's type/bundle is not commentable (checked via `comment.manager->getFields()` and the
field `bundles`). If the entity **is** a `GroupInterface`, returns `[$entity]`; otherwise loads
`GroupRelationship::loadByEntity($entity)` and returns each relationship's group keyed by group id.
Used by the create-access hook, the skip-approval form alter, and the attachment service.

## Hooks in `group_comment.module`

- `group_comment_comment_type_insert()` — clears `group_relation_type.manager` cached definitions so
  a new comment type gets its `group_comment:<type>` derivative.
- `group_comment_entity_operation()` — for a **group** entity (and if `views` is enabled), adds a
  **Comments** operation linking to `view.group_comments.page`, but only when the current user has
  the group permission **`access group_comment overview`** (`$entity->hasPermission(...)`) and the
  route exists.
- `group_comment_comment_create_access()` — create-access delegation (documented in
  [../plugins/group-relation.md](../plugins/group-relation.md)).
- `group_comment_entity_insert()` / `group_comment_entity_predelete()` — drive attach/detach.
- `group_comment_form_alter()` — on a `CommentForm`, if the user has
  `skip comment approval group_comment:<bundle> entity` in any group of the commented entity, sets
  `$form['author']['status']['#default_value'] = CommentInterface::PUBLISHED` (skip approval).

## Alter hook (`group_comment.api.php`)

```php
function hook_group_comment_attach_groups_alter(array &$groups, CommentInterface $comment, EntityInterface $commented_entity)
```

Alters the list of groups a comment will be attached to. `$groups` is keyed as built in
`GroupCommentAttachment::attach` (an array holding the commented entity's group list). Use it to add
or remove target groups before attachment.

## The Comments overview view (`config/optional/views.view.group_comments.yml`)

Optional view `group_comments`, installed only when its dependencies (`comment`, `group`) are met.

- **Page display** at path `group/%group/comments`, menu tab title "Comments".
- **Base table** `comment_field_data`; a required relationship
  `group_relationship_to_entity_reverse` joins the comment to its group relationship, and the
  contextual argument **`gid`** (from `group_relationship_field_data`) with `default_action:
  'access denied'` scopes rows to the current group.
- **Access**: `type: group_permission`, `group_permission: 'access group_comment overview'` — the
  overview is gated by that group permission (matching the operation link's check).
- Columns: subject (comment permalink), "Posted in" (commented entity), approval status, post date,
  plus a dropbutton with edit/delete/view-relation links. Exposed filters for approval status and
  comment type; 50/page pager. Shows both approved and unapproved comments to holders of the
  permission.

No config schema ships with the module and there is no settings form.
