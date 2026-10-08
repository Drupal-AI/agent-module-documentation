# ldap_servers — agent start

Foundation of the LDAP suite. Defines the **`ldap_server`** config entity (a directory
connection + user/group attribute mappings) and the service layer built on `symfony/ldap`
that every other LDAP submodule uses. Depends on `externalauth`. Config UI:
**Admin → Config → People → LDAP → Servers** (`/admin/config/people/ldap/server`,
route `entity.ldap_server.collection`); permission `administer ldap`.

- The `ldap_server` entity, its fields, routes & settings → [configure/ldap_servers.md](configure/ldap_servers.md)
- Connect/bind, search, read groups in code (`ldap.bridge`, `ldap.user_manager`, `ldap.group_manager`, token processor) → [api/ldap_servers.md](api/ldap_servers.md)
- Alter provisioned LDAP entries / cron-process users via hooks → [hooks/ldap_servers.md](hooks/ldap_servers.md)
- The `administer ldap` permission → [permissions/ldap_servers.md](permissions/ldap_servers.md)
