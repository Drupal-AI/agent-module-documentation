# Configure the LDAP suite

`ldap` itself installs nothing configurable — it is a meta module whose only dependency is
`ldap:ldap_servers`. You enable the submodules you need; each adds its own admin screen under
the shared path `/admin/config/people/ldap`.

## Submodules & what to enable

| Submodule | Provides | Depends on |
|---|---|---|
| `ldap_servers` | `ldap_server` config entity + connection services. **Required base.** | `externalauth` |
| `ldap_authentication` | Validates the Drupal login form against LDAP servers. | `ldap_servers`, `ldap_user`, `externalauth` |
| `ldap_user` | Sync/provision LDAP ↔ Drupal accounts and fields. | `ldap_servers`, `ldap_query`, `externalauth` |
| `ldap_query` | Stored `ldap_query_entity` searches + Views integration. | `ldap_servers`, `views` |
| `ldap_authorization` | Grant Drupal roles from LDAP groups (via `authorization`). | `ldap_servers`, `ldap_user`, `authorization` |

External composer/module deps for the project: `symfony/ldap` (the PHP LDAP bridge library),
`drupal/externalauth`, `drupal/authorization`. Install with `composer require drupal/ldap`,
then enable submodules, e.g. `drush en ldap_authentication ldap_authorization -y` (this pulls
in `ldap_servers` and `ldap_user` automatically).

## Typical setup order

1. `drush en ldap_servers -y` and create a server at
   **`/admin/config/people/ldap/server/add`** (`entity.ldap_server.add_form`). Set address,
   port, encryption, bind method, base DNs and the user/mail/PUID attribute mappings, then use
   the per-server **Test** form to confirm bind + a sample lookup.
2. `drush en ldap_user -y` and map LDAP attributes to Drupal user fields at
   `/admin/config/people/ldap/user` (`ldap_user.admin_form`); pick provisioning triggers.
3. `drush en ldap_authentication -y` and choose the authentication mode + allowed servers at
   `/admin/config/people/ldap/authentication` (`ldap_authentication.admin_form`).
4. Optional: `ldap_query` for stored searches (`entity.ldap_query_entity.collection`) and
   `ldap_authorization` to map groups → roles (configured on the `authorization` profile UI).

## Shared config surface

- **Permission:** a single `administer ldap` (defined by `ldap_servers`, `restrict access`)
  gates every LDAP admin route and all four config entities/forms.
- **Menu root:** `ldap.settings` route → `/admin/config/people/ldap` (a menu block page).
- **Debugging:** `ldap_servers` adds `/admin/config/people/ldap/debug` (settings) and
  `/admin/config/people/ldap/debug/report`; the `watchdog_detail` flag on
  `ldap_servers.settings` turns on verbose logging via the `ldap.detail_log` service.
- All servers, queries, mappings and settings are **config entities / config objects**, so the
  whole suite deploys with `drush config:export` / `config:import`.

Details per submodule live in each submodule's own `agent/` docs (see `start.md`).
