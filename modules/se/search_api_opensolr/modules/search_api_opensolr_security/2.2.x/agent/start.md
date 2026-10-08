<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API opensolr Security — agent index

Optional submodule of `search_api_opensolr`. Adds a per-server **Opensolr Security** admin form to set an
opensolr core's HTTP Basic Auth and IP allow-list via the opensolr API. Depends on
`search_api_opensolr`. No own config, permissions, or Drush.

- **The security form, its access gating, and the `OpenSolrSecurity` API methods** →
  [configure/security.md](configure/security.md)

Key facts:
- Route `search_api_opensolr_security.manage_security` →
  `/admin/config/search/search-api/server/{search_api_server}/opensolr-security` (`SecurityAdminForm`).
- Access = `_permission: search_api_server.edit` **and** `_search_api_opensolr_access_check` (server must
  use an opensolr connector).
- Service `search_api_opensolr.client_security` (`OpenSolrSecurity`, extends `OpenSolrBase`):
  `updateHttpAuth`, `removeHttpAuth`, `getIpList`, `addIp`, `removeIp`.
