<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drift embeds the third-party Drift.com live-chat widget on your site's non-admin pages once an account identifier is set and the integration is switched on.

---

The Drift module is a thin integration layer around the hosted Drift.com conversational-marketing / live-chat service. It ships no chat UI of its own: it exposes a single settings form (`/admin/config/services/drift`, permission `administer drift configuration`) with just two fields — an on/off status and the Drift account "identifier" (embed ID). When status is on and an identifier is present, `hook_page_attachments` (in `drift.module`) attaches the `drift/drift` asset library and passes the identifier through `drupalSettings.drift.identifier` to `js/script.js`, which runs the standard Drift loader snippet and injects Drift's remote script (`https://js.driftt.com/include/…/<identifier>.js`). The widget is deliberately suppressed on admin routes (checked via the `router.admin_context` service), so it only appears on the front-end. All chat behavior, styling, targeting and data storage happen on Drift's side; the module just wires the snippet in. Configuration lives in the `drift.settings` config object (keys `status`, `identifier`) with a matching schema, so it is exportable/deployable like any other Drupal config.

---

- Add a Drift live-chat bubble to the public front-end of a Drupal 9/10/11 site without hand-editing templates.
- Turn the chat widget on or off site-wide from a single admin toggle, without disabling the module.
- Store the Drift account/embed identifier in exportable Drupal configuration for dev-to-prod deployment.
- Keep the chat widget off all admin pages so editors and admins are not shown the visitor chat.
- Manage a marketing/sales live-chat channel from Drupal while the widget's look-and-feel is configured in Drift.com.
- Enable conversational-marketing playbooks (Drift's targeting/bots) on a Drupal site by dropping in the embed ID.
- Provide visitor-to-agent live chat for support without building or hosting a chat system in Drupal.
- Swap between different Drift accounts/workspaces (e.g. staging vs production) by changing the identifier per environment.
- Quickly disable chat during an outage or campaign pause by flipping the status to Disabled.
- Route the Drift snippet consistently across all front-end pages via `hook_page_attachments` instead of per-page code.
- Let a site builder configure the integration through the Configuration → Services admin menu link.
- Capture leads/visitor conversations on landing pages and marketing content served by Drupal.
- Add pre-sales chat to E-commerce or product pages rendered by Drupal.
- Offer booking/qualification bots (configured in Drift) to visitors on specific front-end pages.
- Restrict who can change the chat configuration by granting the `administer drift configuration` permission to a specific role.
- Ensure the identifier change takes effect immediately, since the form flushes the JS asset cache on save.
- Deploy the Drift integration as part of a config-managed site (config is a plain `drift.settings` object).
- Combine with a cookie-consent solution to gate the third-party Drift tracking script for privacy compliance.
- Add live chat to a decoupled-adjacent or traditional Drupal front-end where Drift is the chosen vendor.
- Provide a low-code way for marketers to have conversational chat present sitewide once developers set the identifier.
