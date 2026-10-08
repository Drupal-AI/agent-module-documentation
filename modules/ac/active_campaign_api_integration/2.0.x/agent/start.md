<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Active Campaign API Integration — agent orientation

Admin ActiveCampaign CRM bridge (v3 API) with form-field mapping and dashboards.

Key files:
- `src/Plugin/ApiCaller.php` — all v3 API calls (cURL). TLS verify is left at cURL defaults (enabled) — no `CURLOPT_SSL_VERIFYPEER => false`. Token sent as `Api-Token` header.
- `src/Plugin/TypeApiCalling.php`, `StoragesHandlers.php` — mapping storage + submit handling.
- `active_campaign_api_integration.module` — theme, `form_alter` attaching handlers, `user_insert` sync.
- `*.routing.yml` — every route uses `_permission: 'administrator'`.

Security notes:
- TLS is fine (not disabled). API token lives in DB config, header-auth.
- `_permission: 'administrator'` is a role name, not a real permission → these routes deny everyone except user 1 (fails closed). Not a vuln, but a functional footgun; document it.
- `active_campaign_api_integration_schemas()` runs `SHOW COLUMNS FROM {table}` with an internally-supplied table name, not request input.
No verified vulnerability.
