<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cookie Consent Notice inserts a text notice, listing the cookies required and a link to the consent dialog, next to page elements that a cookie-consent tool (typically Cookiebot) has hidden.

---

Cookie Consent Notice is a small presentation add-on for cookie-consent workflows. When a consent tool such as Cookiebot blocks an embed (an iframe, a video, a widget) because the visitor has not opted in to the relevant cookie category, that content simply disappears with no explanation. This module runs a client-side script (`js/cookie_consent_notice.js`) that detects those blocked slots by their Cookiebot marker classes (`.cookieconsent-optin-preferences`, `.cookieconsent-optin-statistics`, `.cookieconsent-optin-marketing`) and appends a small notice `<div>` in their place. The notice shows an admin-configurable message, a link (`accept the following cookies:` by default) that calls `CookieConsent.renew()` to reopen the consent dialog, and a list of the exact cookie categories required to reveal the content. Once the visitor consents and the real element renders, the notice hides itself.

Admins tune the five display strings — message text, message link text, and the Preferences / Statistics / Marketing category labels — at `admin/config/cookie_consent_notice/adminsettings` (config object `cookie_consent_notice.settings`, form `CookieConsentNoticeForm`). Those values are pushed to the browser via `drupalSettings.cookieConsentNotice` by `hook_page_attachments_alter()`. The module is a UX cue only: it does not itself set, block, or read tracking cookies, and it relies on jQuery plus an underlying consent manager (Cookiebot) to actually gate scripts — a banner alone is not compliance. Note the module ships no `permissions.yml` even though its route requires `access cookie consent notice`, and its settings form has no config schema.

---

- Show a visible notice where a cookie-blocked embed would otherwise be silently missing.
- Explain to visitors why a video, iframe, or widget is not displaying.
- List the exact cookie categories (Preferences, Statistics, Marketing) required to reveal each blocked slot.
- Offer a one-click link that reopens the consent dialog via `CookieConsent.renew()`.
- Complement a Cookiebot integration with an in-context call to action.
- Customize the notice message text at `admin/config/cookie_consent_notice/adminsettings`.
- Customize the link text shown after the message.
- Rename the Preferences category label in the notice.
- Rename the Statistics category label in the notice.
- Rename the Marketing category label in the notice.
- Localize the notice strings (a Dutch `.po`/`.yml` translation ships with the module).
- Auto-hide the notice once the visitor consents and the real element renders.
- Improve GDPR/ePrivacy UX by giving blocked content a clear recovery path.
- Reduce confusion and support requests about "missing" content on consent-gated pages.
- Keep the notice presentation entirely client-side (no server round-trip per notice).
- Store no consent state itself — defer to the underlying consent manager's cookie.
- Attach the notice behaviour site-wide through the page-attachments hooks.
- Provide translatable category labels via `Drupal.t()` in the client script.
- Serve as a lightweight cue layer over any markup that uses Cookiebot's opt-in classes.
- Prompt visitors to update cookie preferences without leaving the page.
- Treat the module strictly as a consent-UX helper, not an access-control or tracking blocker.
