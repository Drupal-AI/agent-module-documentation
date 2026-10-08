<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works: decorated services

The whole integration is two **service decorations** wired in
`GcontentModerationServiceProvider::alter()` (a `ServiceProviderBase`). Decoration is done in a
service provider — not `*.services.yml` — because you cannot decorate *optional* services (the
content_moderation services only exist when that module is enabled) with a normal declaration.
Both decorations are guarded by `if (isset($modules['content_moderation']))`.

## 1. `content_moderation.state_transition_validation`

Decorated by `Drupal\gcontent_moderation\GroupStateTransitionValidation` (extends core
`StateTransitionValidation`), constructed with the inner service plus
`content_moderation.moderation_information`, `current_route_match`, `entity_type.manager`, and
`group_relation_type.manager`. It uses `GroupRouteContextTrait` to find the current group (and,
for a new entity, the group from the route/wizard), then filters valid transitions by the
member's `use <workflow> transition <id>` **group** permissions.

## 2. `access_check.latest_revision`

Decorated by `Drupal\gcontent_moderation\Access\LatestRevisionCheck` (extends core
`LatestRevisionCheck`), constructed with the inner check + `entity_type.manager`. Its `access()`
first calls the inner check; **if that is not allowed**, it loads the entity and ORs in a
group-specific access result (`checkGroupAccess()`), so a group member with the right group
permission can still reach the latest-version route for their group's content.

## Consequences for an agent

- You never call these services directly; they transparently change how core evaluates
  transitions and latest-revision access once the module is enabled.
- To grant capability you configure a **content_moderation workflow** and grant **group
  permissions** — there is no API or config of this module to set.
- Because it decorates optional services, disabling `content_moderation` cleanly removes the
  decorations (the guard fails), leaving core behaviour intact.
- To extend behaviour, decorate these same services after gcontent_moderation, or add group
  permissions to more roles.
