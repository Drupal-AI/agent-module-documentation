<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Web components

Form: `Drupal\webcomponents\Form\WebcomponentsSettings` at `/admin/config/content/webcomponents` (`administer site configuration`).

Key config keys (`webcomponents.settings`):
- `webcomponents_project_location` — base path/URL for the build (a local library path, `other`, or a CDN origin).
- `webcomponents_project_location_other` — used when location is `other`.
- `webcomponents_project_local_build_file` — serve `build.js` from the local library while assets load from the configured location/CDN.

Runtime behavior:
- `webcomponents_page_attachments_alter()` adds preconnect (fonts/CDN), preload (`build.js`, `wc-registry.json`, web-animations), and modulepreload (`wc-autoload`, `dynamic-import-registry`) link tags.
- `webcomponents_page_bottom()` emits an inline template that sets `window.__appCDN` and `<script src="…build.js">`.
