# How consent is wired to Matomo

The module contributes no tracking of its own — it injects a small JavaScript snippet and a behavior
that drive **Matomo's `_paq` consent API** based on **EU Cookie Compliance's** consent cookie.

## The injected snippet (`hook_page_attachments_alter`)

Built server-side and added to `html_head` (weight -10), wrapped in
`EuCookieComplianceMatomoJavaScriptSnippet` (a `MarkupInterface` that outputs the raw JS). It:

1. Defines a `getCookie()` helper.
2. Branches on `eu_cookie_compliance.settings: method`:
   - **`opt_in`** — reads the EU Cookie Compliance cookie (`cookie_name`, default `cookie-agreed`).
     If its value is not `'2'` (not fully agreed):
     ```js
     _paq.push(['requireConsent']);
     _paq.push(['disableCookies']);   // only if matomo.settings privacy.disablecookies is FALSE
     ```
   - **categories mode** (any other method) — reads `cookie-agreed-categories`, and if **all** the
     configured `categories` are not present, pushes the same `requireConsent` (+ optional
     `disableCookies`).

So before consent, Matomo is told to require consent and (usually) to disable cookies. It also passes
`matomo_tracking_script` (whether Matomo's tracking script is present) and the configured
`categories` to `drupalSettings.eu_cookie_compliance_matomo`.

## The behavior (`js/eu_cookie_compliance_matomo.js`)

`Drupal.behaviors.euCookieComplianceMatomo`: when the Matomo tracking script is present, after
`popup_delay`, it binds click handlers to EU Cookie Compliance's buttons:

- **`.agree-button`** (Accept all) → `_paq.push(['setConsentGiven'])`.
- **`.eu-cookie-compliance-save-preferences-button`** (Save preferences) → reads the checked
  category checkboxes and calls `setConsentGiven()` if any of the configured categories were chosen.

`setConsentGiven()` guards on `typeof _paq != 'undefined'`.

## Net effect

- No consent → `requireConsent` (+ `disableCookies`) → Matomo holds tracking.
- Visitor agrees (globally or for the required categories) → `setConsentGiven` → Matomo starts
  tracking. All of this is client-side against Matomo's own consent API; this module only supplies the
  wiring and the category list.
