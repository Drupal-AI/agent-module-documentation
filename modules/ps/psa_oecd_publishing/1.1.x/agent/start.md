<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OECD GlobalRecalls API (psa_oecd_publishing) — agent index

**Publishes product-recall nodes to the OECD GlobalRecalls portal (import API) and supports search/delete by ID.**

- **Version:** 1.1.x
- **Core:** ^10.5 || ^11.2 (deps: node, user, views)
- **Config route:** `psa_oecd_publishing.settings` → `/admin/config/services/psa-oecd-publishing` (perm `administer psa_oecd_publishing`)
- **Routes:** `.publish_needed`, `.search`, `.delete` (all perm `use psa_oecd_publishing`; delete via confirm form)
- **Service/API:** `oecd_api.recall` (`OecdApi`): `ping()`, `post(zip)` → `ws/import.xqy?apikey=…`, `get()` (JSON); queue `OecdPublisherQueueWorker`; Drush commands
- **Config:** `psa_oecd_publishing.settings` (api key, hosts, mapping)

**Security:** all web routes are permission-gated (`administer` or `use psa_oecd_publishing`); no anonymous/`_access: TRUE` endpoints. Transport is HTTPS — `OecdApi::getApiUrl()` returns `https://{host}/` and the API key rides as an `apikey` query param over TLS (`src/Api/OecdApi.php:92,101-111`). The `http://…` `OECD_API_URL_RECALL_URI` constant (`OecdApi.php:19`) is only an identifier embedded in a recall path, not a fetch target — not a plaintext-transport issue. API key is stored in module config; protect config per policy. No findings.

See [configure/settings.md](configure/settings.md) and [drush/commands.md](drush/commands.md)
