# ldap_authorization — agent start

Registers an Authorization API **provider plugin** (`ldap_provider`) that grants/revokes Drupal
roles (or any authorization consumer) from LDAP group membership. Depends on `ldap_servers`,
`ldap_user`, and the `authorization` module. It has **no admin route of its own** — configure it
inside an Authorization profile (via the `authorization` module). No permissions of its own
(all LDAP config is gated by `administer ldap`).

- The `ldap_provider` plugin, its settings, mappings & how to set up role sync → [configure/ldap_authorization.md](configure/ldap_authorization.md)
