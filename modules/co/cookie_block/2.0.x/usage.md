<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cookie Block adds a core block-visibility Condition plugin that shows or hides a block based on whether a named browser cookie matches a configured value.

---

Cookie Block ships a single Condition plugin (id `cookie`, label "Cookie") that appears in the Visibility section of every block-configuration form. You enter a Cookie ID (the cookie name) and a Cookie value; the condition returns TRUE when the incoming request carries that cookie and its value equals the configured one (with the standard "Negate the condition" checkbox to invert). It works across Drupal 8, 9, 10 and 11, has no dependencies beyond core, and requires no site-wide configuration — everything lives in the per-block condition settings. Because cookies are set and modified by the client (the visitor's browser), this is a presentation/UX condition; it governs block display only.

---

Use it to drive block visibility from cookie state, for example:

- Show a block only to visitors who have accepted a cookie-consent banner (e.g. cookie `cookie_agreed` = `1`).
- Hide a marketing block once a visitor has dismissed it (a "dismissed" cookie is set client-side).
- Show a "welcome back" block only when a returning-visitor cookie is present with the expected value.
- Reveal a promo or campaign block when a landing-page cookie flags the visitor as coming from a specific source.
- Toggle A/B-variant blocks by reading a bucket cookie set by an experimentation script.
- Show a locale/currency notice block based on a preference cookie set by front-end JS.
- Display a "complete your profile" block when an onboarding-step cookie has a given value.
- Hide a newsletter signup block for visitors whose "subscribed" cookie is set.
- Present a region-specific block when a geo cookie set by an edge/CDN rule matches.
- Show a beta-features announcement block only to users whose opt-in cookie is set.
- Reveal a support/chat block when a session cookie indicates an active support case.
- Gate a "download ready" block on a cookie set after a form submission.
- Combine (via multiple block conditions) a cookie check with path or role conditions for finer targeting.
- Use the Negate option to show a block only to visitors who do NOT have a given cookie/value.
- Show cookie-consent-dependent third-party embeds only after consent, as a purely visual/UX gate.
- Provide different header banners depending on a theme-preference cookie.
- Surface a "you left items in your cart" nudge block when a cart cookie is present.
- Show onboarding tips to first-time visitors identified by the absence of a "seen" cookie (via Negate).
- Drive site-building layouts where editors, not developers, control cookie-based visibility from the block UI.
