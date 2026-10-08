<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cookies Addons Paragraphs withholds a Paragraphs entity until the visitor consents to a configured COOKiES service, replacing it with a placeholder overlay and AJAX-loading the paragraph on consent.

---

A submodule of Cookies Addons requiring the Paragraphs module. `cookies_addons_paragraphs_preprocess_paragraph()` reads each paragraph's id; if it appears in `cookies_addons_paragraphs.settings:paragraphs` (one `paragraph_id|service` per line), it replaces the paragraph's `#content` with a `<div class="cookies-addons-paragraph-placeholder" data-cookies-service data-service-name data-paragraph-id>` and attaches the `cookies_addons_paragraphs/cookies-addons-paragraphs` JS library. The behavior listens for the COOKiES `cookiesjsrUserConsent` event; on accept it POSTs `/cookies-addons-paragraphs/get-paragraph/{paragraph_id}/{service}`, whose `CookiesAddonsParagraphsController::getParagraph()` renders the paragraph and AJAX-replaces the placeholder; on deny it shows the COOKiES overlay. Admins configure the list at `/admin/config/system/cookies-addons-paragraphs` (permission `administer site configuration`). Gating is skipped on POST requests.

---

- Defer loading of an embedded-map, external-widget or tracking paragraph until consent.
- Choose which paragraphs are gated by listing `paragraph_id|service` lines in the settings form.
- Map each gated paragraph to any existing COOKiES `cookies_service` entity.
- Show a consent placeholder with the service label where the paragraph would render.
- Auto-load the paragraph via AJAX once its service is consented to, without reload.
- Fall back to the service machine name as the placeholder label when the service entity is missing.
- Keep a third-party-embedding paragraph off the initial page load for GDPR/ePrivacy compliance.
- Reuse one COOKiES service to gate multiple paragraphs sharing a third party.
- Deploy paragraph gating as config (`cookies_addons_paragraphs.settings`).
- Combine with the blocks/views/fields submodules for site-wide consent gating.
