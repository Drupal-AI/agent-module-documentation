<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

## Static permissions (`workbench_moderation.permissions.yml`)

| Permission | Gates |
|---|---|
| `view any unpublished content` | See unpublished content anywhere — required for any moderator. |
| `view latest version` | See the newest forward (draft) revision (also needs *view any unpublished content*). |
| `view moderation states` | View the moderation states listing. |
| `administer moderation states` | Create/edit/delete `moderation_state` config entities (restricted). |
| `administer moderation state transitions` | Create/edit/delete `moderation_state_transition` config entities (restricted). |
| `moderate entities that cannot edit` | Use the moderation form even without edit access to the entity. |

## Dynamic per-transition permissions

`Permissions::transitionPermissions()` (a `permission_callbacks` entry) generates one
permission **per transition**:

```
use <transition_id> transition
```

e.g. `use draft_published transition`, `use needs_review_published transition`. A user may
perform a transition only if they hold its permission — this is how you map workflow steps to
roles (e.g. authors get `use draft_needs_review transition`, editors get
`use needs_review_published transition`). Adding a new `moderation_state_transition` config
entity automatically creates its `use … transition` permission (rebuild permissions / clear
cache to surface it).

`StateTransitionValidation::userMayTransition()` enforces these checks.
