<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Orejime — agent index

Accessible cookie-consent banner (Orejime JS library, a Klaro fork). Consent groups are
`orejime_service` content entities; global banner behaviour is the `orejime.settings` config.
Config form route `orejime_service.settings`. Depends on `field`, `media`, `user`, `system`, `views`.

- **Global banner settings (`orejime.settings` keys), the service entity, and how scripts get gated** →
  [configure/settings.md](configure/settings.md)
- **`drush orejime:create-entity`** → [drush/create-entity.md](drush/create-entity.md)
- **Permissions (which are restricted, which are not)** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Entity **`orejime_service`** (bundle `orejime_system`; revisionable, translatable) at
  `/admin/content/orejime_service`. Fields: `name` (system name), `label`, `description`, `purposes`,
  `cookies`, `scripts`, `required`, `default`, plus published status.
- `hook_page_attachments` publishes services + settings to `drupalSettings.orejime` (cache tags
  `config:orejime.settings`, `orejime_service_list`) and attaches library `orejime/orejime_library`.
- `orejime_library_info_build` loads `orejime_css`/`orejime_js` (default unpkg CDN 2.3.2, overridable
  to any URL / local copy) + `js/orejime_drupal.js` (+ `orejime_iframe_consent.js` when enabled).
- Script gating: `hook_page_attachments_alter` opt-in-tags GA/GTM scripts; `hook_js_alter` →
  `OrejimeManager::setOptIn()` opt-in-tags matching JS assets; authors can hand-tag with
  `type="opt-in" data-name="<service>"`.
- `OrejimeServiceProvider` overrides `asset.js.collection_renderer`
  (`JsCollectionRendererOrejime`) and `media.oembed.resource_fetcher` (`OrejimeResourceFetcher`).
- Ignore condition (RequestPath) hides the banner on matched paths (default `/admin/*`).
