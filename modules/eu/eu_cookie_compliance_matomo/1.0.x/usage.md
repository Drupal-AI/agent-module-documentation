EU Cookie Compliance Matomo bridges the EU Cookie Compliance and Matomo modules so Matomo analytics tracking only runs after the visitor gives cookie consent, using Matomo's consent API (`requireConsent` / `setConsentGiven`).

---

The module is a small glue layer with no UI beyond a single settings form. It depends on both `eu_cookie_compliance` and `matomo`. On every page it injects a small JavaScript snippet (via `hook_page_attachments_alter()`) that pushes to Matomo's `_paq` queue: it reads the EU Cookie Compliance consent cookie and, when consent has not been given, calls `_paq.push(['requireConsent'])` (and `_paq.push(['disableCookies'])` unless Matomo is already configured to disable cookies). The exact logic follows EU Cookie Compliance's consent `method`: in **opt-in** mode it checks the `cookie-agreed` cookie value; in **opt-in with categories** mode it checks the `cookie-agreed-categories` cookie against the categories selected on this module's settings form. Its only configuration is `eu_cookie_compliance_matomo.settings.categories` — the set of cookie categories that must be agreed for Matomo consent (form at `/admin/config/system/eu-cookie-compliance/matomo`, gated by EU Cookie Compliance's `administer eu cookie compliance popup` permission). A companion behavior (`eu_cookie_compliance_matomo.js`) then calls `_paq.push(['setConsentGiven'])` when the visitor clicks the EU Cookie Compliance "agree" or "save preferences" buttons for the relevant categories. Because the actual tracking is Matomo's and the banner is EU Cookie Compliance's, this module contributes only the consent wiring between them.

---

- Make Matomo analytics respect the site's EU Cookie Compliance consent banner.
- Withhold Matomo tracking cookies until the visitor opts in (GDPR compliance).
- Use Matomo's `requireConsent` so no tracking happens before consent.
- Grant Matomo consent automatically when the visitor clicks "Agree" on the cookie banner.
- Support category-based consent (opt-in with categories) for Matomo.
- Require specific cookie categories to be agreed before Matomo tracks.
- Disable Matomo cookies pre-consent via `disableCookies` unless already disabled in Matomo.
- Integrate consent for a self-hosted Matomo instance without custom JS.
- Track only visitors who explicitly consented to statistics/marketing categories.
- Call `setConsentGiven` when the user saves cookie preferences including the tracked categories.
- Keep Matomo's own privacy settings authoritative (skips `disableCookies` if Matomo disables cookies).
- Configure which categories map to Matomo consent at `/admin/config/system/eu-cookie-compliance/matomo`.
- Deploy the consent-category mapping as config (`eu_cookie_compliance_matomo.settings`).
- Comply with EU/ePrivacy rules for analytics without blocking the whole page.
- Combine a Matomo tag with a consent banner using only contrib modules.
- Avoid double-implementing consent logic across Matomo and the cookie banner.
- Ensure the Matomo tracking script is present before wiring consent (checks for `matomo_tracking_script`).
- Handle opt-in mode by reading the `cookie-agreed` cookie for consent state.
- Handle categories mode by reading the `cookie-agreed-categories` cookie.
- Give analytics teams consented-only Matomo data.
- Switch between opt-in and category consent behaviour by changing EU Cookie Compliance's method.
- Audit which categories are required for Matomo consent from one config value.
