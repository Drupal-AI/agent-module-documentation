<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

The module defines **one dynamic permission per Content Moderation workflow**. There are no static
permissions.

## The permission

| Permission (machine name) | Source | Gates |
|---|---|---|
| `bypass {workflow_id} transition restrictions` | dynamic — `ContentModerationBypassPermission::transitionPermissions()`, wired by `content_moderation_bypass.permissions.yml` (`permission_callbacks`) | Setting a moderated entity of that workflow to **any** moderation state, ignoring the workflow's allowed transitions and the per-transition `use X transition Y` permissions. |

- The title shown on the permissions page is `"%workflow workflow: Bypass transition restrictions."`
  (e.g. *"Editorial workflow: Bypass transition restrictions."*).
- One permission is generated for **every** workflow of type `content_moderation`, so the list grows
  and shrinks with your workflows. The class extends core `\Drupal\content_moderation\Permissions` and
  iterates `Workflow::loadMultipleByType('content_moderation')`.
- Live examples on this site: `bypass editorial transition restrictions`,
  `bypass dkan_publishing transition restrictions`.

## Grant it

```bash
drush role:perm:add <role> 'bypass editorial transition restrictions'
drush cr
```

```php
\Drupal\user\Entity\Role::load('<role>')
  ->grantPermission('bypass editorial transition restrictions')
  ->save();
```

Or via **People → Permissions** (`/admin/people/permissions`).

## How the check is performed (machine-name detail)

Every enforcement point builds the permission string through one helper:

```php
// src/ContentModerationBypassTrait.php
public static function permissionForWorkflow(WorkflowInterface $workflow) {
  $permission = t('bypass @workflow_id transition restrictions', ['@workflow_id' => $workflow->id()]);
  return $permission->__toString();
}
```

then calls `$user->hasPermission(self::permissionForWorkflow($workflow))`. The permission is
**defined** with plain string concatenation (`'bypass ' . $workflow->id() . ' transition
restrictions'`) but **checked** through `t()`; for a normal machine-name workflow id (lowercase
`[a-z0-9_]`) the two strings are identical, so the check matches the defined permission name.

## Where it is enforced

The same `hasPermission()` gate runs in three places (see [../api/services.md](../api/services.md)):

1. `BypassModerationStateConstraintValidator::validate()` — the authoritative **entity-save** gate.
2. `ContentModerationBypassStateTransitionValidation::isTransitionValid()` /
   `getValidTransitions()` — the transition-validation service.
3. `ContentModerationBypass::getTransitionsForState()` — the state-selector widget list.

A user **without** the permission is bound by normal core behaviour at all three points; there is no
form field, query parameter, or API input that can grant the bypass without the permission.
