<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure content moderation permissions

## What gets generated
`Permissions::transitionPermissions()` builds one permission per (workflow × transition × applicable node type):

```
use <workflow_id> transition <transition_id> for <content_type_id>
```

Example: `use editorial transition publish for article`. Only workflows of type `content_moderation` and node types the workflow `appliesToEntityTypeAndBundle()` are included. Assign these on **People → Permissions** (`/admin/people/permissions`, needs `administer permissions`).

## How enforcement works
The service `content_moderation_permissions.state_transition_validation` **decorates** core `content_moderation.state_transition_validation`:
- `getValidTransitions($entity, $user)` — for nodes, merges core's valid transitions with `allowedNodeTransitions()`, which keeps transitions where the user holds `use <wf> transition <t> for <bundle>`.
- `isTransitionValid(...)` — returns TRUE if **either** core's global check passes **or** the per-content-type permission is held.

Behaviour is **additive**: it never revokes a transition core would allow; it only adds bundle-scoped grants. Non-node entities fall through to core unchanged.

## Recommended setup
Per the README, to get true per-type restriction:
1. Remove the core global "use <workflow> transition <transition>" permission from the role.
2. Grant only the specific `… for <content_type>` permissions you want.

That way the role can perform the transition on the chosen content types only.

## Other
- `administer content_moderation_permissions configuration` permission is declared (`restrict access: true`) but the module ships no admin route that uses it.
- No Drush commands, no config schema, no database of its own.
