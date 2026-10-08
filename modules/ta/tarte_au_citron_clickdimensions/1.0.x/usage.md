<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
**Tarte au citron - ClickDimensions** is an add-on for the [Tarte au citron](https://www.drupal.org/project/tarte_au_citron) consent manager that registers [ClickDimensions](https://clickdimensions.com/) (a Microsoft Dynamics marketing/tracking service) as a consent-gated service. The ClickDimensions tracking script only loads once the visitor accepts it in the Tarte au citron banner.

---

The module provides a single `@TarteAuCitronService` plugin, `ClickDimensions` (id `clickdimensions`, extends the parent `ServicePluginBase`). Its settings form adds two fields — a required *Account key* (`clickdimensionsAccountKey`) and an optional *Domain* (`clickdimensionsDomain`) — which are stored in the Tarte au citron service configuration and exposed to the front-end tracking library `tarte_au_citron_clickdimensions/tarte_au_citron_clickdimensions` (`libraries/clickdimensions/tarte-au-citron-clickdimensions.js`). Administrators enable and configure the service on the parent module's services screen (`/admin/config/tarte_au_citron/services`). The module itself declares no routes, permissions, config schema or blocks — all configuration, storage and consent orchestration live in the parent Tarte au citron module. The account key/domain are set by administrators (who already control site JavaScript), so the injected values are trusted config, not visitor input. Depends on `drupal:tarte_au_citron`.

---

- Add ClickDimensions tracking as a consent-managed service.
- Only load the ClickDimensions script after visitor opt-in.
- Configure the ClickDimensions account key in admin settings.
- Set a custom ClickDimensions tracking domain.
- Comply with GDPR/cookie consent for Dynamics marketing tracking.
- Let visitors accept or reject ClickDimensions in the consent banner.
- Integrate Microsoft Dynamics marketing analytics on a Drupal site.
- Manage ClickDimensions alongside other Tarte au citron services.
- Keep tracking disabled until explicit consent is given.
- Expose the account key/domain to the front-end tracking library.
- Enable/disable ClickDimensions per environment via config.
- Centralize consent for all third-party scripts in Tarte au citron.
- Respect do-not-track / opt-out choices for marketing analytics.
- Provide editors a simple service toggle rather than manual script tags.
- Load the tracking JS library only when the service is active.
- Document the ClickDimensions consent choice for compliance audits.
- Reuse Tarte au citron's storage and UI for the ClickDimensions config.
