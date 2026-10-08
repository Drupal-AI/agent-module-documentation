<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure OECD GlobalRecalls API

Route: `/admin/config/services/psa-oecd-publishing` — `OecdPublishingSettingsForm`
(permission `administer psa_oecd_publishing`). Config object: `psa_oecd_publishing.settings`.

Key settings:
- `oecd_api_key` — sent as `?apikey=` on the import endpoint.
- `oecd_api_use_production_host` (bool) — pick production vs testing host.
- `oecd_api_host_production` / `oecd_api_host_testing` — the hostnames; the client
  builds `https://{host}/` (`OecdApi::getApiUrl()`), so transport is TLS.
- Field mapping — how recall node fields map to OECD GlobalRecalls fields
  (see `OecdMapperController` and `psa_oecd_publishing.api.php`).

Validate the connection with `OecdApi::ping()` (a successful ping expects the portal's
"no zip file provided" response on the import URL).

Editor routes (permission `use psa_oecd_publishing`):
- `/admin/config/services/psa-oecd-publishing/publish-needed` — recalls awaiting publish.
- `/admin/config/services/psa-oecd-publishing/search` — search by recall ID.
- `/admin/config/services/psa-oecd-publishing/recall/{lang}/{jurisdiction}/{recall_id}/delete` — confirm-delete.
