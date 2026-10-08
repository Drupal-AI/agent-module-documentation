<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Recite Me Connector — agent orientation

- Config form `ReciteMeConfig` (ConfigFormBase) at `/admin/config/reciteme_connector/recitemeconfig`,
  route gated by `_permission: 'access administration pages'`. Stores `sercice_url` [sic],
  `service_key`, `enable_fregment` [sic], autoload/enable toggles, widget text, and two managed
  file images (public://recite_me/).
- `ReciteMeBlock::build()` attaches the `reciteme` library and pushes `serveiceURL`/`serveiceKey`
  into `drupalSettings` when `is_enable_reciteme == 1`.
- Library `reciteme` = `js/reciteme.js` + jquery + drupalSettings.

Security review (sound): no server-side HTTP request anywhere, so no TLS-verify concern. The
"service key" is a public client-side widget key exposed in page JS by design. Admin form is
permission-gated. No routes beyond the admin form.
