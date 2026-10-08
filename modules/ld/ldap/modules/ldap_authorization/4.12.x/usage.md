LDAP Authorization Provider plugs LDAP group membership into the Authorization API, letting a site grant (and revoke) Drupal roles — or any other authorization consumer — from a user's LDAP groups.

---

The submodule registers a single `@AuthorizationProvider` plugin, `ldap_provider`
(`LDAPAuthorizationProvider`, extending the `authorization` module's `ProviderPluginBase`). It
does not have its own admin route; instead you configure it through the Authorization module's
"authorization profiles", pairing this LDAP provider with a consumer (most commonly Drupal
roles) and defining mappings. Each mapping (schema
`authorization.provider_mappings.plugin.ldap_provider`) has a `query` — the LDAP group DN or
value to match — and an `is_regex` flag for pattern matching. Provider-level settings
(`authorization.provider.plugin.ldap_provider`) pick the LDAP `server` to read groups from,
whether to apply the mapping `only_ldap_authenticated` users, and whether to
`use_first_attr_as_groupid` (convert a full DN to the value of its first attribute before
matching). The plugin declares `syncOnLogonSupported = TRUE` and `revocationSupported = TRUE`,
so authorizations can be re-evaluated on each login and roles removed when the user leaves a
group; it cooperates with `ldap` and `ldap_authentication` handlers and uses
`ldap_servers`' `LdapGroupManager` to resolve (optionally nested) memberships and
`ldap_user`'s `DrupalUserProcessor` for the account. It requires `ldap_servers`, `ldap_user`
and the `authorization` module.

---

- Grant Drupal roles automatically from LDAP/Active Directory group membership.
- Revoke roles when a user is removed from the corresponding LDAP group.
- Re-evaluate a user's roles on every login (sync-on-logon).
- Map a specific LDAP group DN to a specific Drupal role.
- Use a regular expression to match many LDAP groups to one role.
- Convert a full group DN to its first-attribute value before matching (e.g. just the CN).
- Restrict role grants to users who authenticated via LDAP only.
- Resolve nested/recursive LDAP group memberships for role assignment.
- Centralize role-based access control in the corporate directory.
- Give "domain admins" the Drupal administrator role without manual assignment.
- Provision editor/reviewer roles from department or team groups.
- Keep Drupal roles continuously in sync with directory group changes.
- Drive any Authorization consumer (not only roles) from LDAP groups.
- Combine multiple mappings so one user can receive several roles.
- Choose which configured LDAP server supplies group data.
- Export the authorization mapping as Drupal config for deployment.
- Remove all directory-derived roles when a user leaves the organization.
- Audit which LDAP groups grant which Drupal access via the mapping config.
- Support onboarding where access is granted purely by directory group placement.
- Reduce manual role administration for large user bases.
