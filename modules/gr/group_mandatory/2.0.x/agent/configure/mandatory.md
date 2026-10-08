<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Make a bundle group-mandatory

Prereqs: Group and Route Override installed; a group type with a relationship (group content) plugin for the target entity bundle.

1. Edit the **group relationship type** (Group 2.x: `group_relationship_type`; Group 1/legacy: `group_content_type`) for the bundle.
2. In the **Group mandatory** fieldset, tick **Mandatory** ("This content must have a group"). Saved as third-party setting `group_mandatory:mandatory = TRUE` (an entity builder + submit handler persist it, working around group issue #3265962).

Effect: the module registers a `route_override` controller. For the affected bundle's *entity create-form* route:
- `appliesToRouteOfEntityFormOfBundle()` / `appliesToRouteMatch()` limit the override to create forms of group-mandatory bundles.
- `boolAccess()` returns TRUE only if the current user has entity-create access to the group relationship in at least one loaded group (via `GroupRelationTypeManager::getAccessControlHandler()->entityCreateAccess($group, $account)`), with cache context `user.group_permissions` and the relevant list cache tags.
- `build()` renders links to the per-group create form (`entity.group_relationship.create_form`) for each eligible group, or the message "You must be member of a group to do this." when there are none.

Result: standalone creation of the bundle is blocked; content must be created within a group the user can post to.
