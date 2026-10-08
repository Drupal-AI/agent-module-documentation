<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AdSense User Consent (adsense_consent) — agent index

**Renders Google AdSense ads with a client-side visitor consent/personalisation choice, integrating with EU Cookie Compliance or Klaro.**

- **Version:** 1.0.x · **Core:** ^10 || ^11
- **Config:** `adsense_consent.settings` (publisher ID, page/block ads, personalise default, providers, text). Settings form: `/admin/config/services/adsense-consent` (perm: *administer site configuration*).
- **Routes:** `adsense_consent.admin_settings` (admin, permission-gated); `adsense_consent.options_page` → `/ad-options` (`_access: 'TRUE'`, public by design).
- **Key code:** `adsense_consent_page_attachments()` attaches the AdSense loader + consent JS when a valid `pub-...` ID is set; `Controller\DefaultController::adsenseConsentOptionsPage()` renders the public options page; `Form\ConsentForm`/`PersonaliseForm` submit handlers are intentionally empty (consent is applied in JS via cookies).
- **Security:** admin settings route is permission-gated. The `/ad-options` route is intentionally public but read-only — it renders admin-configured markup (via `check_markup()` with the stored format) plus two no-op forms; no mutation, no data leak. No outbound server-side requests, no disabled TLS.

See [configure/settings.md](configure/settings.md)
