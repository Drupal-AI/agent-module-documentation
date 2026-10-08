<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group permissions

These are **group permissions** (managed per Group type / group role), not global site
permissions. Declared in `gcontent_moderation.group.permissions.yml`.

## Static permission

| Permission | Gates |
|---|---|
| `view latest version` | Viewing the latest (pending/unpublished) revision of group content — the `/…/latest-version` tab and the `moderated_group_content` view. Requires the underlying "view any/own unpublished" permission too. |

## Dynamically generated transition permissions

`permission_callbacks: GroupContentModerationPermissions::groupPermissions` generates, for
**every** `content_moderation` workflow and **every** transition in it, a permission:

```
use <workflow_id> transition <transition_id>
```

with title `"%workflow workflow: Use %transition transition."`. Examples for the core Editorial
workflow:

- `use editorial transition create_new_draft`
- `use editorial transition publish`
- `use editorial transition archive`

Add a new transition to a workflow and its group permission appears automatically; add a new
workflow `my_flow` with a `submit` transition and `use my_flow transition submit` appears.

## How they are enforced

`GroupStateTransitionValidation` (decorating `content_moderation.state_transition_validation`)
computes the valid transitions for a user on a group entity by checking these group permissions
in the context of the entity's group (resolved from the route, including the group-content
wizard for new entities). So a member sees only the transitions their group role allows —
independent of their global content-moderation permissions.

## Inspecting the generated list (PHP)

```php
$perms = (new \Drupal\gcontent_moderation\Access\GroupContentModerationPermissions())->groupPermissions();
// array keys like 'use editorial transition publish'
```
