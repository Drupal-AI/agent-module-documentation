<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions — own-content transition permissions

The module adds no static permissions. All permissions are generated dynamically at runtime by a
permission callback, one per transition per Content Moderation workflow.

## Registration
`content_moderation_owner_permissions.permissions.yml`:

```yaml
permission_callbacks:
  - \Drupal\content_moderation_owner_permissions\Permissions::ownerPermissions
```

`Permissions::ownerPermissions()` (`src/Permissions.php`) loads every workflow whose type plugin is
`content_moderation` (`Workflow::loadMultipleByType('content_moderation')`) and, for each transition
returned by the workflow's type plugin, emits one permission:

```php
$permissions['use ' . $workflow->id() . ' transition ' . $transition->id() . ' for own content'] = [
  'title' => $this->t('%workflow workflow: Use %transition transition for own content.', [...]),
];
```

## Permission name pattern
```
use <workflow_id> transition <transition_id> for own content
```

This is core Content Moderation's transition-permission name (`use <workflow> transition <transition>`,
from `\Drupal\content_moderation\Permissions::transitionPermissions`) with the suffix
` for own content` appended. The set is therefore workflow-configuration-dependent: adding a workflow
or a transition adds permissions; deleting them removes the permissions. Rebuild caches
(`drush cr`) after workflow config changes if the permissions page looks stale.

### Live example — default `editorial` workflow
Its five transitions produce these five permissions (verified with
`\Drupal::service('user.permissions')->getPermissions()`):

- `use editorial transition create_new_draft for own content`
- `use editorial transition publish for own content`
- `use editorial transition archive for own content`
- `use editorial transition archived_published for own content`
- `use editorial transition archived_draft for own content`

Each is provided by `content_moderation_owner_permissions`, titled e.g.
*"Editorial workflow: Use Publish transition for own content."*, and appears on
`/admin/people/permissions` grouped under this module.

## `restrict access`
The generated permission definitions do not set `restrict access: TRUE`. This matches core
Content Moderation's own transition permissions, which also omit the flag (the flag only adds the
"visitors may be able to perform sensitive actions" warning on the permissions UI; it does not change
enforcement).

## Granting / checking
- Grant on the permissions UI (`/admin/people/permissions`) or with
  `drush role:perm:add <role> 'use editorial transition publish for own content'`.
- List roles holding one: `drush role:perm:list` / inspect a role's `permissions` config.
- Intended pattern: give a role broad edit access (e.g. "edit any article") **and** the own-content
  transition permission, while withholding core's global `use editorial transition <t>` permission,
  so the role can only drive its own content through that transition through the normal editing UI.
