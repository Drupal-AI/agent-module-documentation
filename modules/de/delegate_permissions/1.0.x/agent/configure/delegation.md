<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring delegated permissions

## Setup
1. Enable the module (requires `config_filter`).
2. On **/admin/people/roles**, set role **weights** to define the hierarchy — higher weight = more permissive/"higher" role.
3. On **/admin/people/permissions**, grant **allow delegate permissions** to the roles that should manage lower roles. Give those roles the usual admin-access permissions (`access administration pages`, `view the administration theme`, `access toolbar`).
4. Optionally mark specific permissions **Not Delegable** using the extra column added to the core permissions page (visible to users with `administer permissions`). `allow delegate permissions` is not delegable by default.

## Using it
Delegates visit **/admin/people/delegate-permissions** and see a permissions matrix limited to:
- roles weighted **below** their own highest role (`getLowerRoles()`), and
- permissions **they personally hold** (`getRestrictedPerms()`), minus `not_delegable`.

Saving runs core `user_role_change_permissions()` per lower role.

## How the safe-subset boundary works
- `getRestrictedPerms()` removes any permission the current user does not have, so a delegate can never grant a permission they lack (no escalation to `administer permissions`).
- `getLowerRoles()` returns only roles heavier-weighted (lower) than the delegate, so higher/peer roles cannot be edited.
- The boundary is applied when the form is built (only safe rows are rendered), the same trust model as core's UserPermissionsForm.

## Nuances / hardening
- **Bypassed providers** (`getBypassedProvidersMap()`): a user with `bypass node access` can delegate ALL node-provider permissions (and `administer taxonomy` → all taxonomy permissions) even ones they do not individually hold (DelegatePermissionsHelper.php:160-166). Extend the map via `hook_bypassed_provider_map_alter()`. If you do not want, e.g., `administer nodes` sub-delegated, add it to `not_delegable`.
- **Config sync:** `DelegatePermissionsFilter` merges a delegate's changes with permissions they could not see so an export/import does not silently drop them.
