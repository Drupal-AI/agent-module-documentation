<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google API PHP Client — agent index

Integration layer over the `google/apiclient` PHP library. No user-facing feature of its own —
other modules use it to store Google credentials, run OAuth2 / service-account auth, and get
`Google\Service\*` objects. Single permission: `administer google api settings`.

Two account entity types:
- **`google_api_client`** — *content* entity (base_table `google_api_client`): OAuth2 user-consent
  accounts. Fields: `name`, `developer_key`, `client_id`, `client_secret`, `services`, `scopes`,
  `is_authenticated`, `uid`. Access token lives in **State**, not a stored field.
- **`google_api_service_client`** — *config* entity (`config_prefix: google_api_service_client`):
  service accounts. Exported keys: `id`, `label`, `auth_config` (JSON key), `services`, `scopes`.

- **Manage accounts, settings/Scan Library, config objects** → [configure/accounts.md](configure/accounts.md)
- **Use the client service to make API calls (`getServiceObjects`)** → [api/services.md](api/services.md)
- **The four alter/response/access hooks** → [hooks/hooks.md](hooks/hooks.md)

Configure route: `google_api_client.google_api_client_settings`
(`/admin/structure/google_api_client_settings`). Account collections:
`/admin/config/services/google_api_client` and `/admin/config/services/google_api_service_client`.
OAuth callback route: `google_api_client.callback` (`google_api_client/callback`). No Drush, no
plugin types the module defines. Actual Google API calls need real Google credentials.
