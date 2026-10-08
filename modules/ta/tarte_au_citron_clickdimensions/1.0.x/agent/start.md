<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tarte au citron - ClickDimensions (tarte_au_citron_clickdimensions) — agent index

Consent-gated **ClickDimensions** (MS Dynamics marketing) service plugin for **Tarte au citron**. Version **1.0.0**, core `^9 || ^10`. Depends on `drupal:tarte_au_citron`.

**Shape:** one `@TarteAuCitronService` plugin `ClickDimensions` (id `clickdimensions`, extends `ServicePluginBase`). Settings: required `clickdimensionsAccountKey`, optional `clickdimensionsDomain` → fed to front-end library `libraries/clickdimensions/tarte-au-citron-clickdimensions.js`. Enabled at parent's `/admin/config/tarte_au_citron/services`.

**Surface:** no own routes/permissions/config schema; consent + storage handled by parent module. Account key/domain are admin-set trusted config (not visitor input) — the tracking-script value is admin-controlled by design, so no stored-XSS elevation beyond existing admin capability.
