# ldap — agent start

`ldap` is an **umbrella/meta project**; it has no functionality of its own (its top-level
`ldap.info.yml` just depends on `ldap:ldap_servers`). Everything lives in five submodules,
all built on `symfony/ldap` + core `externalauth`, and all administered under
**Admin → Config → People → LDAP** (`/admin/config/people/ldap`, permission `administer ldap`).

- Suite overview, install order & the shared config UI → [configure/ldap.md](configure/ldap.md)

Submodule docs (each has its own full deliverables):

- **ldap_servers** — `ldap_server` config entity + connection services (`ldap.bridge`, `ldap.user_manager`, `ldap.group_manager`) → [../../modules/ldap_servers/4.12.x/agent/start.md](../../modules/ldap_servers/4.12.x/agent/start.md)
- **ldap_authentication** — validate the Drupal login against LDAP; mixed/exclusive modes, SSO → [../../modules/ldap_authentication/4.12.x/agent/start.md](../../modules/ldap_authentication/4.12.x/agent/start.md)
- **ldap_user** — sync/provision LDAP entries ↔ Drupal accounts & fields; orphan handling → [../../modules/ldap_user/4.12.x/agent/start.md](../../modules/ldap_user/4.12.x/agent/start.md)
- **ldap_query** — `ldap_query_entity` stored searches + Views integration → [../../modules/ldap_query/4.12.x/agent/start.md](../../modules/ldap_query/4.12.x/agent/start.md)
- **ldap_authorization** — grant Drupal roles from LDAP groups via the `authorization` module → [../../modules/ldap_authorization/4.12.x/agent/start.md](../../modules/ldap_authorization/4.12.x/agent/start.md)
