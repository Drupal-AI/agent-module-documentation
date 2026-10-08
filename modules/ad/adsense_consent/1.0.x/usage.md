<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AdSense User Consent renders Google AdSense ads (as a block and/or page-level auto ads) while giving visitors a client-side choice about ad personalisation and consent.

The module attaches the AdSense loader script when a valid publisher ID (`pub-<digits>`) is configured, then adds JS that reads consent state from EU Cookie Compliance, Klaro, or its own `ad_consent` cookie before enabling personalised ads. Admins configure the publisher ID, page-level vs block ads, the personalisation default, provider list, and the rich-text explanation shown on a public `/ad-options` page. All consent/personalisation toggling is done in JavaScript via cookies — the `ConsentForm` and `PersonaliseForm` submit handlers intentionally do nothing server-side. The `/ad-options` route is intentionally public (`_access: 'TRUE'`) so visitors can read the advertising-options page and set their preferences; it only renders admin-configured markup and the two no-op forms, so it neither mutates state nor leaks data.

Typical setup: enable the module, visit the settings form under Configuration → Services → AdSense Consent, enter the publisher ID, choose whether to serve page-level ads and/or place the AdSense block, wire it to your consent tool (EU Cookie Compliance / Klaro) if used, and edit the explanatory text and third-party provider list shown on `/ad-options`.

---

Short summary: shows AdSense ads with a visitor-facing consent/personalisation choice.

The problem it solves is running AdSense on a site that must respect user consent (GDPR/ePrivacy): it defers or de-personalises ads until the visitor agrees, integrating with existing cookie-consent modules or its own cookie. It works by attaching the AdSense script plus small JS behaviours (`apply_personalisation_prefs`, `apply_consent_prefs`, `page_level`) driven by `drupalSettings`, and by exposing a public advertising-options page built from admin config.

Operationally note that ads only load when a syntactically valid `pub-...` publisher ID is set, that the `/ad-options` page is public by design, and that admin-supplied text is passed through `check_markup()` with the stored text-format, so restrict who can edit the settings (the settings form requires *administer site configuration*).

---

- Install and enable the AdSense User Consent module.
- Set your Google AdSense publisher ID (`pub-XXXXXXXX`) on the settings form.
- Turn on page-level (auto) ads so AdSense injects ads across the site.
- Place the `AdSense` block in a region to show a fixed ad unit.
- Choose the default personalisation setting (personalised vs non-personalised ads).
- Require explicit consent before any ads load (`wait_consent`).
- Integrate consent with the EU Cookie Compliance module.
- Integrate consent with the Klaro consent manager, naming the Klaro service.
- Let AdSense read the site's existing cookie-consent cookie name automatically.
- Edit the rich-text “Advertising Consent” explanation shown to visitors.
- Edit the “Ad Personalisation Explained” text for the options page.
- Maintain the third-party ad-network provider list (name, URL per line).
- Give visitors a public `/ad-options` page to review and change ad preferences.
- Show a “Show Personalised Ads?” toggle form to visitors.
- Customise footer text shown when personalisation is on vs off.
- Restrict who can change ad settings via the *administer site configuration* permission.
- Verify a publisher ID is valid before ads are emitted site-wide.
- Combine block-level and page-level ads on the same site.
- Localise/translate the visitor-facing consent and personalisation copy.
- Disable ads quickly by clearing the publisher ID.
