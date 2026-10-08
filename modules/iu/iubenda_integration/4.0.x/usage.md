<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Iubenda Integration wires a Drupal site to the third-party **Iubenda** privacy/compliance service: it renders Iubenda **privacy policy** links, injects the **Cookie Solution** consent banner, and can enable the **Consent Solution** — all configured from Drupal admin forms.

---

The module integrates the external Iubenda platform (you supply codes/ids generated in your
Iubenda dashboard). Its settings live under *Configuration → Services → Iubenda Integration*
with three forms: **General/Privacy** (`iubenda_integration.settings`, the privacy policy code,
link style, brand/legal-only flags, and which Drupal **form ids** get an Iubenda privacy-consent
checkbox), **Cookie solution** (`.../cookie-policy`, enable the cookie banner, `siteId`, the GDPR/
LGPD/FADP/US-state law toggles, banner position and buttons), and **Consent solution**
(`.../consent-solution`, the `api_key`). All three forms save into the **single config object
`iubenda_integration.settings`**. At runtime `hook_page_attachments()` loads Iubenda's JS
libraries (from `cdn.iubenda.com`) on non-admin pages when a policy code is set, passing the
cookie-banner config via `drupalSettings`; `hook_form_alter()` adds a required privacy-policy
consent element to the configured forms; and a response event subscriber runs Iubenda's PHP
cookie-class parser to lock scripts until consent. It also provides a **privacy-policy renderer
service** (`iubenda_integration.privacy_policy.renderer`), a **block** ("Iubenda Integration:
Privacy policy"), and a **`[site:iubenda_integration]` token** for embedding the privacy-policy
link. One permission, `administer iubenda_integration`, gates all three settings forms. It
depends on core **Block** and the `iubenda/iubenda-cookie-class` PHP library.

---

- Show an Iubenda-hosted **privacy policy** link on the site via a block.
- Inject the Iubenda **cookie consent banner** on all front-end pages.
- Comply with **GDPR** cookie-consent requirements using Iubenda's banner.
- Enable **LGPD** (Brazil), **FADP** (Switzerland), or **US state** privacy toggles.
- Add a required "I have read the Privacy Policy" checkbox to specific Drupal forms (by form id).
- Place the privacy-policy link in a region using the provided block, with custom pre/post text.
- Embed the privacy-policy link anywhere via the `[site:iubenda_integration]` token.
- Configure the cookie banner **position** (top, bottom, floating corners).
- Choose which banner **buttons** show (Accept, Reject, Customize, Close).
- Style the privacy-policy link (no style / white / black) to match the theme.
- Show "legal only" content or hide the Iubenda brand on the policy link.
- Enable the Iubenda **Consent Solution** with an API key to record consent proofs.
- Auto-block third-party scripts until the visitor consents (via the cookie-class parser).
- Use a radio instead of a checkbox for the form privacy element.
- Add background overlay behind the cookie banner.
- Keep Iubenda JS off admin pages (the module skips admin routes).
- Localise the privacy consent link prefix/suffix text.
- Manage all Iubenda settings from one Drupal admin section (three tabbed forms).
- Restrict who can change Iubenda settings via the `administer iubenda_integration` permission.
- Wire a multi-regulation cookie banner (GDPR+LGPD+US) from a single site id.
- Translate the Iubenda settings via config translation.
- Present the privacy checkbox on registration/contact forms to gate submission on consent.
