LDAP Servers is the foundation submodule of the LDAP suite: it defines the `ldap_server` config entity that describes a directory connection and provides the services other LDAP modules use to bind, search, and read group membership.

---

LDAP Servers stores each directory connection as an `ldap_server` config entity (config prefix `server`), holding the address, port, encryption (none/SSL/TLS), timeout, bind method, service bind DN/password, one or more base DNs, and the attribute mappings that identify a user (login attribute, account-name attribute, mail attribute, thumbnail attribute, and a persistent unique identifier / PUID). It also captures group settings — object class, member attributes, whether groups are nested, and whether groups are derived from the user DN. On top of the entity it exposes a small service layer built on `symfony/ldap`: `ldap.bridge` (`LdapBridge`) opens and binds a connection, `ldap.user_manager` (`LdapUserManager`, extends `LdapBaseManager`) searches for and reads/creates/modifies user entries and resolves a Drupal account from a PUID, and `ldap.group_manager` (`LdapGroupManager`) resolves and edits group memberships (including recursive/nested). Helper services `ldap.token_processor` (attribute token replacement like `[cn]`, `[dn]`) and `ldap.detail_log` (verbose watchdog logging gated by the `watchdog_detail` setting) round it out. Admins manage servers at **Admin → Config → People → LDAP → Servers** (`/admin/config/people/ldap/server`), where each server has add/edit/delete plus **Test** and **Enable/Disable** forms, all gated by the `administer ldap` permission this module defines. A debug report and debug settings page aid troubleshooting.

---

- Define a connection to an Active Directory or OpenLDAP server as reusable config.
- Store the bind (service account) DN and password used for searches.
- Configure LDAPS or StartTLS encryption and a connection timeout.
- Search under one or more base DNs for user entries.
- Choose the bind method: service-account bind, anonymous, or bind with the user's own credentials.
- Map which LDAP attribute is the login name, account name, and email.
- Map a persistent, unique identifier (e.g. objectSid / entryUUID) so renames don't orphan accounts.
- Read a user's group memberships, including nested/recursive groups.
- Create, modify, or delete LDAP user entries programmatically via `ldap.user_manager`.
- Add or remove members of an LDAP group via `ldap.group_manager`.
- Resolve a Drupal user account from a directory PUID.
- Replace attribute tokens like `[cn]`, `[mail]`, `[dn]` in strings via the token processor.
- Test a server's bind and a sample user lookup from the admin Test form before enabling it.
- Enable or disable a server without deleting its configuration.
- Weight multiple servers so searches try them in order.
- Turn on detailed watchdog logging to debug bind/search failures.
- Export server configuration between environments as Drupal config.
- Provide the shared `administer ldap` permission for the whole suite.
- Give other LDAP submodules (authentication, user, query, authorization) a directory to talk to.
- Point a group-membership lookup at the group object class and member attribute your directory uses.
- Derive group membership from the user's DN when the directory encodes it that way.
- Store an email template used when a directory entry lacks a mail value.
- Provide a debug report page summarising server state for support.
- Act as a Symfony Ldap bridge so custom code can run raw queries against a configured server.
