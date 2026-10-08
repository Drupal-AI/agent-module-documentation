<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# cloudflare_node_cc — configuration

Route `cloudflare_node_cc.config_form` at `/admin/config/services/cloudflare-node-cache-clear` (permission `administer cloudflare_node_cc`, form `CloudflareConfigForm extends ConfigFormBase`). Settings are stored in the simple config object **`cloudflare_node_cc.settings`** (has schema at `config/schema/cloudflare_node_cc.settings.schema.yml`). Keys:

- `disabled` (bool) — turn the whole feature off.
- `auth_type` — `api_key` (Email + Global API Key) or `api_token`.
- `email` — account email (API-Key auth only).
- `api_key_name` / `api_token_name` — **machine name of a Key entity** (Key module, `key_select` filtered to `type: authentication`) that holds the secret. The secret value itself is not stored here.
- `zone_id` — default single zone id.
- `multi_zone` (bool) — enable per-language zones.
- `lang_zones` — sequence, langcode → zone id.
- `lang_domains` — sequence, langcode → domain.
- `restore_client_ip` (bool) — enable the `CF-Connecting-IP` subscriber (default `true` in shipped install config).
- `confirm_cc` (bool) — require a confirm step before a site-wide purge from the menu.
- `log_purges` (bool) — log a message on each purge.
- `replace_default_save_button` (bool) — purge on the normal node Save rather than adding a second button.
- `purge_if_front_page` (bool) — also purge the site root when the purged node is the configured front page.

`validateForm()` calls the Cloudflare API with the selected credential and validates that `zone_id` / language zone ids are real zones for the account.

Setup: (1) enable `key`; create a Key holding the Cloudflare Global API Key or API Token. (2) Enable this module. (3) At the config form pick the auth type and select the Key by name, set the zone id (or the multi-zone language map). (4) Grant `cloudflare_node_cc purge cache` (site-wide) and/or `cloudflare_node_cc purge cache per node` to the appropriate roles.
