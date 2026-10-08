<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drupal integration of the accessible (RGAA/WCAG) Orejime cookie-consent JavaScript library (a Klaro fork): manage consent "services" and global banner settings in the admin UI, gate third-party scripts behind opt-in, and require consent before iframes/embeds load.

---

Orejime renders a GDPR consent notice/modal built from the Orejime JS library. Consent groups are stored as a revisionable, translatable **`orejime_service`** content entity (managed at `/admin/content/orejime_service`) with fields: system name, label, description, purposes, cookies list, scripts, required, default (enabled), and published status. Global banner behaviour lives in `orejime.settings` (config form `orejime_service.settings` at the module's settings page): cookie name/domain/expiry, privacy-policy link, `must_consent`/`must_notice`, UA (Google Analytics) codes, a custom translations YAML (`texts`), a colour palette that is compiled into a generated CSS file, and an ignore condition (RequestPath, default `/admin/*`). `hook_page_attachments` pushes the published services and settings into `drupalSettings.orejime` and attaches the library; `orejime_library_info_build` loads the Orejime CSS/JS (by default from the unpkg CDN, overridable to a local/custom URL). Scripts are gated three ways: `hook_page_attachments_alter` auto-tags Google Analytics/GTM `<script>` tags as `type="opt-in"`; `hook_js_alter` → `OrejimeManager::setOptIn()` rewrites matching registered JS assets to opt-in; and authors mark inline/external scripts with `type="opt-in" data-name="<service>"` manually. A service provider swaps core's JS collection renderer (`JsCollectionRendererOrejime`, to emit `data-src`/opt-in attributes) and the oEmbed resource fetcher (`OrejimeResourceFetcher`, for iframe consent + autoplay). A Drush command `orejime:create-entity` scripts service creation. Permissions cover creating/editing/deleting/viewing services and revisions (`administer orejime entities` is the restricted admin permission).

---

- Show a GDPR-compliant, accessible (RGAA/WCAG) cookie-consent banner and modal.
- Let visitors accept or reject specific categories of third-party cookies/scripts.
- Block Google Analytics / Google Tag Manager until the user opts in (auto-tagged).
- Gate any registered Drupal JS asset behind consent by matching its filename to a service.
- Require consent before an embedded iframe/video (YouTube, Dailymotion) loads (`iframe-consent`).
- Auto-play YouTube/Vimeo embeds once consent is given (oEmbed resource fetcher override).
- Define consent "services" as editable content entities with label, description, and purposes.
- List the exact cookies a service sets so Orejime can delete them on withdrawal.
- Mark a service as required (strictly necessary) so it can't be declined.
- Enable a service by default in the consent modal.
- Publish/unpublish a service to control whether it appears in the banner.
- Group services into visual categories with titles, descriptions, and drag-order weights.
- Translate consent services and the banner texts (config translation + `texts` YAML).
- Force the modal open until the user actively consents (`must_consent`).
- Force the notice to stay until acknowledged (`must_notice`).
- Customise cookie name, domain (for subdomains), and expiry (days).
- Link to the site's privacy policy from the notice.
- Restyle the banner with a custom colour palette compiled into a generated stylesheet.
- Serve the Orejime library from a self-hosted URL instead of the unpkg CDN.
- Suppress the banner on admin/back-office pages via the RequestPath ignore condition.
- Create consent services programmatically/at deploy time with `drush orejime:create-entity`.
- Track service revisions and revert/delete them with dedicated permissions.
- Show an optional logo in the consent notice.
- Enable debug mode to log missing-translation warnings to the browser console.
