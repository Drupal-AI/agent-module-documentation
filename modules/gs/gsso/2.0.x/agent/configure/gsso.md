<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Group SSO

Route `gsso.settings` → `/admin/group/sso` (permission `administer group`).

Config keys in `gsso.settings`:
- `sso_type` — must equal `saml`; other values make the hook return without acting.
- `sso_group_attribute` / `sso_role_attribute` — names of the IdP attributes to read. If they are equal, only the group attribute is used.
- `sso_separator` — `eol` (mapped to `PHP_EOL`) or a literal string used to split multi-value claims.
- `sso_claims` — the mapping matrix: each claim value → `{ roles: [rid,...], groups: { gid: [group_role,...] } }`.
- `claims_changes` — if set, only re-sync when the stored claims differ from the incoming ones.
- `debug` — enable verbose logging on the `gsso` channel.

On login `gsso_simplesamlphp_auth_user_attributes()`:
1. reads and joins the configured attributes into a claims string,
2. stores it via `GSSO::setUserClaims()`,
3. calls `removeUserMemberships()` (drops every role + Group membership),
4. calls `associateUserToGroups()` to add the mapped roles/groups/group-roles.

Because step 3 is unconditional when claims change, ensure the mapping covers every role/group the user should keep — anything not re-added is lost until the next login.
