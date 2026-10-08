<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Poool

A client-side integration for the Poool Access SaaS paywall (poool.fr). The module attaches `assets.poool.fr/poool.min.js`, passes an application id and page-type/percent settings via `drupalSettings`, and renders a `<div id="poool-widget">` placeholder. Poool's JS then blurs/truncates the protected content in the browser. A `poool` field type + widget stores per-entity paywall settings, and a `PooolUserIsPremiumEvent` lets other modules mark the current user premium (disabling the widget).

---

# Installing & configuring

- Enable Poool and configure at `/admin/config/services/poool` (permission `administer site configuration`).
- Set the Poool application id (validated against Poool's key format), visibility rules, role targeting and page types (free/premium/subscription/registration).
- Add a `poool` field to bundles and use the widget to mark content and set the hidden percentage.
- Subscribe to `PooolEvents::POOOL_USER_IS_PREMIUM` to grant premium access.

---

- `hook_page_attachments()` injects the Poool tracker script and `drupalSettings.poool` (id, conversion, pageview).
- The application id is validated with a regex before any script is added.
- `hook_preprocess_page()` adds the `poool-widget` div for non-premium users.
- `hook_preprocess_field()` sets `data-poool`/`data-poool-mode` (percent + hide/excerpt/custom) on paywalled fields.
- Premium status is decided by dispatching `PooolUserIsPremiumEvent` (default not premium).
- Page type (free/premium/subscription/registration) is derived from path rules, bundle rules, or the entity's poool field.
- Visibility is filtered by request path mode and by user role.
- IMPORTANT: enforcement is client-side only (Poool's soft-paywall model) — the full content is rendered into the DOM and hidden by Poool's JS.
- No server-side content redaction is performed by the module.
- The application id is a public Poool key, not a secret; no secret/API key is stored or transmitted by the module.
- The tracker script is loaded over HTTPS from `assets.poool.fr`.
- The `poool` field stores serialized settings (set by editors); `getFieldSettings()` reads them back.
- A configuration entity collection (`entity.poool.collection`) is the configure link.
- `hook_poool_page_type_pages` alter hook lets other modules adjust page type.
- No permissions are defined beyond core `administer site configuration` for the settings form.
- Suited to publishers using Poool for metered/premium content, accepting the client-side (soft-paywall) model.
