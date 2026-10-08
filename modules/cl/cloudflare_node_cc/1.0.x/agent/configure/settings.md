<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# cloudflare_node_cc — configuration

Route `cloudflare_node_cc.config_form` at `/admin/config/cloudflare-node-cache-clear` (permission `administer cloudflare_node_cc`). Settings are stored in Drupal **state** (not config export) via `CloudflareService::setStateConfig()`; keys:

- `cloudflare_email` — account email (API-Key auth only)
- `cloudflare_auth_type` — `key` or `token`
- `cloudflare_api_key_name` / `cloudflare_api_token_name` — **name of a Key entity** (from the Key module) holding the secret
- `cloudflare_zone_id` — default single zone
- `cloudflare_multi_zone` — bool; enable per-language zones
- `cloudflare_lang_zones` — map langcode → zone id
- `cloudflare_lang_domains` — map langcode → domain
- `cloudflare_restore_client_ip` — bool; enable the CF-Connecting-IP subscriber

Setup: (1) enable `key`; create a Key holding the Cloudflare Global API Key or API Token. (2) Enable this module. (3) At the config form pick auth type and select the Key by name, set zone id (or multi-zone map). (4) Grant `cloudflare_node_cc purge cache` to editor roles.

If enabling `cloudflare_restore_client_ip`, ensure Drupal's `trusted_host`/reverse-proxy settings only accept traffic from Cloudflare, since the subscriber trusts the `CF-Connecting-IP` header unconditionally.
