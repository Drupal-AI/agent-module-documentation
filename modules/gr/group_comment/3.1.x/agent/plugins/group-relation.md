<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `group_comment` group relation plugin, handlers & permissions

## Install & enable

```bash
composer require drupal/group_comment   # pulls drupal/group ^3.0
drush en group_comment -y
```

Requires core `comment` and `group ^3.0`. Per the README, core also needs the patch from
drupal.org issue **#2879087** for create-access delegation to behave.

Enable the relation on a group type like any Group plugin: *Structure → Group types →
(type) → Set available content* → install **Group comment (<comment type>)**. Installing it makes
that comment type's comments group-aware for that group type.

## The relation plugin

`src/Plugin/Group/Relation/GroupComment.php`, annotation `@GroupRelationType`:

```
id = "group_comment"
label = "Group comment"
entity_type_id = "comment"
entity_access = TRUE                 // <-- Group's entity-access layer governs comments
deriver = GroupCommentDeriver
```

`entity_access = TRUE` is the crux: it tells Group to run comment view/update/delete through its
own per-relation access handler, so **group permissions decide comment access**, not only core's
site-wide comment permissions.

Key methods:
- `defaultConfiguration()` sets `entity_cardinality = 1` (a comment belongs to a group once).
- `buildConfigurationForm()` **disables** the `entity_cardinality`, `group_cardinality` and
  `use_creation_wizard` fields (they are shown but locked): the module needs entity cardinality 1
  and relies on unlimited group cardinality so a comment on an entity shared by several groups
  attaches to each. Creation-wizard is off because comments are never created directly in a group.
- `calculateDependencies()` adds a config dependency on `comment.type.<bundle>`.

### The deriver

`src/Plugin/Group/Relation/GroupCommentDeriver.php` loads every `CommentType::loadMultiple()` and
emits one derivative keyed by comment-type machine name, each with `entity_bundle = <type>` and a
label like *"Group comment (<type>)"*. So the effective plugin ids are
**`group_comment:<comment_type>`** (e.g. `group_comment:comment`). `group_comment_comment_type_insert()`
(in `.module`) clears `group_relation_type.manager` definitions when a new comment type is created
so a fresh derivative appears.

## The three relation handlers (services.yml, `shared: false`)

Each decorates Group's default handler (passed as `$parent`).

### Permission provider — `GroupCommentPermissionProvider`

`src/Plugin/Group/RelationHandler/GroupCommentPermissionProvider.php`, wraps
`@group.relation_handler.permission_provider`.

- `getPermission($operation, $target, $scope)`:
  - For `$target === 'relationship'`, returns **FALSE** for `create`, `update`, `delete` — you
    cannot add/update/delete the *comment→group relationship* through the group UI (comments are
    managed via the comment form only).
  - For `view unpublished` / `entity` / `any` scope, returns **FALSE** (no group permission is
    defined): core's `CommentStorage::loadThread` cannot honor it — see the code's `@todo` /
    drupal.org #2980951. This makes group perms **more** restrictive, deferring unpublished-view to
    core's `administer comments`.
  - Otherwise delegates to `$parent` — so standard `view / update any / update own / delete any /
    delete own <plugin> entity` group permissions still exist per comment type.
- `getEntitySkipCommentApprovalPermission()` → `"skip comment approval <pluginId> entity"` when the
  plugin defines entity permissions.
- `buildPermissions()` appends that **"Entity: Skip comment approval"** permission to the parent's
  set.

### Access-control handler — `GroupCommentAccessControl`

`src/Plugin/Group/RelationHandler/GroupCommentAccessControl.php`, wraps
`@group.relation_handler.access_control` plus `@current_route_match`.

Only override is `supportsOperation()`: it returns **FALSE** for `create` + `entity` when the
current route is `entity.group_relationship.create_page` or `entity.group_relationship.create_form`
— i.e. it **closes the group UI paths for creating a comment directly in a group**. All other
operations (view/update/delete) fall through to `$parent`, which enforces the group permissions
above. Comments still get into groups only via `group_comment_entity_insert` (see
[../api/attachment.md](../api/attachment.md)).

### Operation provider — `GroupCommentOperationProvider`

`src/Plugin/Group/RelationHandler/GroupCommentOperationProvider.php`, wraps
`@group.relation_handler.operation_provider`. `getGroupOperations()` returns `[]` — the plugin adds
**no** "add comment" operation to a group, again because comments are created through the comment
form, not the group.

## Group permissions summary

- `access group_comment overview` — group permission from `group_comment.group.permissions.yml`;
  gates the per-group Comments overview view.
- `skip comment approval group_comment:<type> entity` — added by the permission provider; when a
  user holds it in any group the commented entity belongs to, `group_comment_form_alter()` sets the
  comment form's status default to **published** (skips approval).
- Parent-provided per-comment-type entity permissions: `view group_comment:<type> entity`,
  `update any/own …`, `delete any/own …` (whatever Group's default provider emits for an
  entity_access relation). These are what actually gate reading and editing group comments.

## Create-access delegation

`group_comment_comment_create_access()` (a `hook_ENTITY_TYPE_create_access` for `comment`) grants
comment-create when the commented entity is in at least one group where the account holds
`create group_comment:<bundle> entity`:

```php
$plugin_id = 'group_comment:' . $entity_bundle;
foreach ($groups as $group) {
  if ($group->hasPermission("create $plugin_id entity", $account)) {
    return AccessResult::allowed()
      ->addCacheContexts(['user.group_permissions'])
      ->addCacheableDependency($commented_entity);
  }
}
return AccessResult::neutral()->addCacheContexts(['user.group_permissions'])...;
```

It returns `neutral` (never `forbidden`) when the group permission is absent — the standard
additive pattern for create-access hooks, so it grants via group membership without overriding
core comment access. If the commented entity is in no group, it returns `neutral` and core comment
permissions apply unchanged.
