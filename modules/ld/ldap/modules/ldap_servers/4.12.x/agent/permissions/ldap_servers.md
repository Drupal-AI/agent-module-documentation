# Permissions — ldap_servers

Defined in `ldap_servers.permissions.yml`. This is the **only permission in the whole LDAP
suite** — every LDAP admin route and every LDAP config entity (`ldap_server`,
`ldap_query_entity`, the user/authentication forms) is gated by it.

| Permission | Gates | Notes |
|---|---|---|
| `administer ldap` | All LDAP configuration and behaviour across every LDAP submodule | `restrict access: TRUE` (marked security-sensitive) |

Grant only to trusted administrators — it exposes bind credentials, server config, and the
ability to provision/authorize accounts. Assign via `drush role:perm:add <role> 'administer ldap'`.
