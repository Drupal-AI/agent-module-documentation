<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GDPR One Trust Implementation embeds the OneTrust consent banner/SDK on every page from an account UUID you paste into its settings form, and through its `onetrust_cookie_blocking` submodule holds back scripts and iframes until the visitor has consented to the matching cookie category.

---

Consent is two jobs and most implementations only do the first. Showing a banner and recording a choice is the visible half; the half that actually determines compliance is **not loading the tracker until the answer is yes**, because a banner over an analytics script that has already fired collects consent for something that already happened. This module is a thin bridge to the enterprise OneTrust product: `hook_page_attachments` writes OneTrust's own `<script>` tags into the page `<head>` (v1 loads `//cdn.cookielaw.org/consent/{uuid}.js`; v2 loads `otSDKStub.js` with `data-domain-script={uuid}` plus, optionally, `OtAutoBlock.js`), and the UUID is stored per interface language so a multilingual site can point each language at a different OneTrust script. The banner, preference centre, cookie table and the "block until consent" behaviour are all OneTrust's — Drupal only injects the loader and, in the submodule, reassigns Drupal-attached JS into OneTrust's `Optanon.InsertScript`/`Optanon.InsertHtml` queue keyed by category (2 performance, 3 functional, 4 targeting, 8 media) and deletes cookies of categories the visitor declined. Version **2.1.0** on core `^10 || ^11`, configured at `/admin/config/system/gdpr-onetrust` behind a `restrict access: TRUE` permission spelled `One Trust Access` (with a space and capitals — unusual for a permission machine name, worth knowing when writing a role's config by hand). Two things to verify rather than assume: **which scripts are actually blocked**, since only JS listed line-by-line in the submodule's `external_js_cookie` textarea (and a couple of hard-coded cases — Google Analytics when `google_analytics` is enabled, and `youtube`/`socialpollencount` iframes in node bodies) are governed — anything else a theme or module attaches still fires freely; and **caching**, because a consent decision is per-visitor and a page cached with a script tag in it will serve that script to everyone.

---

- Add a OneTrust consent banner to a Drupal site.
- Integrate an existing enterprise OneTrust account into Drupal.
- Load the OneTrust cookie-consent SDK (v1 or v2) from an account UUID.
- Enable OneTrust auto-blocking (`OtAutoBlock.js`) for a v2 account.
- Serve a different OneTrust script per interface language on a multilingual site.
- Hold back analytics JS until the visitor consents to the performance category.
- Hold back marketing/targeting scripts until opt-in.
- Categorise Drupal-attached JS files for consent (performance / functional / targeting / media).
- Gate Google Analytics behind consent when the `google_analytics` module is present.
- Delete cookies belonging to categories a visitor declined.
- Rewrite YouTube embeds in node bodies to `youtube-nocookie.com` and gate them (v2).
- Wrap `youtube`/`socialpollencount` iframes so they load only after consent.
- Show a "Cookie Settings" link/button that reopens the OneTrust preference centre.
- Render the OneTrust cookie table on a cookie-policy page (block or `<div id="ot-sdk-cookie-policy">`).
- Meet a corporate/group-wide cookie-policy standard with one consent tool.
- Support a legal team's OneTrust cookie register and scanning schedule.
- Comply with GDPR / ePrivacy on an EU-facing site.
- Prevent tracking before opt-in to reduce enforcement risk.
- Standardise consent behaviour across many Drupal sites in one organisation.
- Add a cookie-settings menu item to the account/footer menu.
- Point a staging site at a OneTrust test script via a `-test` UUID suffix.
- Block a specific third-party embed until its category is accepted.
- Programmatically queue a script or HTML block for OneTrust from custom code (`GdprBlockjs`).
