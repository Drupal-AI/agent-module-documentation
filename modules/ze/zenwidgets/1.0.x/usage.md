<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ZEN widgets integrates the third-party zenwidgets.com service, letting you embed interactive ZEN widgets into any entity via a custom field, backed by a site-wide loader script.
---
The module injects the ZEN widgets loader script on every page via `hook_page_bottom`: `ZenWidgetsService::getScriptRenderArray()` renders a `<script type="module" async>` pointing at `<domain>/scripts/index.js` (default domain `https://www.zenwidgets.com`) carrying `data-zen-website-id` and `data-zen-website-token` attributes from config. A custom field type (`WidgetItem`) with its widget and default formatter lets editors attach a widget to an entity; the formatter renders a `<span data-zen-widget-id … data-zen-widget-data …>` that the loader script hydrates. The service can also fetch the account's available widgets from `<domain>/api/widgets` (Guzzle GET, sending website id + token + language + host as query params) to populate the field's widget dropdown.

Configuration is at `/admin/config/services/zenwidgets` behind a dedicated `administer ZEN widgets configuration` permission (restricted), where you enter the website id and authentication token obtained from a zenwidgets.com account. Security-wise, the "authentication token" is rendered into public page HTML as the `data-zen-website-token` attribute on the loader script (so it is exposed to every visitor, by the service's client-side design), and `getWidgets()` transmits the token as a URL query parameter to the configured domain (HTTPS by default via Guzzle; only the configured `domain` controls the scheme, so avoid setting an http domain). No TLS verification is disabled and no secret is hardcoded.

Setup: create a zenwidgets.com account to get a website id and token, enter them on the settings form, add a "ZEN Widget" field to the entities you want, then pick a widget per entity from the dropdown.

---

- Embed third-party ZEN widgets into any entity
- Add a 'ZEN Widget' field to a bundle
- Select a widget per entity from a dropdown
- Inject the zenwidgets.com loader script site-wide
- Configure the website ID and authentication token
- Fetch available widgets from the ZEN widgets API
- Render widget placeholders hydrated by the loader script
- Restrict configuration to a dedicated ZEN widgets permission
- Set the widget instance data to affect its behavior
- Populate the widget dropdown per current language
- Override the API domain if needed (keep it on HTTPS)
- Display interactive widgets without custom JS
- Manage widget embeds through Drupal fields
- Add complex functionality to entities via a SaaS
- Configure at /admin/config/services/zenwidgets
- Attach widgets to nodes, users, or other entity types
