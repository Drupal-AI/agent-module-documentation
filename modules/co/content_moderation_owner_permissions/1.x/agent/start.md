<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Moderation Owner Permissions (content_moderation_owner_permissions) — agent index

Adds an **owner-scoped companion permission for every Content Moderation workflow transition**, so a
role can be allowed to move *its own* content through a transition without holding core's global
"use `<transition>`" permission that applies to all content. For each transition of each
`content_moderation` workflow it registers a permission named
`use <workflow_id> transition <transition_id> for own content` (e.g.
`use editorial transition publish for own content`). Permissions are generated dynamically by a
permission callback (`Permissions::ownerPermissions()`), so the exact list depends on the workflows
configured on the site — enable a workflow or add a transition and new permissions appear on
`/admin/people/permissions`.

The enforcement side works by **decorating core's `content_moderation.state_transition_validation`
service** with `OwnerStateTransitionValidation`. Because core registers that service optionally,
decoration can't be declared in a `*.services.yml`; instead a `ServiceProviderBase::alter()`
implementation (`ContentModerationOwnerPermissionsServiceProvider`) installs the decorator at
container-build time only when `content_moderation` is present. The decorator extends core's two
validation methods so that transitions permitted by the own-content permissions are offered in the
moderation-state widget/form and accepted during entity validation, in addition to whatever core's
global transition permissions already allow. The typical setup: grant a role "edit any content" plus
`... transition publish for own content`, and remove the global `use editorial transition publish`,
so authors can draft anything but only publish their own work.

- **Depends on:** `content_moderation` (core; which pulls in `workflows`).
- **Core:** `^9 || ^10 || ^11`.
- **Package:** LocalGov Drupal.
- **Settings page / configure route:** none (`configure` is null) — configuration is entirely on the
  standard permissions page.
- **Permissions:** yes — dynamic, one per workflow transition (see `agent/permissions/`).
- **Services:** decorates one core service; provides no new public API service of its own.
- **Drush / plugin types / hooks / routes / config schema / templates / JS / CSS:** none.

## What you'd do → where
- Understand / grant the own-content permissions, their exact names and how they map to workflows →
  `agent/permissions/own-content-transitions.md`
- Understand how enforcement is wired (the service decoration and the two overridden validation
  methods, and which core code calls each) → `agent/api/service-decoration.md`

## Key facts (real machine names)
- **Permission name pattern:** `use <workflow_id> transition <transition_id> for own content`.
  On the default `editorial` workflow the generated permissions are:
  `use editorial transition create_new_draft for own content`,
  `use editorial transition publish for own content`,
  `use editorial transition archive for own content`,
  `use editorial transition archived_published for own content`,
  `use editorial transition archived_draft for own content`.
- **Permission callback:** `\Drupal\content_moderation_owner_permissions\Permissions::ownerPermissions`
  (declared in `content_moderation_owner_permissions.permissions.yml` under `permission_callbacks`).
- **Service provider:** `Drupal\content_moderation_owner_permissions\ContentModerationOwnerPermissionsServiceProvider`
  (`::alter()`) — installs the decorator only if the `content_moderation` module is installed.
- **Decorated service id (core):** `content_moderation.state_transition_validation`.
- **Decorator service id:** `content_moderation_owner_permissions.state_transition_validation`
  → class `Drupal\content_moderation_owner_permissions\OwnerStateTransitionValidation`
  (extends core `Drupal\content_moderation\StateTransitionValidation`,
  implements `StateTransitionValidationInterface`; constructor arg
  `content_moderation.moderation_information`).
- **Overridden methods:** `getValidTransitions(ContentEntityInterface $entity, AccountInterface $user)`
  and `isTransitionValid(WorkflowInterface, StateInterface $original, StateInterface $new, AccountInterface $user, ?ContentEntityInterface $entity = NULL)`.
