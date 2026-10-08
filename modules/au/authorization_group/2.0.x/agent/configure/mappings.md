<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the Groups authorization consumer

## Prerequisites
- `authorization` and `group` enabled, plus an Authorization **provider** (LDAP, OAuth, SAML…).
- At least one Group and Group type with roles defined.

## Create the profile
1. Add an Authorization profile (Authorization module UI).
2. Set the **consumer** to **Groups** (`authorization_group`).
3. Consumer option **"Remove the user from the Group, if they no longer have any roles"** (`delete_membership`): when checked, a full revoke deletes the membership; when unchecked it only empties the group roles.
4. Add mapping rows. Each row's **Group and Role** select is built from every group; options are the group (basic membership) and each of the group type's non-global roles, keyed `"<group_id>"` or `"<group_id>--<role_id>"`.

## Grant / revoke behaviour
- **Grant** (`grantSingleAuthorization`): skips anonymous users and `none`/empty mappings; loads the group, `addMember($user)`, then if a role id is present appends `{target_id: role_id}` to the membership's `group_roles` (only if not already there) and shows a status message.
- **Revoke** (`revokeGrants`): builds the still-granted `group_id => [role_ids]` set from context, loads all memberships, and for groups no longer granted either deletes the membership (if `delete_membership`) or clears its roles; for still-granted groups it keeps only granted roles. Global (`getGlobalRoleId()`) roles are never removed.

## Notes
- `createConsumerTarget()` is intentionally a no-op — the module does not auto-create Drupal groups.
- All effects are driven by the provider's proposals; there is no direct user-facing endpoint.