<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bing Indexing API (bing_indexing_api) — agent index
**Submits node URLs to Bing Webmaster's SubmitUrlbatch API on save/delete/unpublish or in bulk.**

- **Version:** 1.0.x  •  **Core:** ^9.3 || ^10 || ^11
- **Routes (all `administer bing index api`):** `.credentials_form` `/admin/config/services/bing-index-api`; `.settings_form` `.../settings`; `.bulk_update_form` `.../bulk-update`
- **Service:** `bing_indexing_api.client` → `BingIndexingApi::reindexUrl(string|array)` POSTs JSON to Bing over HTTPS
- **Hooks:** `node_presave` (create/update/unpublish), `node_predelete` (delete), gated by settings flags
- **Security:** admin-only; API key in config, sent only to Bing over HTTPS (default TLS verify on); outbound-only, no inbound/anonymous endpoints.

See [configure/settings.md](configure/settings.md).