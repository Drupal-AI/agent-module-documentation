<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ALTCHA Obfuscate adds field formatters that hide a field's value (email, phone, or plain string) behind ALTCHA's proof-of-work obfuscation, so scraper bots can't read it until a real visitor clicks to reveal it.

---

This submodule of ALTCHA provides three field formatters — `altcha_obfuscated_email` (for `email` fields, prefixes `mailto:`), `altcha_obfuscated_telephone` (for `telephone` fields, prefixes `tel:`), and `altcha_obfuscated_string` (for `string` fields) — selected on a bundle's *Manage display*. At render time the value is encrypted with AES-256-GCM (`ObfuscationUtility::encrypt()`, using `ext-openssl` and a proof-of-work-derived IV) and emitted inside an ALTCHA widget running the **obfuscation** plugin, with a "Click to reveal" button; the browser solves a small proof-of-work to decrypt and display the real value, so the plaintext never appears in the initial HTML. Each formatter has one setting, `reveal_text_override`, and it also reads global ALTCHA config (`altcha.settings`): `obfuscate_reveal_text` (default reveal button text), `obfuscate_max_number` (obfuscation complexity), `obfuscate_library_override`, plus `hide_logo`/`hide_footer` and the shared i18n labels. Floating mode is forced on for the obfuscation UI (per the ALTCHA docs). It depends on the parent `altcha` module and ships config schema for the three formatter settings but no settings page, permission, or Drush command of its own.

---

- Obfuscate a public "contact email" field so scrapers can't harvest the address.
- Hide a phone-number field behind a click-to-reveal proof-of-work.
- Protect a plain-text field (e.g. a support address) from bots on a public page.
- Show a "Click to reveal" button instead of a raw `mailto:` link.
- Keep email addresses out of the initial HTML source to reduce spam.
- Apply obfuscation per view mode (e.g. obfuscate on teaser, plain on full page).
- Reuse ALTCHA's proof-of-work mechanism for content protection, not just forms.
- Override the reveal button text per field with `reveal_text_override`.
- Set a global default reveal text via `altcha.settings:obfuscate_reveal_text`.
- Tune obfuscation difficulty with `altcha.settings:obfuscate_max_number`.
- Localize the reveal/verify labels through ALTCHA's i18n settings.
- Encrypt the value client-revealable with AES-256-GCM so it isn't plainly scrapable.
- Protect a directory of staff emails displayed on a page.
- Hide a telephone field on a high-traffic landing page from robocall harvesters.
- Combine with ALTCHA form CAPTCHA for both submission and display protection.
- Avoid third-party email-obfuscation services by keeping it self-hosted.
- Present obfuscated contact details that still resolve to `mailto:`/`tel:` on reveal.
- Deploy the formatter choice via exported view-display config.
- Hide the ALTCHA logo/footer on the reveal widget for a cleaner look.
- Provide accessible, no-image protection for sensitive on-page data.
