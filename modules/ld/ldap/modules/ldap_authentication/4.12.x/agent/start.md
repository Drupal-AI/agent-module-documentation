# ldap_authentication — agent start

Validates the Drupal login form against configured LDAP servers (mixed or exclusive mode),
then associates/provisions the Drupal account via `ldap_user`. Depends on `ldap_servers`,
`ldap_user`, `externalauth`. Config UI: **Admin → Config → People → LDAP → Authentication**
(`/admin/config/people/ldap/authentication`, route `ldap_authentication.admin_form`);
permission `administer ldap`. Defines no permissions of its own.

- Authentication mode, allowed servers, DN allow/exclude rules, email/password UI options → [configure/ldap_authentication.md](configure/ldap_authentication.md)
- Approve/deny a login from custom code after inspecting the LDAP entry → [hooks/ldap_authentication.md](hooks/ldap_authentication.md)
