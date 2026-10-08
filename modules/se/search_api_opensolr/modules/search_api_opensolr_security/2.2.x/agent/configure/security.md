<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Manage opensolr core security

Enable with `drush en search_api_opensolr_security`. A **Opensolr Security** local task then appears on
each Search API server that uses an opensolr connector.

## The form

Route `search_api_opensolr_security.manage_security` →
`/admin/config/search/search-api/server/{search_api_server}/opensolr-security`
(`SecurityAdminForm`). The core name comes from the server's `connector_config.core`.

Access requirements (both must pass):

- `_permission: 'search_api_server.edit'` — entity-edit access on the Search API server.
- `_search_api_opensolr_access_check: 'TRUE'` — `LocalActionAccessCheck` allows only when the server's
  backend is an opensolr connector (forbidden otherwise).

### HTTP Authentication section

- Shows current status (enabled/disabled), derived from whether the core info has
  `auth_username`/`auth_password`.
- **Username** (required) + **Password** (required) → submit `::addHttpAuth` calls
  `OpenSolrSecurity::updateHttpAuth($core, $username, $password)`, then `switchOpenSolrConnector()`
  re-syncs the server so Drupal keeps authenticating. (No endpoint exists to read back existing values,
  so the fields start empty.)

### IP restrictions section

- **IP address** (required) + **Request handler** (required, e.g. `/`, `/admin`, `/update`) → submit
  `::addIpRestriction` calls `OpenSolrSecurity::addIp($core, $ip, $handler)`.
- Existing restrictions (from `getIpList()`) are listed and can be removed via `::removeIpRestrictions`
  → `OpenSolrSecurity::removeIp($core, $ip, $handler)` per selected row.

## Service — `OpenSolrSecurity`

`search_api_opensolr.client_security` (extends the parent module's `OpenSolrBase`, so it uses the same
opensolr endpoint + stored credentials):

| Method | Action |
|---|---|
| `updateHttpAuth($core, $username, $password)` | Set/update Basic Auth on the core. |
| `removeHttpAuth($core)` | Remove Basic Auth. |
| `getIpList($core)` | List current IP restrictions. |
| `addIp($core, $ip, $handler)` | Add an IP allow-list entry for a handler. |
| `removeIp($core, $ip, $handler)` | Remove an IP allow-list entry. |

All operations act on the remote opensolr core through the API; nothing is stored in Drupal config.
