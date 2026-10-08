<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Gate Telegram media embeds (from the telegram_media_type module) behind COOKiES cookie-consent so they load only after the visitor consents.

---

COOKiES Telegram Media is a small bridge submodule of the COOKiES project. It registers a `telegram` consent service in COOKiES and neutralizes the embed `<script>` that the `telegram_media_type` media entity renders — rewriting it to `type="text/plain"` and tagging it with `data-sid="telegram"` — so the browser will not execute it until the visitor accepts the Telegram service in the COOKiES banner. When consent is given, a JavaScript behavior clones each tagged script, strips the neutralizing attributes, and re-inserts it so the Telegram post loads; without consent a placeholder overlay is shown instead. It ships no routes, permissions, entities, or configuration form of its own; it only wires `hook_page_attachments`, `hook_preprocess_telegram_media_type`, an install weight, and one config entity that declares the consent service. Requires the `cookies` and `telegram_media_type` modules and supports Drupal 9.3+, 10, and 11.

---

- Add GDPR-compliant cookie-consent gating to Telegram media embeds on a Drupal site.
- Block Telegram post embeds from loading and setting cookies before the visitor consents.
- Register a dedicated "Telegram media" consent service in the COOKiES banner UI.
- Group the Telegram consent toggle under the COOKiES "social" service group.
- Show a branded placeholder overlay in place of a blocked Telegram embed.
- Let visitors activate Telegram embeds retroactively by accepting consent, without a page reload.
- Neutralize the Telegram embed script so it is inert until consent (rendered as `text/plain`).
- Re-activate all pending Telegram embeds automatically on the `cookiesjsrUserConsent` event.
- Bridge the `telegram_media_type` media source into COOKiES knock-out handling.
- Comply with privacy law when embedding third-party Telegram content in articles or pages.
- Prevent Telegram's third-party assets from loading for non-consenting visitors.
- Provide a consent link to Telegram's cookie/privacy policy from the banner.
- Extend an existing COOKiES-based consent setup to cover Telegram alongside other services.
- Defer Telegram embed initialization until COOKiES reports the service as consented.
- Keep Telegram media out of the page for users who decline social-media cookies.
- Enforce the module as an enforced dependency of the Telegram consent service config.
- Let editors keep using standard telegram_media_type media items with consent handled site-wide.
- Support multi-service consent pages where Telegram is one of several gated integrations.
- Attach the consent-handling JS only when COOKiES is in knock-out (blocking) mode.
- Load the placeholder styling and Telegram logo overlay for blocked embeds.
