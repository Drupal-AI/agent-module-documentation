<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AntiBot Redirect intercepts requests to configured paths and, when the request has no same-site Referer, redirects the visitor to a reCAPTCHA "verify you are human" page before letting them through.

---

AntiBot Redirect is a lightweight, session-based bot gate for a hand-picked list of front-end paths. A kernel REQUEST event subscriber (`BotBlockSubscriber`) checks every main request: if the path matches one of the admin-configured protected paths (a newline-separated list with `*` wildcard support) and the request's `Referer` header does not point back to the site's own base URL, the subscriber issues a redirect to `/verify-human?destination=<original-uri>`. The verify page (`AntibotCheckForm`) shows an optional admin-authored description and a `recaptcha/reCAPTCHA` CAPTCHA; on success it stores `verified_human = TRUE` in the visitor's session and forwards them to their original destination. For the rest of that session the protected paths are served normally. Settings live at `/admin/config/system/antibot-redirect` (guarded by `administer site configuration`). The module depends on the reCAPTCHA contrib module and supports Drupal 10 and 11. Note that the gate keys off the spoofable `Referer` header and off a per-session flag — it is a light deterrent for casual crawlers, not a hard access control, and the request-interception path also disables the anonymous page cache for the matched requests.

---

- Require a reCAPTCHA challenge before serving a marketing landing page to first-time visitors.
- Protect a `/resources` or `/downloads` page from casual scraping bots.
- Gate a whole section with a wildcard path such as `/news/*`.
- Add human verification in front of a promo or campaign page without altering the node itself.
- Deter automated crawlers that arrive with no `Referer` header.
- Let visitors who navigate internally (same-site `Referer`) pass straight through without a challenge.
- Present a custom title and rich-text description on the verification page.
- Reuse an existing site-wide reCAPTCHA key configuration (via the reCAPTCHA module) for the challenge.
- Verify once per browser session, then browse all protected paths freely.
- Protect several unrelated paths at once by listing them one per line.
- Exempt admin pages, core assets, and public files automatically (they are never gated).
- Redirect verified visitors back to the exact URL they first requested.
- Keep authenticated editorial workflows untouched (admin routes are excluded).
- Stand up a quick "are you human" interstitial without writing custom code.
- Combine with the reCAPTCHA module's v2/v3 configuration for the actual bot scoring.
- Adjust the protected-path list at runtime from the settings form without a deploy.
- Localize or brand the verify page via the configurable description field.
- Use as a low-friction speed bump on paths that see automated abuse.
