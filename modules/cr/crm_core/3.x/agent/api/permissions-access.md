<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CRM Core — permission model & access helper

The base module defines the *shape* of the CRM permission set but ships no `*.permissions.yml`.
Instead it provides a reusable builder that each entity-bearing submodule calls from its own
`permission_callbacks`.

## `CRMCorePermissions::entityTypePermissions($entity_type)`

`src/CRMCorePermissions.php`. Given a CRM entity type id, returns a permissions array using the
entity's `permission_labels` (singular/plural) and whether it has an `owner` key:

- `administer {type} entities` — any action; `restrict access: TRUE`.
- `create {type} entities`.
- `edit own {type} entities` — only if the entity has an `owner` key.
- `edit any {type} entity` — `restrict access: TRUE`.
- `view own {type} entities` — only if the entity has an `owner` key.
- `view any {type} entity` — `restrict access: TRUE`.

Callers:
- `crm_core_contact` → `ContactPermissions::permissions()` builds them for
  `crm_core_individual` and `crm_core_organization`.
- `crm_core_activity` → `ActivityPermissions::permissions()` builds them for `crm_core_activity`.

Because the contact/activity entities set `permission_granularity = "bundle"`, core additionally
generates per-bundle variants such as `view any crm_core_activity entity of bundle {bundle}`
(these are what the activity access handler checks). The base-module permission `administer
crm-core` (used by the settings route) is not defined by any shipped `permissions.yml`.

## `Access\CRMCoreAccess::access(Route $route, AccountInterface $account)`

Custom access callback for the `/crm-core` overview route. It:

1. Loads the top-level menu tree rooted at the current route and runs the `checkAccess` +
   `generateIndexAndSort` manipulators.
2. If **any** child link is accessible, returns
   `AccessResult::allowedIfHasPermissions($account, ['administer crm_core_individual entities',
   'administer crm_core_organization entities', 'view any crm_core_activity entity'], 'OR')`.
3. Otherwise `AccessResult::forbidden()`.

Net effect: `/crm-core` is visible to users who can administer contacts or view activities and who
have at least one reachable child section.
