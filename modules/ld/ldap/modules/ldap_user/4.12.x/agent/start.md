# ldap_user — agent start

Maps LDAP entries ↔ Drupal user accounts/fields and provisions accounts on login, update,
cron or manual creation; handles orphaned accounts. Depends on `ldap_servers`, `ldap_query`,
`externalauth`. Config UI: **Admin → Config → People → LDAP → User settings**
(`/admin/config/people/ldap/user`, route `ldap_user.admin_form`); permission `administer ldap`.
Defines no permissions of its own.

- Provisioning servers, triggers, conflict/orphan policy & field mappings → [configure/ldap_user.md](configure/ldap_user.md)
- Provision/associate accounts in code + the events fired (`DrupalUserProcessor`, processors, event subscribers) → [api/ldap_user.md](api/ldap_user.md)
- Alter mappable targets or the synced account via hooks → [hooks/ldap_user.md](hooks/ldap_user.md)
