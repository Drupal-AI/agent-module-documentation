<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Shy One-Time stops crawlers, link scanners and preview bots from consuming a password-reset link before the person it was sent to has clicked it.

---

The failure is common and baffling to the user: they request a reset, open the email, click, and are told the link has already been used. Nobody used it — a corporate mail-security gateway, a link-preview service or a search bot followed the URL in transit, and Drupal duly marked it spent. This module intercepts requests to `user.reset` and `user.reset.login` on the kernel request event, denies access when `CrawlerDetect` recognises the caller and redirects to the login page when the User-Agent matches an administrator-configured list, so the token survives the visit. Version **2.0.4** on core `^9.5 || ^10 || ^11`, settings at `/admin/config/system/shy_one_time` behind `administer site configuration`. What deserves saying plainly is that this is a **trade, not a fix**: a link that survives being fetched by a third party is a link that third party could still use, and single-use is exactly what limits the damage when a reset URL leaks into a shared inbox, a forwarded message or a proxy log. The class of exempted callers is defined by a spoofable header, so it offers no assurance about who actually fetched the link — and a user whose real browser matches a configured pattern is redirected to login and can never complete their reset, so keep the pattern list narrow. There is also a logging flaw worth knowing about: the raw User-Agent is concatenated into the log message rather than passed as a placeholder, which puts unescaped anonymous input on the admin log page.

---

- Stop a mail scanner consuming a reset link.
- Fix "link already used" complaints.
- Protect one-time login links from bots.
- Reduce password-reset support tickets.
- Survive a corporate email gateway.
- Prevent link-preview services burning tokens.
- Exempt a known scanner user agent.
- Keep reset links usable in enterprise email.
- Reduce failed reset attempts.
- Handle a security appliance that follows links.
- Improve onboarding email reliability.
- Stop search crawlers hitting reset URLs.
- Log which agents reach the reset route.
- Support users behind a filtering proxy.
- Reduce repeat reset requests.
- Diagnose reset-link consumption.
- Keep account-activation links working.
- Improve first-login success rate.
