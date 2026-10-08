<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
cookies_etracker gates the etracker tracker behind COOKiES cookie consent, offering four "knockout modes" that trade accuracy for privacy before the visitor consents.

---

cookies_etracker is a submodule of the etracker project that connects the etracker tracker to the COOKiES
consent-management module. It registers an etracker cookie service inside COOKiES and adds a "Blocking mode"
option to the etracker settings form with four behaviours: track cookie-less before consent then switch to
cookies afterwards (most accuracy), do not track at all until consent then track cookie-less or with cookies
(most privacy / mixed), or ignore consent entirely (same as etracker alone). It implements this by either
toggling etracker's `data-block-cookies` flag on the COOKiES consent event, or by neutralising ("knocking out")
the etracker script tag until consent is given and then re-activating it in JavaScript. It depends on both the
`cookies` and `etracker` modules, and on install it enables etracker's "Disable cookies" setting so nothing is
tracked with cookies until you finish configuring consent.

---

- Gate the etracker tracker behind COOKiES cookie consent.
- Register etracker as a cookie service in the COOKiES consent UI.
- Add an "Advanced Disable cookies handling" / "Blocking mode" section to the etracker settings form.
- Choose "Most accuracy": cookie-less tracking before consent, cookies after consent.
- Choose "Most privacy": no tracking until consent, then cookie-less tracking.
- Choose "Mixed": no tracking until consent, then tracking with cookies.
- Choose "Ignore consent": behave exactly as etracker does without this submodule.
- Prevent the etracker snippet from running until the visitor consents (knockout).
- Re-activate ("heal") the knocked-out etracker script when consent is granted.
- Toggle etracker cookies on/off in the browser on consent change via `_etracker.enableCookies()`/`disableCookies()`.
- Disable tracking for the session when consent is revoked (`_etracker.disableTrackingForSession()`).
- Automatically enable etracker's "Disable cookies" setting on install.
- Warn the admin if the submodule is enabled but "Disable cookies" is unchecked (it would block nothing).
- Enforce the submodule as a dependency of the COOKiES analytics service (update hook).
- Store the chosen behaviour in `cookies_etracker.settings:knockout_mode`.
- Present GDPR/consent cookie information (cookie table) to visitors through COOKiES.
- Comply with cookie-consent requirements while still collecting analytics.
