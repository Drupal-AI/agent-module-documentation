<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Omnisend (omnisend) — agent index

**Integrates Drupal with the Omnisend email/SMS marketing API: syncs Webform submissions as contacts; shows lists/campaigns in an admin dashboard.**

- **Version:** 1.1.x
- **Core:** ^9.4 || ^10
- **Depends:** webform:webform
- **Configure:** `/admin/config/services/omnisend` (route `omnisend.settings`, `administer site configuration`).

**Surface:** `OmnisendApi` service (`getLists`, `getCampaigns`, `syncContact`); Webform handler `OmnisendFormHandler`; dashboard/campaigns routes (`access omnisend dashboard`).

**Notes:** Guzzle with default TLS verification; endpoints hard-coded. API key stored in `omnisend.settings` config. The `access omnisend dashboard` permission is referenced in routing but not defined anywhere, so those routes are reachable only by uid 1.
