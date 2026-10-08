<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Optional submodule of Search API opensolr that adds a per-server admin form to manage an opensolr core's HTTP Basic Auth credentials and IP allow-list restrictions directly from Drupal.

---

Enabling `search_api_opensolr_security` adds a **Opensolr Security** local task on each Search API
server that uses an opensolr connector (route
`/admin/config/search/search-api/server/{search_api_server}/opensolr-security`, `SecurityAdminForm`,
gated by `search_api_server.edit` entity access **and** the `_search_api_opensolr_access_check` which
requires the server to be an opensolr one). The form has two sections: **HTTP Authentication** (set/update
a username + password on the core; it shows current enabled/disabled status derived from the core info)
and **IP restrictions** (add an IP + Solr request handler like `/`, `/admin`, `/update`, and remove
existing ones). It calls the opensolr API via the `OpenSolrSecurity` component service
(`updateHttpAuth`, `removeHttpAuth`, `getIpList`, `addIp`, `removeIp`), which extends the parent
module's `OpenSolrBase`. After updating HTTP auth it re-syncs the server's connector so Drupal keeps
querying with the new credentials. There is no config of its own, no permissions of its own, and no
Drush; everything acts on the remote opensolr core through the API. It reuses the parent module's
credentials/endpoint, so it only works once the parent is configured.

---

- Set HTTP Basic Auth (username + password) on an opensolr core from Drupal.
- Update/rotate the core's HTTP auth credentials and keep the Drupal connector in sync.
- See at a glance whether HTTP authentication is currently enabled on the core.
- Add an IP allow-list restriction for a specific Solr request handler (`/`, `/admin`, `/update`, …).
- Restrict admin/update handlers to trusted IPs while leaving query handlers open.
- List the IP restrictions currently configured on the core.
- Remove one or more existing IP restrictions.
- Lock down a hosted Solr core without logging into the opensolr web UI.
- Harden a production search backend's access from within the Drupal admin.
- Manage per-core security for multiple opensolr servers on the same site.
- Re-apply auth after creating a new core so Drupal can authenticate immediately.
- Combine IP allow-listing with Basic Auth for defence-in-depth on the Solr endpoint.
- Delegate opensolr security management to site admins who hold server-edit access.
- Audit/adjust which request handlers are IP-restricted for compliance.
- Remove HTTP auth from a core when moving it to purely IP-based restriction.
- Manage core security programmatically via the `OpenSolrSecurity` service (add/remove IP and auth).
