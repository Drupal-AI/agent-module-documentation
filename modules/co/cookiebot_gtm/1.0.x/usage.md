<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cookiebot + GTM injects the Cookiebot consent script and the Google Tag Manager container together on every non-admin page, and can emit Google Consent Mode defaults so GTM tags fire according to the consent categories the visitor chose.

---

The module supplies the Drupal side of a common enterprise stack. **Cookiebot** (loaded from `consent.cookiebot.com/uc.js`, keyed by a Domain Group Id / `cbid`) scans the site, categorises cookies and shows the banner. **Google Tag Manager** (loaded from `googletagmanager.com`, keyed by a `GTM-XXXX` container id) is where marketing adds and removes tags without a deployment. This module drops both loaders into the page head via `hook_page_attachments_alter()`, plus the GTM `<noscript>` iframe into `page_top`, and — when Google **Consent Mode** is enabled — an inline `gtag("consent","default",…)` block whose six signals (`ad_personalization`, `ad_storage`, `ad_user_data`, `analytics_storage`, `functionality_storage`, `personalization_storage`) come from admin checkboxes. Both loaders carry `data-cookieconsent="ignore"`, so the actual consent enforcement is expected downstream — in each GTM tag's trigger and in Consent Mode — not by blocking the container. Everything is driven from one config object behind a dedicated `access cookiebot gtm config` permission (correctly `restrict access: TRUE`): the container id is pattern-validated `GTM-XXXX`, and there are options for a custom GTM hostname, a GTM environment (auth token + preview id), a per-language container id, and the banner language. A public `/cookie-declaration` page renders Cookiebot's `cd.js` declaration for the configured `cbid`. Two things to verify rather than assume: the consent signal must reach GTM before any tag can fire, or the first pageview leaks whatever the visitor later declines; and tags added in GTM that ignore the convention fire unconditionally, since the check lives in each trigger, not in this module.

---

- Load Cookiebot and Google Tag Manager together from one Drupal config screen.
- Add the GTM container by its `GTM-XXXX` id with format validation.
- Enable Google Consent Mode defaults for GTM tags.
- Set `analytics_storage` / `ad_storage` / `ad_user_data` / `ad_personalization` defaults to granted or denied.
- Gate marketing and analytics tags behind Cookiebot consent categories.
- Push a consent-default state to GTM's data layer before tags fire.
- Show a public cookie-declaration page at `/cookie-declaration`.
- Set the Cookiebot banner language to the current site language.
- Use a different GTM container id per language on a multilingual site.
- Point GTM at a custom hostname (server-side / first-party GTM).
- Load a specific GTM environment using an auth token and preview id.
- Choose Cookiebot auto vs manual cookie-blocking mode.
- Keep the consent scripts off admin routes automatically.
- Meet a GDPR requirement to block tags until opt-in.
- Support a marketing team's GTM tag workflow while staying compliant.
- Provide the noscript GTM iframe fallback.
- Reduce unconsented tracking on first pageview.
- Audit which cookies Cookiebot has categorised for the site.
- Restrict who can change consent/tag configuration to one dedicated permission.
- Stand up an enterprise consent + tag-manager architecture on Drupal.
