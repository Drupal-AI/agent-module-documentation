<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cloudflare — agent index

Integrates Drupal with the Cloudflare CDN: API authentication, restoring the visitor's real IP
(behind the Cloudflare proxy), and — via the **cloudflarepurger** submodule — cache purging.
Requires CTools. Config UI is a CTools wizard at `/admin/config/services/cloudflare`
(route `cloudflare.admin_settings_form`, permission `administer cloudflare`).

- **All `cloudflare.settings` keys, auth methods, client-IP restore, zones (config)** →
  [configure/settings.md](configure/settings.md)
- **Services: API client, State, the IP-restore middleware** →
  [api/services.md](api/services.md)
- **Permission** → [permissions/permissions.md](permissions/permissions.md)
- **Cache purging** → see the submodule:
  `modules/cloudflarepurger/2.0.x/agent/start.md`

Key facts: config object `cloudflare.settings`. Auth: `auth_using` = `token` (`api_token`,
Bearer) or `key` (`apikey` + `email`, X-Auth headers). Client-IP restore keys:
`client_ip_restore_enabled`, `remote_addr_validate`, `bypass_host`. Zones in `zones`;
`valid_credentials` flags a passing check. Services: `cloudflare.api_client`,
`cloudflare.state`, middleware `http_middleware.cloudflare`. **No API calls in evals** — ground
in local config. Store credentials in env/Key, not committed.
