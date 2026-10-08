LDAP is an umbrella project that integrates a Drupal site with an LDAP or Active Directory server for authentication, user provisioning, directory queries, and role/permission authorization. The top-level `ldap` module is only a meta package; all real functionality lives in its submodules.

---

The project is a suite of cooperating submodules built on top of the `symfony/ldap` bridge and Drupal's `externalauth` module. **LDAP Servers** (`ldap_servers`) is the foundation: it defines the `ldap_server` config entity (connection address, port, encryption, bind method, base DNs, user and group attribute mappings) plus the `ldap.bridge`, `ldap.user_manager` and `ldap.group_manager` services that actually talk to the directory. **LDAP Authentication** (`ldap_authentication`) hooks into the Drupal login form to validate credentials against one or more configured servers, supporting mixed or exclusive modes, whitelist/blacklist DN rules, email templating, and SSO. **LDAP Users** (`ldap_user`) maps LDAP entries to Drupal user properties and fields in both directions, provisioning Drupal accounts from LDAP (and optionally LDAP entries from Drupal) on login, update, cron or manual creation, and handling orphaned accounts. **LDAP Query** (`ldap_query`) stores reusable directory searches as `ldap_query_entity` config entities and exposes their results to code and to Views. **LDAP Authorization** (`ldap_authorization`) plugs into the `authorization` module to grant Drupal roles (or other consumers) from LDAP group membership, with regex mapping and revocation. Together they let a site delegate identity and access management to a corporate directory. All admin screens live under **Admin → Configuration → People → LDAP** (`/admin/config/people/ldap`) and are gated by the single `administer ldap` permission.

---

- Let staff sign in to Drupal with their corporate Active Directory / LDAP username and password.
- Delegate all authentication to a directory server instead of storing passwords in Drupal.
- Auto-create a Drupal account the first time an LDAP-authenticated user logs in.
- Keep Drupal user fields (name, email, title, department) in sync with LDAP on every login.
- Provision LDAP entries from Drupal accounts (reverse sync) when users are created or updated.
- Grant Drupal roles automatically from a user's LDAP group membership.
- Revoke roles when a user leaves an LDAP group (authorization revocation).
- Run in "mixed" mode so both LDAP and local Drupal accounts can log in.
- Restrict login to users under a specific base DN (allow/exclude DN text rules).
- Configure multiple LDAP servers with weights and failover for searches.
- Connect over LDAPS or StartTLS with a service (bind) account or the user's own credentials.
- Map the persistent, unique directory identifier (e.g. objectSid/entryUUID) so renames don't break accounts.
- Build and store reusable LDAP search queries as config entities.
- Surface LDAP query results in a Drupal View (fields, filters, sorts, arguments).
- Detect and act on "orphaned" Drupal accounts whose LDAP entry has been removed.
- Update LDAP-derived data for all users periodically via a cron query.
- Apply an email template (e.g. `@username@example.com`) when the directory has no mail attribute.
- Test a server connection, bind, and a sample user lookup from the admin UI before going live.
- Support SSO where an upstream module already asserts the authenticated username.
- Alter provisioned LDAP entries or synced Drupal accounts from custom code via hooks.
- Export the whole LDAP configuration (servers, mappings, queries) as Drupal config for deployment.
- Enable detailed watchdog logging to debug bind and search problems.
- Let a user update their own email address when the directory value is missing.
- Nest group memberships so members of parent groups inherit child-group authorizations.
- Centralize access control for a corporate intranet built on Drupal.
